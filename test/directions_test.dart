import 'package:flutter_test/flutter_test.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hap_map/models/place_model.dart';

void main() {
  // origin and destination can be position or latlng
  Position p1 = Position();
  Position p2 = Position();

  LatLng destLL = LatLng();
  Place destPlace;



  group('Normal Case', () {
    test('Position origin, Position destination', () {

    });
    test('Position origin, LatLng destination', () {

    });
    test('Position origin, Place destination', () {

    });
  });

  group('Origin == Destination', () {
    test('Position origin, Position destination', () {

    });
    test('Position origin, LatLng destination', () {

    });
    test('Position origin, Place destination', () {

    });
  });

  group('No Routes', () {
    LatLng noRouteLatLng = LatLng();
    Position noRoutePos = Position();
    Place noRoutePlace;
    test('Position origin, Position destination', () {

    });
    test('Position origin, LatLng destination', () {

    });
    test('Position origin, Place destination', () {

    });
  });

  group('No walkable routes', () {
    LatLng noWalkableLatLng = LatLng();
    Position noWalkablePos = Position();
    Place noWalkablePlace;

    test('Position origin, Position destination', () {

    });
    test('Position origin, LatLng destination', () {

    });
    test('Position origin, Place destination', () {

    });
  });

}
