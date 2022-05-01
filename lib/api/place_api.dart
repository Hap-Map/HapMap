import 'dart:async';
import 'package:dio/dio.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hap_map/models/place_model.dart';
import 'package:hap_map/api/.key/maps.dart';
import 'package:geolocator/geolocator.dart';
import 'location_api.dart';

class PlaceApi {
  static const String NO_RESULTS_FOUND = 'No Results Found';
  static const String _placeSuggestionsUrl = 'https://maps.googleapis.com/maps/api/place/autocomplete/json?';
  static const String _addressUrl = 'https://maps.googleapis.com/maps/api/place/details/json?';
  static const String _nearbySearchUrl = "https://maps.googleapis.com/maps/api/place/nearbysearch/json";
  static const int searchRadius = 8000; // default search radius 8000 meters (5 miles) from current location

  static Future<List<Place?>> getPlaceSuggestions(input) async {
    Dio _dio = Dio();
    Position position = await LocationApi.getCurrentLocation();

    Response response = await _dio.get(
      _placeSuggestionsUrl,
      queryParameters: {
        'input': input,
        'location': '${position.latitude}, ${position.longitude}',
        'radius': 'searchRadius',
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

  /*
    TODO: Change to accept Position, i.e getAddress(Position p)
          maybe overload with getAddress(double lat, double lng)
  */

  // Returns the address of the nearest place to position
  static Future<String> getNearbyAddress(Position position) async {
    Place nearbyPlace = await nearbySearch(position);
    if (nearbyPlace.name != NO_RESULTS_FOUND) {
      return getAddress(nearbyPlace);
    }
    throw Exception("No Results Found- No Address nearby");
  }

  // Returns the address of any place ID
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

  // Returns a place_id and description (place) of nearest google place
  // Input must have a latitude and longitude (either Position or LatLng)
  // Used as a helper function for getNearbyAdress but can also be used to get the place ID of the nearest location
  static Future<Place> nearbySearch(position) async {
    Dio _dio = Dio();
    Response response;
    if (position.runtimeType == Position || position.runtimeType == LatLng) {
      response = await _dio.get(
        _nearbySearchUrl,
        queryParameters: {
          'location': '${position.latitude}, ${position.longitude}',
          'rankby': 'distance',
          'key': MAPS_API_KEY,
        },
      );
    } else {
      throw Exception("Unsupported input- Nearby Search needs input with latitude and longitude");
    }

    if (response.statusCode == 200) {
      Map<String, dynamic> json = response.data;
      var result = json['results'][0];
      if (result.isNotEmpty) {
        return Place.fromNearby(result);
      }
    }
    throw Exception("No Results Found- No Place Nearby");
  }
}