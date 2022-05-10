import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter/material.dart';
import 'package:hap_map/pages/confirm_page.dart';
import 'package:hap_map/pages/navigation_page.dart';
import 'package:hap_map/pages/search_page.dart';
import 'package:hap_map/pages/settings_page.dart';

double DEVICE_WIDTH = double.infinity;
double DEVICE_HEIGHT = double.infinity;

Future main() async {
  await dotenv.load(fileName: ".env");
  runApp(const HapMap());
}

class HapMap extends StatelessWidget {
  const HapMap({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      key: const Key('HapMap'),
      initialRoute: SearchPage.id,
      routes: {
        SearchPage.id : (context) => const SearchPage(),
        SettingsPage.id : (context) => const SettingsPage(),
        ConfirmPage.id : (context) =>  ConfirmPage(),
        NavigationPage.id : (context) => const NavigationPage()
      },
    );
  }
}
