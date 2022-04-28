import 'dart:async';
import 'package:dio/dio.dart';
import 'package:hap_map/models/place_model.dart';
import 'package:hap_map/api/.key/maps.dart';
import 'package:geolocator/geolocator.dart';
import 'location_api.dart';

class PlaceApi {
  static const String _placesUrl = 'https://maps.googleapis.com/maps/api/place/autocomplete/json?';
  static const String _addressUrl = 'https://maps.googleapis.com/maps/api/place/details/json?';
  static const int searchRadius = 8000; // default search radius 8000 meters (5 miles) from current location

  static Future<List<Place?>> getPlaceSuggestions(input) async {
    Dio _dio = Dio();
    Position position = await LocationApi.getCurrentLocation();

    Response response = await _dio.get(
      _placesUrl,
      queryParameters: {
        'input': input,
        'location': '${position.latitude}, ${position.longitude}',
        'radius': '$searchRadius',
        'key': MAPS_API_KEY,
      },
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> json = response.data;
      List<Place> result = [];
      for (var p in json['predictions']) {
        result.add(Place.fromSearch(p));
      }
      return result;
    } else {
      throw Exception("Invalid Response Code from API- Place Suggestions");
    }
  }

  static Future<String> getAddress(Place p) async {
    Dio _dio = Dio();
    Response response = await _dio.get(
      _addressUrl,
      queryParameters: {
        'place_id': p.id,
        'key': MAPS_API_KEY,
      },
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> json = response.data;
      var result = json['result'];
      return result['formatted_address'];
    } else {
      throw Exception("Invalid Response Code from API- Address Search");
    }
  }
}