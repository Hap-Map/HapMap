import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hap_map/constants.dart';
import 'package:hap_map/main.dart';
import 'package:hap_map/models/directions_model.dart';

import '../api/location_api.dart';
import '../api/place_api.dart';

class NavigationPage extends StatefulWidget {
  static const id = 'navigation_page';

  const NavigationPage({Key? key}) : super(key: key);

  @override
  State<NavigationPage> createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  Position? _currentPosition;
  String _currentPositionName = "Finding Current Location...";
  String _destination = "Loading Destination...";
  Directions? _directions;

  _NavigationPageState() {
    LocationApi.addOnLocationUpdateListener(onLocationUpdated);
    LocationApi.startLocationUpdates();
  }

  get endNavigationButton => TextButton(
        child: const Text(
          'End Navigation',
          style: kTitleStyle,
        ),
        onPressed: () {
          LocationApi.stopLocationUpdates();
          LocationApi.removeOnLocationUpdateListener(onLocationUpdated);
          Navigator.popUntil(context, ModalRoute.withName('search_page'));
          SemanticsService.announce("Ending navigation", TextDirection.ltr);
        },
        style: kRedButtonStyle,
      );

  @override
  Widget build(BuildContext context) {
    if (_currentPosition == null) {
      List _arguments = ModalRoute.of(context)!.settings.arguments as List;
      _currentPosition = _arguments[0];
      _currentPositionName = _arguments[1];
      _destination = _arguments[2].name;
      _directions = _arguments[3];
    }

    return Scaffold(
        body: PageBackground(
            child: Column(
      children: [
        Card(
          margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 24.0),
          shadowColor: Colors.blueGrey,
          child: MergeSemantics(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                      width: DEVICE_WIDTH,
                      child: Text("NOW: Prepare to turn right onto NE 45th St",
                          style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.w700,
                              color: Colors.black),
                          textAlign: TextAlign.center)),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Column(
                    children: [
                      Container(
                          width: DEVICE_WIDTH,
                          child: Text("To: " + _destination,
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black),
                              textAlign: TextAlign.center)),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                            width: DEVICE_WIDTH,
                            child: Text("Current Location: " + _currentPositionName,
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black),
                                textAlign: TextAlign.center)),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        endNavigationButton,
        Semantics(
          child: const Image(
            image: AssetImage('images/hapticTouchButton.png'),
            height: 250,
            alignment: Alignment.bottomCenter),
          label: 'Keep finger on the screen for haptic feedback',
        ),
      ],
    )));
  }

  onLocationUpdated(pos) {
    PlaceApi.getPlace(pos).then((place) => setState(() {
          _currentPosition = pos;
          _currentPositionName = place.name;
        }));
  }
}
