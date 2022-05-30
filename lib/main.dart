import 'package:flutter/material.dart';
import 'package:hap_map/pages/confirm_page.dart';
import 'package:hap_map/pages/help_page.dart';
import 'package:hap_map/pages/navigation_page.dart';
import 'package:hap_map/pages/search_page.dart';
import 'package:hap_map/pages/settings_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool first = !prefs.containsKey('first_run');
  prefs.setBool('first_run', false);
  runApp(HapMap(firstRun: first));
}

class HapMap extends StatelessWidget {
  final bool firstRun;
  HapMap({Key? key, this.firstRun = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      key: const Key('HapMap'),
      // TODO: Add TutorialPage here vvv
      initialRoute: firstRun? HelpPage.id : SearchPage.id,
      routes: {
        SearchPage.id: (context) => const SearchPage(),
        HelpPage.id: (context) => const HelpPage(),
        SettingsPage.id: (context) => SettingsPage(),
        ConfirmPage.id: (context) => ConfirmPage(),
        NavigationPage.id: (context) => const NavigationPage()
      },
    );
  }
}
