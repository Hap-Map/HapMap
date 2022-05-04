import 'package:dio/dio.dart';
import 'package:hap_map/api/location_api.dart';
import 'package:hap_map/models/directions_model.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hap_map/models/place_model.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hap_map/api/.key/maps.dart';

class DirectionsAPI {
  static const String _directionsUrl = 'https://maps.googleapis.com/maps/api/directions/json?';
  static const String _snapToRoads = 'https://roads.googleapis.com/v1/snapToRoads?';
  late Dio _dio;

  DirectionsAPI() {
    _dio = Dio();
  }


  Future<Directions?> getDirections({LatLng? origin, required Place destination,}) async {
    if (origin == null) {
      Position position = await LocationApi.getCurrentLocation();
      origin = LatLng(position.latitude, position.longitude);
    }

    Response response = await _dio.get(
        _directionsUrl,
        queryParameters: {
          'origin': '${origin.latitude},${origin.longitude}',
          'destination': 'place_id:${destination.id}',
          'key': MAPS_API_KEY,
          'mode': 'walking',
        },
    );

    if (response.statusCode == 200) {
      return Directions.fromMap(response.data);
    } else {
      throw Exception('Invalid Response code from API- Direction Search');
    }
  }

  Future<List<LatLng>> getPolylines(Directions directions) async {
    print(directions);
    String path = "";
    for (int i = 0; i < directions.totalSteps.length; i++) {
      if (i == 0) {
        path += directions.totalSteps[i].startLocation.latitude.toString();
        path += ",";
        path += directions.totalSteps[i].startLocation.longitude.toString();
        path += "|";
      }
      path += directions.totalSteps[i].endLocation.latitude.toString();
      path += ",";
      path += directions.totalSteps[i].endLocation.longitude.toString();

      if (i < directions.totalSteps.length - 1) {
        path += "|";
      }
    }
    Response response = await _dio.get(
      _snapToRoads,
      queryParameters: {
        'interpolate': true,
        'path': path,
        'key': MAPS_API_KEY,
      }
    );

    if (response.statusCode == 200) {
      List<LatLng> polylines = [];
      Map<String, dynamic> map = response.data;
      if ((map['snappedPoints'] as List).isNotEmpty) {
        for (var i in map['snappedPoints']) {
          polylines.add(LatLng(i['location']['latitude'], i['location']['longitude']));
        }
      }
      return polylines;
    } else {
      throw Exception('Invalid Response Code from API- Polyline Search');
    }
  }
}
