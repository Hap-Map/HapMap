import 'package:dio/dio.dart';
import 'package:hap_map/directions_model.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapsAPI {
  static const String _directionsUrl = 'https://maps.googleapis.com/maps/api/directions/json?';
  late Dio _dio;

  MapsAPI() {
    _dio = Dio();
  }

  Future<Directions?> getDirections({required LatLng origin, required LatLng destination,}) async {
    Response response = await _dio.get(
      _directionsUrl,
      queryParameters: {
        'origin': '${origin.latitude},${origin.longitude}',
        'destination': '${destination.latitude},${destination.longitude}',
        // TODO: Add API Key for Google Cloud when running
        'key': "",
        'mode': 'walking',
      },
    );
    if (response.statusCode == 200) {
      return Directions.fromMap(response.data);
    }
  }
}
