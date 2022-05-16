import 'package:flutter/material.dart';
import 'package:hap_map/pages/confirm_page.dart';
import 'package:hap_map/pages/help_page.dart';
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
      key: const Key('HapMap'),
      initialRoute: SearchPage.id,
      routes: {
        SearchPage.id: (context) => const SearchPage(),
        HelpPage.id: (context) => const HelpPage(),
        SettingsPage.id: (context) => const SettingsPage(),
        ConfirmPage.id: (context) => ConfirmPage(),
        NavigationPage.id: (context) => const NavigationPage()
      },
    );
  }
}
