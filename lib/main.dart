import 'package:flutter/material.dart';
import 'package:hap_map/search_page.dart';
import 'package:hap_map/settings_page.dart';

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
        SettingsPage.id : (context) => const SettingsPage()
      },
    );
  }
}
