import 'package:flutter/material.dart';
import 'package:hap_map/api/directions_api.dart';
import 'package:hap_map/constants.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../api/location_api.dart';
import '../api/directions_api.dart';
import '../models/directions_model.dart';

class ConfirmPage extends StatelessWidget {
  static const id = 'confirm_page';
  const ConfirmPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List _arguments = ModalRoute.of(context)!.settings.arguments as List;
    Position _position = _arguments[0];
    String _search = _arguments[1];
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
                        borderRadius: BorderRadius.circular(10)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          // TODO: Get the chosen destination
                          Text('Destination:', style: kTitleStyle.copyWith(fontSize: 32),),
                          Text(_search, style: kTitleStyle.copyWith(fontSize: 32), softWrap: true,),
                          SizedBox(height: 25),
                          Text('Estimated Time: '
                              + getEstimatedTime().toString()
                              + ' minutes',
                            style: kSubTitleStyle.copyWith(fontSize: 28),
                            textAlign: TextAlign.start, softWrap: true,),
                          // TODO: Get the current location displayed
                          Text('Starting From: ' + _position.toString(),
                            style: kSubTitleStyle.copyWith(fontSize: 28),
                            textAlign: TextAlign.start, softWrap: true,),
                          SizedBox(height: 25),
                          TextButton(onPressed: () {
                            Navigator.pushNamed(context, 'navigation_page');
                          }, style: kRedButtonStyle,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                                child: Text('Start Navigation',
                                    style:
                                    kTitleStyle.copyWith(color: Colors.white,
                                        fontSize: 32)
                                )
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              )
              
            ),
          ],
        ),
      ),
    );
  }

  // TODO: use the Google API to get an estimated travel time
  // TODO: replace dest with chosen destination's lat/long
  // issue: not actually getting the positions, only going to the second return
  int getEstimatedTime() {
    LocationApi.getCurrentLocation().then((Position location) {
      var og = LatLng(location.latitude, location.longitude);
      var dest = LatLng(og.latitude, og.longitude);
      Future<Directions?> dir = DirectionsAPI().getDirections(origin: og, destination: dest);
      dir.then((Directions? d) {
        return d!.totalDuration;
      });
    });
    return -1;
  }

  // TODO: convert lat/long to address
  // issue: not actually getting the positions, only going to the second return
  // link for getting address: https://www.digitalocean.com/community/tutorials/flutter-geolocator-plugin
  _getUserLocation() {
    LocationApi.getCurrentLocation().then((Position location) {
      return "LAT: ${location.latitude}, LNG: ${location.longitude}";
    });
    return "No location";
  }
}
