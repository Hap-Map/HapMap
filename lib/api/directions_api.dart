import 'package:dio/dio.dart';
import 'package:hap_map/api/location_api.dart';
import 'package:hap_map/models/directions_model.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hap_map/models/place_model.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hap_map/api/.key/maps.dart';

class DirectionsAPI {
  static const String _directionsUrl = 'https://maps.googleapis.com/maps/api/directions/json?';
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
  
}
