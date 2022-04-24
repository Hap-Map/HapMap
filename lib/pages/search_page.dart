import 'package:flutter/material.dart';
import 'package:hap_map/api/location_api.dart';
import 'package:hap_map/pages/settings_page.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import '../api/place_api.dart';
import '../models/place_model.dart';
import '../constants.dart';

class SearchPage extends StatefulWidget {

  static const id = 'search_page';
  static final TextEditingController searchController =
      TextEditingController();
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}


class _SearchPageState extends State<SearchPage> {
  Widget get searchBar => Expanded(
        child: TypeAheadField<Place?>(
          textFieldConfiguration: TextFieldConfiguration(
            controller: SearchPage.searchController,
            autofocus: true,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              hintText: 'Where would you like to go?',
              hintStyle: const TextStyle(
                color: Colors.black,
              ),
            ),
            onSubmitted: (search) {
              Navigator.pushNamed(context, 'confirm_page');
            }
          ),
          suggestionsCallback: PlaceApi.getPlaceSuggestions,
          itemBuilder: (context, Place? suggestion) {
            final place = suggestion!;

            return ListTile(
              leading: const Icon(Icons.place),
              title: Text(place.name),
            );
          },
          onSuggestionSelected: (Place? suggestion) {
            final place = suggestion!;
            SearchPage.searchController.text = place.name;
          },
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
    LocationApi.getCurrentLocation();
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
              IntrinsicHeight(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: searchBar
                ),
              ),
              micButton,
              Align(
                alignment: Alignment.topCenter,
                child: TextButton(
                    // TODO: IMPLEMENT TUTORIAL?
                    onPressed: () {},
                    style: kButtonStyle,
                    child: const Padding(
                      padding: EdgeInsets.all(6.0),
                      child: Text(
                        'How to use HapMap?',
                        style: kSubTitleStyle,
                      ),
              )))
            ],
        ),
      ),
    );
  }
}


