import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hap_map/constants.dart';
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

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    double deviceHeight = MediaQuery.of(context).size.height;
    double elementHeightSpacing = deviceHeight * 0.05;
    double innerBoxTextWidth = deviceWidth * 0.65;
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
        SizedBox(height: elementHeightSpacing),
        Align(
          alignment: Alignment.topCenter,
          child: SizedBox(
            height: deviceHeight * 0.07,
            width: deviceWidth * 0.5,
            child: TextButton(
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
            ),
          ),
        ),
        SizedBox(height: elementHeightSpacing),
        Container(
            height: deviceHeight * 0.4,
            width: deviceWidth * 0.8,
            color: Colors.transparent,
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xfff7f9f7),
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: MergeSemantics(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    FittedBox(
                        child: Container(
                            width: innerBoxTextWidth,
                            child: Text("To: " + _destination,
                                style: const TextStyle(
                                    fontSize: 26,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                                textAlign: TextAlign.left))),
                    FittedBox(
                        child: Container(
                            width: innerBoxTextWidth,
                            child: const Text("NOW: Prepare to turn right onto NE 45th St",
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black),
                                textAlign: TextAlign.left))),
                    FittedBox(
                        child: Container(
                            width: innerBoxTextWidth,
                            child: Text("Current Location: " + _currentPositionName,
                                style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black),
                                textAlign: TextAlign.left))),
                  ],
                ),
              ),
            )),
        Semantics(
            child: const Image(
              image: AssetImage('images/hapticTouchButton.png'),
              height: 250,
              alignment: Alignment.bottomCenter),
          label: 'Keep finger on the screen for haptic feedback',
        )
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
