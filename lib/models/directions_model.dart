import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

const int epsilon = 1; // degrees we allow step coordinates to differ

class Step{
  final LatLng startLocation;
  final LatLng endLocation;
  final String duration;
  final String distance;
  final String htmlInstructions;

  Step(this.startLocation, this.endLocation, this.duration, this.distance, this.htmlInstructions,);

  @override
  String toString(){
    return "{start: $startLocation, end: $endLocation, dur: $duration, distance: $distance, html: $htmlInstructions}}";
  }

  bool equals({otherStep}) {
    if (otherStep != null && otherStep.runtimeType == Step) {
      if (compareLatLng(o1: startLocation, o2: otherStep.startLocation)) {
        if (compareLatLng(o1: endLocation, o2: otherStep.endLocation)) {
          if (duration == otherStep.duration && distance == otherStep.distance && htmlInstructions == otherStep.htmlInstructions) {
                return true;
              }
            }
          }
        }
    return false;
  }

  bool compareLatLng({required LatLng o1, required LatLng o2}) {
    if (o1.runtimeType == LatLng && o2.runtimeType == LatLng) {
      if(Geolocator.distanceBetween(o1.latitude, o1.longitude, o2.latitude, o2.longitude) < epsilon) {
        return true;
      }
    }
    return false;
  }
}

class Directions {
  final String totalDistance;
  final String totalDuration;
  final List<Step> totalSteps;
  final String polylineEncoded;

  const Directions({
    required this.totalDistance,
    required this.totalDuration,
    required this.totalSteps,
    required this.polylineEncoded,
  });

  factory Directions.fromMap(Map<String, dynamic> map) {
    String distance = '';
    String duration = '';
    List<Step> steps = [];
    String polylineStr = "";


    if ((map['routes'] as List).isNotEmpty) {
      // Get route information
      final data = Map<String, dynamic>.from(map['routes'][0]);
      polylineStr = data['overview_polyline']['points'];
      if ((data['legs'] as List).isNotEmpty) {
        final leg = data['legs'][0];
        distance = leg['distance']['text'];
        duration = leg['duration']['text'];
        for (var i in leg['steps']) {
          Step s = (Step(
              LatLng(i['start_location']['lat'], i['start_location']['lng']),
              LatLng(i['end_location']['lat'], i['end_location']['lng']),
              i['duration']['text'],
              i['distance']['text'],
              i['html_instructions'],
          ));
          steps.add(s);
        }
      }
    }
    return Directions(
      totalDistance: distance,
      totalDuration: duration,
      totalSteps: steps,
      polylineEncoded: polylineStr,
    );
  }

  List<LatLng> getPolylinePoints() {
    List<LatLng> points = [];
    for (var value in PolylinePoints().decodePolyline(polylineEncoded)) {
      points.add(LatLng(value.latitude, value.longitude));
    }
    return points;
  }

  @override
  String toString(){
    return "{total dur: $totalDuration, total distance: $totalDistance, steps ${totalSteps.toString()}, polyline: $polylineEncoded";
  }

  bool equals(other) {
    if (other != null && other.runtimeType == Directions) {
      if (totalDistance == other.totalDistance && totalDuration == other.totalDuration) {
        if (other.totalSteps != null && totalSteps.length == other.totalSteps.length && polylineEncoded == other.polylineEncoded) {
          for (int i = 0; i < totalSteps.length; i++) {
            if (!totalSteps[i].equals(otherStep: other.totalSteps[i])) {
              return false;
            }
          }
          return true;
        }
      }
    }
    return false;
  }
}

