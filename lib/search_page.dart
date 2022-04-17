import 'package:flutter/material.dart';
import 'package:hap_map/settings_page.dart';

import 'constants.dart';

class SearchPage extends StatefulWidget {
  static const id = 'search_page';
  static late final TextEditingController searchController =
      TextEditingController();
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  Widget get searchBar => Expanded(
        child: TextField(
          controller: SearchPage.searchController,
          decoration: const InputDecoration(
              filled: true,
              fillColor: kSecondaryColor,
              prefixIcon: Icon(
                Icons.search,
                color: kPrimaryColor,
              ),
              border: OutlineInputBorder(
                gapPadding: 0,
              ),
              hintText: 'Search'
              //labelText: 'Search',
              ),
        ),
      );
  Widget get micButton => TextButton(
      // TODO: IMPLEMENT SPEECH TO TEXT
      onPressed: () {},
      child: const Icon(
        Icons.mic,
        size: 40,
      ),
      style: kButtonStyle);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: kPrimaryColor,
        child: const Icon(
          Icons.settings,
        ),
        // TODO: IMPLEMENT SETTINGS PAGE
        onPressed: () {
          Navigator.pushNamed(context, SettingsPage.id);
        },
      ),
      body: PageBackground(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Text('Where would you like to go?', style: kTitleStyle),
            Column(
              children: [
                IntrinsicHeight(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [searchBar, micButton],
                    ),
                  ),
                ),
                Align(
                    alignment: Alignment.topCenter,
                    child: TextButton(
                        // TODO: IMPLEMENT TUTORIAL?
                        onPressed: () {},
                        style: kButtonStyle,
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            'How to use HapMap?',
                            style: kSubTitleStyle,
                          ),
                        )))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
