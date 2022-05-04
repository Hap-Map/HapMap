import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hap_map/constants.dart';

import '../api/location_api.dart';
import '../api/place_api.dart';
import '../models/place_model.dart';

class ConfirmPage extends StatefulWidget {
  static String id = 'confirm_page';
  ConfirmPage({Key? key}) : super(key: key);
  late Place search;

  @override
  State<ConfirmPage> createState() => _ConfirmPageState();
}

class _ConfirmPageState extends State<ConfirmPage> {
  Place? _currentPosition;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    LocationApi.addOnLocationUpdateListener((p0) => updatePosition(p0));
  }
  @override
  Widget build(BuildContext context) {
    List _arguments = ModalRoute.of(context)!.settings.arguments as List;
    _currentPosition ??= _arguments[0];
    widget.search = _arguments[1];
    LocationApi.onLocationUpdateListeners;
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
                            Text('Destination:',
                              style: kTitleStyle.copyWith(fontSize: 32),),
                            Text(widget.search.name,
                              style: kTitleStyle.copyWith(fontSize: 32),
                              softWrap: true,),
                            SizedBox(height: 25),
                            // TODO: Get the estimated travel time
                            Text('Estimated Time: '
                                //+ getEstimatedTime().toString()
                                + ' minutes',
                              style: kSubTitleStyle.copyWith(fontSize: 28),
                              textAlign: TextAlign.start, softWrap: true,),
                            // TODO: Get the current location as address
                            Text('Starting From: ' + _currentPosition!.name,
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

  // TODO: WHY DOES THIS NOT WORK? ADITYA? >:[
  updatePosition(Position p0) {
    print("updating position");
    PlaceApi.getPlace(p0).then((value) {
      setState(() {
        _currentPosition = value;
      });
    });
  }
}

//   // issue: not actually getting the positions, only going to the second return
//   int getEstimatedTime() {
//     LocationApi.getCurrentLocation().then((Position location) {
//       var og = LatLng(location.latitude, location.longitude);
//       var dest = LatLng(og.latitude, og.longitude);
//       Future<Directions?> dir = DirectionsAPI().getDirections(origin: og, destination: dest);
//       dir.then((Directions? d) {
//         return d!.totalDuration;
//       });
//     });
//     return -1;
//   }
//
//   // issue: not actually getting the positions, only going to the second return
//   // link for getting address: https://www.digitalocean.com/community/tutorials/flutter-geolocator-plugin
//   _getUserLocation() {
//     LocationApi.getCurrentLocation().then((Position location) {
//       return "LAT: ${location.latitude}, LNG: ${location.longitude}";
//     });
//     return "No location";
//   }
// }
