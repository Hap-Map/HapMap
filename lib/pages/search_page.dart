import 'package:flutter/material.dart';
import 'package:hap_map/api/location_api.dart';
import 'package:hap_map/pages/settings_page.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:geolocator/geolocator.dart';
import '../api/place_api.dart';
import '../models/place_model.dart';
import '../constants.dart';
import 'confirm_page.dart';

class SearchPage extends StatefulWidget {
  static const id = 'search_page';
  static final TextEditingController searchController = TextEditingController();
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late Position _startingPosition;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      LocationApi.getCurrentLocation().then((value) => _startingPosition = value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: 'btn1',
            backgroundColor: kPrimaryColor,
            child: const Icon(
              Icons.mic,
            ),
            // TODO: IMPLEMENT SETTINGS PAGE
            onPressed: () {
              Navigator.pushNamed(context, SettingsPage.id);
            },
          ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: FloatingActionButton(
            heroTag: 'btn2',
            backgroundColor: kPrimaryColor,
            child: const Icon(
              Icons.settings,
            ),
            // TODO: IMPLEMENT SETTINGS PAGE
            onPressed: () {
              Navigator.pushNamed(context, SettingsPage.id);
            },
          ),
        ),
        ]
      ),
      body: PageBackground(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IntrinsicHeight(
              child: Padding(
                  padding: const EdgeInsets.all(16.0), child: searchBar),
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
  Widget get searchBar => TypeAheadField<Place?>(
    textFieldConfiguration: TextFieldConfiguration(
        controller: SearchPage.searchController,
        autofocus: true,
        decoration: InputDecoration(
          fillColor: Colors.white,
          focusedBorder: kInputBorderStyle,
          filled: true,
          focusColor: Colors.black,
          border: kInputBorderStyle,
          hintText: 'Where would you like to go?',
          hintStyle: const TextStyle(
            color: Colors.black,
          ),
        ),
        onSubmitted: (search) {
          Navigator.pushNamed(context, ConfirmPage.id, arguments: [_startingPosition, search]);
        }),
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
  );

  Widget get micButton => TextButton(
    // TODO: IMPLEMENT SPEECH TO TEXT
      onPressed: () {},
      child: const Icon(
        Icons.mic,
        size: 40,
      ),
      style: kButtonStyle);
}
