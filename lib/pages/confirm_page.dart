import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hap_map/constants.dart';
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
  Place? _current;
  Place? _destination;
  String? _estimatedTime;
  Directions? _directions;

  @override
  Widget build(BuildContext context) {
    if (_position == null) {
      List _arguments = ModalRoute.of(context)!.settings.arguments as List;

      Position origin = _arguments[0];
      Place destination = _arguments[1];

      setState(() {
        _destination = _arguments[1];
        _position = _arguments[0];
      });

      PlaceApi.getPlace(_position).then((place) => setState(() {
            _current = place;
          }));

      LocationApi.addOnLocationUpdateListener(onLocationUpdated);

      getDirections(origin, destination);
    }

    return Scaffold(
      body: PageBackground(
        child: Column(
          children: [
            Align(alignment: Alignment.topLeft, child: BackButton()),
            Expanded(
                child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: FittedBox(
                fit: BoxFit.contain,
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          'Destination:',
                          style: kTitleStyle.copyWith(fontSize: 32),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          child: Text(
                              _destination != null
                                  ? _destination!.name
                                  : "Loading Destination...",
                              style: kTitleStyle.copyWith(fontSize: 25),
                              softWrap: true,
                              textAlign: TextAlign.center),
                        ),
                        SizedBox(height: 25),
                        Text(
                          _estimatedTime != null
                              ? 'Estimated Time: ' + _estimatedTime!
                              : "Loading Estimated Time...",
                          style: kSubTitleStyle.copyWith(fontSize: 28),
                          textAlign: TextAlign.start,
                          softWrap: true,
                        ),
                        Text(
                          _current != null
                              ? 'Starting From: ' + _current!.name
                              : "Finding Current Location...",
                          style: kSubTitleStyle.copyWith(fontSize: 28),
                          textAlign: TextAlign.start,
                          softWrap: true,
                        ),
                        SizedBox(height: 25),
                        TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, NavigationPage.id,
                                arguments: [
                                  _position,
                                  _current,
                                  _destination,
                                  _directions
                                ]);
                          },
                          style: kBlueButtonStyle,
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


  @override
  void dispose() {
    super.dispose();
    LocationApi.removeOnLocationUpdateListener(onLocationUpdated);
  }

  onLocationUpdated(Position pos) {
    setState(() {
      _position = pos;
      PlaceApi.getPlace(_position).then((place) => setState(() {
            _current = place;
            getDirections(_position, _destination);
          }));
    });
  }

  getDirections(origin, destination) {
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
}
