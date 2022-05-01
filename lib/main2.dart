import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hap_map/api/directions_api.dart';
import 'package:hap_map/api/location_api.dart';
import 'package:geolocator/geolocator.dart';
import 'models/directions_model.dart';


void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter Google Maps Demo',
      home: MapSample(),
    );
  }
}

class MapSample extends StatefulWidget {
  const MapSample({Key? key}) : super(key: key);

  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  final Completer<GoogleMapController> _controller = Completer();

  final LatLng destPoint = const LatLng(37.79237188407873, -122.41017632083135);  // Tonga Room San Francisco

  late Position _startingPosition;
  var currentLat;
  var currentLong;


  Directions? _directions;
  late Marker _origin;
  late Marker _destination;

  late final CameraPosition _cameraPosition;

  @override
  void initState() {
    super.initState();
    initializeLocation();
   // initializeRoute();
  }

  initializeLocation() async {
    await LocationApi.getCurrentLocation().then((Position pos) async {
      setState(() {
        _startingPosition = pos;
        currentLat = pos.latitude;
        currentLong = pos.longitude;

        _cameraPosition = CameraPosition(
            tilt: 192,
            target: LatLng(currentLat, currentLong),
            zoom: 20.0);

        _origin = Marker(
          markerId: MarkerId("Origin"),
          position: LatLng(currentLat, currentLong)
        );

        _destination = Marker(
          markerId: MarkerId("Destination"),
          position: destPoint,
        );
      });
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          GoogleMap(
           // mapType: MapType.hybrid,
            myLocationEnabled: true,
            initialCameraPosition: _cameraPosition,
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
            markers: {
              _origin,
              _destination,
            },
            polylines: {
              if (_directions != null)
                Polyline(
                  polylineId: const PolylineId("Route"),
                  color: Colors.blue,
                  width: 10,
                  points: _directions!.getPolylines(),
                ),
            },
          ),

          Positioned(
            top: 20.0,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 6.0,
                  horizontal: 12.0,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20.0),
                  boxShadow: const[
                    BoxShadow(
                      color: Colors.black,
                      offset: Offset(0,2),
                      blurRadius: 6.0,
                    )
                  ],
                ),
                child: Text(
                  '$currentLat, $currentLong',
                  style: const TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w600
                  ),
                ),
              ),
            ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _tryRoute,
        label: const Text('Route'),
        icon: const Icon(Icons.map),
      ),
    );
  }


  _tryRoute() async {
    Directions? dir = await DirectionsAPI().getDirections(origin: _startingPosition, destination: destPoint);
    setState(() {
      _directions = dir!;
    });
  }

}

