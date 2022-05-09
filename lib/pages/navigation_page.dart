import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:geolocator/geolocator.dart';
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

class _NavigationPageState extends State<NavigationPage> {
  Position? _currentPosition;
  Place? _current;
  Place? _destination;
  Directions? _directions;
  DirectionsIterator? _iter;

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
        },
        style: kRedButtonStyle,
      );


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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                    width: DEVICE_WIDTH,
                    child: Html(data: _iter!.getStepStr(),
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
            ],
          ),
        ),
        endNavigationButton,
        IconButton(
          icon: Image.asset('images/hapticTouchButton.png'),
          iconSize: 250,
          onPressed: () {},
          alignment: Alignment.bottomCenter,
        )
      ],
    )));
  }

  onLocationUpdated(pos) {
    PlaceApi.getPlace(pos).then((place) => setState(() {
         _currentPosition = pos;
          _current = place;
          // TODO: CHECK IF END OF STEP IS REACHED AND UPDATE
        }));
  }

}
