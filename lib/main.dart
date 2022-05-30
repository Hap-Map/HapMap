import 'package:flutter/material.dart';
import 'package:hap_map/pages/confirm_page.dart';
import 'package:hap_map/pages/help_page.dart';
import 'package:hap_map/pages/navigation_page.dart';
import 'package:hap_map/pages/search_page.dart';
import 'package:hap_map/pages/settings_page.dart';
import 'package:hap_map/pages/tutorial_page1.dart';
import 'package:hap_map/pages/tutorial_page2.dart';
import 'package:is_first_run/is_first_run.dart';

void main() {
  runApp(const HapMap());
}

class HapMap extends StatelessWidget {
  const HapMap({Key? key}) : super(key: key);

  Future<bool> _checkFirstLaunch() async {
    return await IsFirstRun.isFirstCall();
  }

  @override
  Widget build(BuildContext context) {
    Future<bool> isFirst = _checkFirstLaunch();
    var firstRoute = SearchPage.id;
    if (isFirst == true) {
      firstRoute == TutorialPage1.id;
    }
    return MaterialApp(
      key: const Key('HapMap'),
      initialRoute: firstRoute,
      routes: {
        SearchPage.id: (context) => const SearchPage(),
        HelpPage.id: (context) => const HelpPage(),
        SettingsPage.id: (context) => SettingsPage(),
        ConfirmPage.id: (context) => ConfirmPage(),
        NavigationPage.id: (context) => const NavigationPage(),
        TutorialPage1.id: (context) => const TutorialPage1(),
        TutorialPage2.id: (context) => const TutorialPage2()
      },
    );
  }
}
