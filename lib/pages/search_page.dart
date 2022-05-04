import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:hap_map/api/location_api.dart';
import 'package:hap_map/pages/settings_page.dart';

import '../api/place_api.dart';
import '../constants.dart';
import '../models/place_model.dart';
import 'confirm_page.dart';

class SearchPage extends StatefulWidget {
  static const id = 'search_page';
  static final TextEditingController searchController = TextEditingController();
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String _search = "";
  Place? _startingPlace;

  @override
  void initState() {
    super.initState();
    setState(() {
      LocationApi.getCurrentLocation().then((location) =>
      PlaceApi.getPlace(location).then((place) => _startingPlace = place));
    });
    LocationApi.startLocationUpdates();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              FloatingActionButton(
                shape: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(100)),
                heroTag: 'btn1',
                backgroundColor: kPrimaryColor,
                child: const Icon(
                  Icons.mic,
                  size: 30,
                ),
                // TODO: IMPLEMENT SPEECH-TO-TEXT
                onPressed: () {},
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: FittedBox(
                  fit: BoxFit.cover,
                  child: FloatingActionButton(
                    heroTag: 'btn2',
                    backgroundColor: kPrimaryColor,
                    child: const Icon(
                      Icons.settings,
                      size: 30,
                    ),
                    // TODO: IMPLEMENT SETTINGS PAGE
                    onPressed: () {
                      Navigator.pushNamed(context, SettingsPage.id);
                    },
                  ),
                ),
              ),
            ]
        ),
        body: PageBackground(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Align(alignment: Alignment.topRight, child: FloatingActionButton(onPressed: () {  },
                mini: true,
                shape: CircleBorder(),
                backgroundColor: Colors.grey[800],
              child: Text('?', style: TextStyle(color: Colors.white, fontSize: 25),),)),
              Padding(
                  padding: const EdgeInsets.all(16.0), child: searchBar),
              Expanded(child: Image(image: AssetImage('images/hapmap_logo.png'),))
              // TODO: ADD NO INPUT ERROR AND MAKE THIS BUTTON BEAUTIFUL
              //TextButton(onPressed: () => _search != ''? _onSubmitted(_search) : /* TODO: NO INPUT ERROR */ _search = '', child: Text('GO', style: kSubTitleStyle,), style: kRedButtonStyle,)
            ],
          ),
        ),
      ),
    );
  }
  void _onSubmitted (Place search) async {
    if (_startingPlace == null) {
      await LocationApi.getCurrentLocation().then((loc) => {
      PlaceApi.getPlace(loc).then((place) => Navigator.pushNamed(context, ConfirmPage.id,
      arguments: [place, search]))
      });
    } else {
      Navigator.pushNamed(context, ConfirmPage.id,
          arguments: [_startingPlace, search]);
    }
  }

  Widget get searchBar =>
      TypeAheadField<Place?>(
        key: const Key('SearchField'),
        textFieldConfiguration: TextFieldConfiguration(
            controller: SearchPage.searchController,
            autofocus: false,
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
        onChanged: (input) => _search = input),
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
          _search = place.name;
          _onSubmitted(suggestion);
        },
      );
}