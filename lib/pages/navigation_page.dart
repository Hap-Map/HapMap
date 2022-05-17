import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter_platform_interface/src/types/location.dart';
import 'package:hap_map/constants.dart';
import 'package:hap_map/models/directions_model.dart';

import '../api/location_api.dart';
import '../api/place_api.dart';
import '../models/place_model.dart';

class NavigationPage extends StatefulWidget {
  static const id = 'navigation_page';

  const NavigationPage({Key? key}) : super(key: key);

  @override
  State<NavigationPage> createState() => _NavigationPageState();
}

double METERS_TO_UPDATE_PLACE = 100;
double METERS_EPSILON = 2.5;

class _NavigationPageState extends State<NavigationPage> {
  Position? _lastPosUpdated;
  Position? _currentPosition;
  Place? _current;
  Place? _destination;
  Directions? _directions;
  DirectionsIterator? _iter;
  bool _destination_reached = false;

  get endNavigationButton => TextButton(
        child: const Text(
          'End Navigation',
          style: kTitleStyle,
        ),
        onPressed: () {
          Navigator.popUntil(context, ModalRoute.withName('search_page'));
          SemanticsService.announce("Ending navigation", TextDirection.ltr);
        },
        style: kRedButtonStyle,
      );

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    LocationApi.addOnLocationUpdateListener(onLocationUpdated);
  }

  @override
  Widget build(BuildContext context) {
    if (_currentPosition == null) {
      List _arguments = ModalRoute.of(context)!.settings.arguments as List;
      _currentPosition = _arguments[0];
      _lastPosUpdated = _currentPosition;
      _current = _arguments[1];
      _destination = _arguments[2];
      _directions = _arguments[3];
      _iter = DirectionsIterator(_directions);
    }

    return Scaffold(
        body: PageBackground(
            child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Column(
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
                          width: MediaQuery.of(context).size.width,
                          child: Html(
                              data: _destination_reached
                                  ? '<html><body></b>Destination Reached</b></body></html>'
                                  : _iter!.getStepStr(),
                              style: {
                                "body": Style(
                                    fontSize: FontSize(25),
                                    fontWeight: FontWeight.w700,
                                    color: Colors.black,
                                    textAlign: TextAlign.center)
                              }),
                        )),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Column(
                        children: [
                          Container(
                              width: MediaQuery.of(context).size.width,
                              child: Text(
                                  _destination != null
                                      ? "To: " + _destination!.name
                                      : "Loading Destination...",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black),
                                  textAlign: TextAlign.center)),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                                width: MediaQuery.of(context).size.width,
                                child: Text(
                                    _current != null
                                        ? "Current Location: " + _current!.name
                                        : "Finding Current Location...",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black),
                                    textAlign: TextAlign.center)),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            endNavigationButton,
          ],
        ),
        TextButton(
            onPressed: () {},
            child: Icon(
              Icons.touch_app_rounded,
              color: Colors.white,
              size: 100,
              semanticLabel: 'Keep finger on the screen for haptic feedback'
            ),
            style: TextButton.styleFrom(
                shape: CircleBorder(),
                backgroundColor: kHapticTouchIconColor))
      ],
    )));
  }

  @override
  void dispose() {
    super.dispose();
    LocationApi.removeOnLocationUpdateListener(onLocationUpdated);
  }

  onLocationUpdated(Position pos) {
    setState(() {
      _currentPosition = pos;
    });
    if (isCloseEnough(_iter!.getStepEnd()!, pos)) {
      if (_iter!.hasNext()) {
        setState(() {
          _iter!.moveNext();
          updatePlace(pos);
        });
      } else {
        setState(() {
          _destination_reached = true;
        });
      }
    }
    if (isFarEnough(_lastPosUpdated!, pos)) {
      updatePlace(pos);
    }
  }

  bool isFarEnough(Position p1, Position p2) {
    return distance(p1, p2) > METERS_TO_UPDATE_PLACE;
  }

  double distance(Position p1, Position p2) {
    return Geolocator.distanceBetween(
        p1.latitude, p1.longitude, p2.latitude, p2.longitude);
  }

  double distanceLatLng(LatLng p1, Position p2) {
    return Geolocator.distanceBetween(
        p1.latitude, p1.longitude, p2.latitude, p2.longitude);
  }

  bool isCloseEnough(LatLng p1, Position p2) {
    return distanceLatLng(p1, p2) < METERS_EPSILON;
  }

  void updatePlace(Position pos) {
    PlaceApi.getPlace(pos).then((place) => setState(() {
          _currentPosition = pos;
          _lastPosUpdated = _currentPosition;
          _current = place;
        }));
  }
}
