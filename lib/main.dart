import 'package:flutter/material.dart';
import 'package:hap_map/pages/confirm_page.dart';
import 'package:hap_map/pages/navigation_page.dart';
import 'package:hap_map/pages/search_page.dart';
import 'package:hap_map/pages/settings_page.dart';

void main() {
  runApp(const HapMap());
}

class HapMap extends StatelessWidget {
  const HapMap({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: SearchPage.id,
      routes: {
        SearchPage.id : (context) => const SearchPage(),
        SettingsPage.id : (context) => const SettingsPage(),
        ConfirmPage.id : (context) => const ConfirmPage(),
        NavigationPage.id : (context) => const NavigationPage()
      },
    );
  }
}
