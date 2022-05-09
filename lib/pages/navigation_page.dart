import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter_platform_interface/src/types/location.dart';
import 'package:hap_map/constants.dart';
import 'package:hap_map/main.dart';
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
double METERS_EPSILON = 10;

class _NavigationPageState extends State<NavigationPage> {
  Position? _currentPosition;
  Place? _current;
  Place? _destination;
  Directions? _directions;
  DirectionsIterator? _iter;
  bool _destination_reached = false;

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
  void initState() {
    // TODO: implement initState
    super.initState();
    LocationApi.addOnLocationUpdateListener(onLocationUpdated);
    LocationApi.startLocationUpdates();
  }


  @override
  Widget build(BuildContext context) {
    if (_currentPosition == null) {
      List _arguments = ModalRoute.of(context)!.settings.arguments as List;
      _currentPosition = _arguments[0];
      _current = _arguments[1];
      _destination = _arguments[2];
      _directions = _arguments[3];
      _iter = DirectionsIterator(_directions);
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
                    child: Html(data: _destination_reached? '<html><body></b>Destination Reached</b></body></html>' : _iter!.getStepStr(),
                        style: {
                            "body" : Style(
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
                        width: DEVICE_WIDTH,
                        child: Text(_destination != null? "To: " + _destination!.name : "Loading Destination...",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                                color: Colors.black),
                            textAlign: TextAlign.center)),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                          width: DEVICE_WIDTH,
                          child: Text(_current != null? "Current Location: " + _current!.name: "Finding Current Location...",
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black),
                              textAlign: TextAlign.center)),
                    ),
                  ],
                ),
              ),
          ],),
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

  onLocationUpdated(Position pos) {
    Position _old = _currentPosition!;
    setState(() {
      _currentPosition = pos;
    });
    if (isFarEnough(_old, pos)) {
      PlaceApi.getPlace(pos).then((place) =>
          setState(() {
            _currentPosition = pos;
            _current = place;
          }));
    } else if (isCloseEnough(_iter!.getStepEnd()!, pos)) {
      if (_iter!.hasNext()) {
        _iter!.moveNext();
      } else {
        _destination_reached = true;
      }
    }
  }

  bool isFarEnough(Position p1, Position p2) {
    return distance(p1, p2) > METERS_TO_UPDATE_PLACE;
  }

  double distance(Position p1, Position p2) {
    return Geolocator.distanceBetween(p1.latitude, p1.longitude, p2.latitude, p2.longitude);
  }
  double distanceLatLng(LatLng p1, Position p2) {
    return Geolocator.distanceBetween(p1.latitude, p1.longitude, p2.latitude, p2.longitude);
  }

  bool isCloseEnough(LatLng p1, Position p2) {
    return distanceLatLng(p1, p2) < METERS_EPSILON;
  }

}
