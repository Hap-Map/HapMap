import 'package:flutter/foundation.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


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

  @override
  bool operator ==(Object other) =>
      other is Step &&
      startLocation == other.startLocation &&
      endLocation == other.endLocation &&
      duration == other.duration &&
      distance == other.distance &&
      htmlInstructions == other.htmlInstructions;


  @override
  int get hashCode => htmlInstructions.hashCode;
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

  @override operator==(Object other) =>
    other is Directions &&
    totalDistance == other.totalDistance &&
    totalDuration == other.totalDuration &&
    totalSteps.length == other.totalSteps.length &&
    polylineEncoded == other.polylineEncoded &&
    listEquals(totalSteps, other.totalSteps);

  @override
  int get hashCode => polylineEncoded.hashCode;
}

class DirectionsIterator {
  late Directions directions;
  late int index;
  late int numSteps;
  late double curStepSize;

  DirectionsIterator(Directions? d) {
    // print(d.toString());
    directions = d!;
    index = 0;
    numSteps = directions.totalSteps.length;
    curStepSize = getStepSize()!;
  }

  bool isGood() {
    return numSteps > 0;
  }

  String? getStepTime() {
      if (numSteps == 0) {
        return null;
      }
      assert(index < numSteps);
      return directions.totalSteps[index].duration;
  }

  String? getStepDistance() {
    if (numSteps == 0) {
      return null;
    }
    assert(index < numSteps);
    return directions.totalSteps[index].distance;
  }

  void moveNext() {
    index++;
    curStepSize = getStepSize()!;
  }

  bool hasNext() {
    if (index < numSteps - 1) {
      return true;
    }
    return false;
  }

  String? getCurrentInstruction() {
    if (numSteps == 0) {
      return null;
    }
    assert(index < numSteps);
    return directions.totalSteps[index].htmlInstructions;
  }

  String? getNextInstruction() {
    if (numSteps == 0) {
      return null;
    }
    assert(index < numSteps);
    if (index == numSteps - 1) {
      return directions.totalSteps[index].htmlInstructions;
    }
    return directions.totalSteps[index + 1].htmlInstructions;
  }

  LatLng? getStepStart() {
    if (numSteps == 0) {
      return null;
    }
    assert(index < numSteps);
    // print(directions.totalSteps[index].startLocation);
    return directions.totalSteps[index].startLocation;
  }

  LatLng? getStepEnd() {
    if (numSteps == 0) {
      // If there are no routes available, total steps is empty
      // We therefore don't have a step destination point or destination point
      // This case shouldn't happen since we don't search for locations that are unreachable
      return null;
    }
    assert(index < numSteps);
    // print(directions.totalSteps[index].endLocation);
    return directions.totalSteps[index].endLocation;
  }

  double? getStepSize() {
    if (numSteps == 0) {
      return null;
    }
    assert (index < numSteps);
    return Geolocator.distanceBetween(
        directions.totalSteps[index].startLocation.latitude,
        directions.totalSteps[index].startLocation.longitude,
        directions.totalSteps[index].endLocation.latitude,
        directions.totalSteps[index].endLocation.longitude);
  }

  LatLng? getNextEnd() {
    if (numSteps == 0) {
      return null;
    }
    assert (index < numSteps - 1);
    return directions.totalSteps[index + 1].endLocation;
  }
}

