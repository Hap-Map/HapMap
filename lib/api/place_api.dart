import 'dart:async';

import 'package:dio/dio.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hap_map/api/place_model.dart';


class PlaceApi {
  static const String _placesUrl = 'https://maps.googleapis.com/maps/api/place/autocomplete/json?';
  static const int searchRadius = 8000; // default search radius 8000 meters (5 miles) from current location
  static const LatLng curLocation = LatLng(40.749155758479624, -73.98549273861835);




  static Future<List<Place?>> getPlaceSuggestions(input) async {
    Dio _dio = Dio();
    Response response = await _dio.get(
      _placesUrl,
      queryParameters: {
        'input': input,
        'location': '${curLocation.latitude}, ${curLocation.longitude}',
        'radius': '$searchRadius',
        'key': 'AIzaSyBYjWOnNhxj6jWjjpdm-awhqXc82aDysfo',
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
      throw Exception("Invalid Response Code from API");
    }
  }
}