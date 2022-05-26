// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:geolocator/geolocator.dart';

import 'package:hap_map/main.dart';
import 'package:hap_map/models/place_model.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hap_map/api/place_api.dart';
import 'package:hap_map/pages/confirm_page.dart';



void main() {
  Position originPosition = Position(longitude: -122.30589365409594 , latitude: 47.6534424035837, timestamp: DateTime.now(), accuracy: 100, altitude: 100, heading: 100, speed: 10, speedAccuracy: 10);
  Place originPlace = Place(name: "Paul G. Allen Center for Computer Science & Engineering", id: "ChIJf_BRMu0UkFQRSlDYGi2L3hI");
  Place resultPlace = Place(name: "University Book Store, University Way NE, Seattle, WA, USA", id: "ChIJjwucI4sUkFQR6pdUeAufRqg");


  testWidgets('HapMap loading smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const HapMap());

    // Verify that HapMap is loaded and that the three buttons are showing
    expect(find.byKey(const Key('HapMap')), findsOneWidget);
    expect(find.byType(FloatingActionButton), findsNWidgets(2));
    expect(find.byKey(const Key('SearchField')), findsOneWidget);
  });

  //not working yet because tester not waiting for API call
  testWidgets('Confirmation page widget test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const HapMap());
    
    // Added Input in the search bar
    await tester.enterText(find.byKey(const Key('SearchField')), "a");
    
    //await tester.pump(const Duration(minutes: 10));


    final listFinder = find.byKey(const Key('SearchSuggestion'));
    //await tester.pumpAndSettle();
    //await tester.pumpWidget(HapMap(home: SearchPage(child: Container())));
    final BuildContext context = tester.element(find.byType(Container));
    Navigator.pushNamed(context, ConfirmPage.id,
        arguments: [originPosition, resultPlace]);

    await tester.runAsync(() async {
      tester.pump(const Duration(minutes: 1));
    });

    await tester.tap(listFinder.first);

    // Test widgets on the confirmation page
    expect(find.byType(TextButton), findsOneWidget);
    expect(find.byType(BackButton), findsOneWidget);

    // tester taps the 'Start Navigation Button'
    await tester.tap(find.byType(TextButton));

    // Test widgets on the navigation page
    expect(find.byKey(const Key('EndNavigation')), findsOneWidget);
    expect(find.byKey(const Key('HapticButton')), findsOneWidget);

    // tester taps the 'End Navigation Button'
    await tester.tap(find.byKey(const Key('EndNavigation')));

    // Verify that app goes back to search page
    expect(find.byKey(const Key('HapMap')), findsOneWidget);
  });
}
