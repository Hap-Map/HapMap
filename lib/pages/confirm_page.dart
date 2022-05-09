import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hap_map/constants.dart';
import 'package:hap_map/main.dart';
import 'package:hap_map/pages/navigation_page.dart';

import '../api/directions_api.dart';
import '../api/location_api.dart';
import '../api/place_api.dart';
import '../models/directions_model.dart';
import '../models/place_model.dart';

class ConfirmPage extends StatefulWidget {
  static const id = 'confirm_page';

  const ConfirmPage({Key? key}) : super(key: key);

  @override
  State<ConfirmPage> createState() => _ConfirmPageState();
}

class _ConfirmPageState extends State<ConfirmPage> {
  Position? _position;
  String _positionName = "Finding Current Location...";
  Place? _destination;
  String _destinationName = "Loading Destination...";
  String _estimatedTime = "Loading Estimated Time...";
  Directions? _directions;

  @override
  Widget build(BuildContext context) {
    if (_position == null) {
      List _arguments = ModalRoute.of(context)!.settings.arguments as List;

      Position origin = _arguments[0];
      Place destination = _arguments[1];

      setState(() {
        _destination = _arguments[1];
        _destinationName = _arguments[1].name;
        _position = _arguments[0];
      });

      PlaceApi.getPlace(_position).then((place) => setState(() {
            _positionName = place.name;
          }));

      LocationApi.startLocationUpdates();
      LocationApi.addOnLocationUpdateListener((pos) => setState(() {
            _position = pos;
            PlaceApi.getPlace(_position).then((place) => setState(() {
                  _positionName = place.name;
                }));
          }));

      DirectionsAPI()
          .getDirections(
              origin: LatLng(origin.latitude, origin.longitude),
              destination: destination)
          .then((directions) {
        setState(() {
          _directions = directions;
          _estimatedTime = directions!.totalDuration;
        });
      });
    }

    return Scaffold(
      body: PageBackground(
        child: Column(
          children: [
            Align(alignment: Alignment.topLeft, child: BackButton()),
            Expanded(
                child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: FittedBox(
                fit: BoxFit.contain,
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          'Destination:',
                          style: kTitleStyle.copyWith(fontSize: 32, fontWeight: FontWeight.w700),
                          textAlign: TextAlign.center,
                        ),
                        Container(
                          width: DEVICE_WIDTH,
                          child: Text(
                            _destinationName,
                            style: kTitleStyle.copyWith(fontSize: 25),
                            softWrap: true,
                              textAlign: TextAlign.center
                          ),
                        ),
                        SizedBox(height: 25),
                        Text(
                          'Estimated Time: ' + _estimatedTime,
                          style: kSubTitleStyle.copyWith(fontSize: 28),
                          textAlign: TextAlign.start,
                          softWrap: true,
                        ),
                        Text(
                          'Starting From: ' + _positionName,
                          style: kSubTitleStyle.copyWith(fontSize: 28),
                          textAlign: TextAlign.start,
                          softWrap: true,
                        ),
                        SizedBox(height: 25),
                        TextButton(
                          onPressed: () {
                            LocationApi.stopLocationUpdates();
                            Navigator.pushNamed(context, NavigationPage.id,
                                arguments: [
                                  _position,
                                  _positionName,
                                  _destination,
                                  _directions
                                ]);
                          },
                          style: kRedButtonStyle,
                          child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('Start Navigation',
                                  style: kTitleStyle.copyWith(
                                      color: Colors.white, fontSize: 32))),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            )),
          ],
        ),
      ),
    );
  }
}
