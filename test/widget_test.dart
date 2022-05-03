// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:hap_map/main.dart';

void main() {
  testWidgets('HapMap loading smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const HapMap());

    // Verify that HapMap is loaded and that the three buttons are showing
    expect(find.byKey(const Key('HapMap')), findsOneWidget);
    expect(find.byType(FloatingActionButton), findsNWidgets(3));
    expect(find.byKey(Key('SearchField')), findsOneWidget);
  });
}
