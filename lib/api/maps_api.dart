import 'dart:js_util';

import 'package:dio/dio.dart';
import 'package:hap_map/api/directions_model.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hap_map/api/place_model.dart';

import 'package:hap_map/api/.key/maps.dart';

class MapsAPI {
  static const String _directionsUrl = 'https://maps.googleapis.com/maps/api/directions/json?';
  late Dio _dio;

  MapsAPI() {
    _dio = Dio();
  }

  Future<Directions?> getDirections({required LatLng origin, required destination,}) async {
    Response response;
    if (instanceof(destination, LatLng)) {
      response = await _dio.get(
        _directionsUrl,
        queryParameters: {
          'origin': '${origin.latitude},${origin.longitude}',
          'destination': '${destination.latitude},${destination.longitude}',
          // TODO: Add API Key to api/.key/maps.dart
          'key': MAPS_API_KEY,
          'mode': 'walking',
        },
      );
    } else if (instanceof(destination, Place)) {
      response = await _dio.get(
        _directionsUrl,
        queryParameters: {
          'origin': '${origin.latitude},${origin.longitude}',
          'destination': 'place_id:${destination.id}',
          // TODO: Add API Key to api/.key/maps.dart
          'key': MAPS_API_KEY,
          'mode': 'walking',
        },
      );
    } else if (instanceof(destination, String)) {
      // should be an address string with + to denote spaces
      response = await _dio.get(
        _directionsUrl,
        queryParameters: {
          'origin': '${origin.latitude},${origin.longitude}',
          'destination': destination,
          // TODO: Add API Key to api/.key/maps.dart
          'key': MAPS_API_KEY,
          'mode': 'walking',
        },
      );
    } else {
      throw Exception('Invalid destination. Unable to search');
    }
    if (response.statusCode == 200) {
      return Directions.fromMap(response.data);
    }
  }

}
