import 'dart:async';

import 'package:permission_handler/permission_handler.dart';
import 'package:geolocator/geolocator.dart';
import 'package:location/location.dart' as l;

class LocationApi {

  static List onLocationUpdateListeners = [];
  static StreamSubscription<Position>? positionStream;

  static Future<bool> getLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return requestLocationService();
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return false;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      openAppSettings();
      return false;
    }

    return true;
  }

  static Future<bool> requestLocationService() async {
    l.Location location = l.Location();
    bool _serviceEnabled = await location.requestService();

    if (!_serviceEnabled) {
      return false;
    }

    return true;
  }

  static Future<Position> getCurrentLocation() async {
    if (await getLocationPermission()) {
      return Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    } else {
      return Future.error('Unable to get user location');
    }
  }

  static startLocationUpdates() async {
    if (await getLocationPermission()) {
      positionStream ??= Geolocator.getPositionStream(desiredAccuracy: LocationAccuracy.high,
                distanceFilter: 100).listen(
                    (Position? position) {
                  for (var onLocationUpdateListener in LocationApi
                      .onLocationUpdateListeners) {
                    onLocationUpdateListener(position);
                  }
                });
    } else {
      return Future.error('Unable to get user location');
    }
  }

  static stopLocationUpdates() {
      positionStream?.pause();
  }

  static addOnLocationUpdateListener(Function(Position) onLocationUpdateListener) {
    LocationApi.onLocationUpdateListeners.add(onLocationUpdateListener);
  }

  static removeOnLocationUpdateListener(onLocationUpdateListener) {
    if (LocationApi.onLocationUpdateListeners.isNotEmpty) {
      LocationApi.onLocationUpdateListeners.remove(onLocationUpdateListener);
    }
  }
}
