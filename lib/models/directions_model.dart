import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/foundation.dart';


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

  DirectionsIterator(Directions? d) {
    directions = d!;
    index = 0;
    numSteps = directions.totalSteps.length;
  }

  bool moveNext() {
    if (index >= numSteps) {
      return false;
    }
    print("move next");
    index++;
    return true;
  }

  bool hasNext() {
    if (index < numSteps) {
      return true;
    }
    return false;
  }

  String getStepStr() {
    print(index);
    if (index >= numSteps) {
      // iterator has reached end of steps so return empty string so last step isnt displayed
      return "";
    }
    return directions.totalSteps[index].htmlInstructions;
  }

  String getStepTime() {
    if (index >= numSteps) {
      return "";
    }
    return directions.totalSteps[index].duration;
  }

  String getStepDistance() {
    if (index >= numSteps) {
      return "";
    }
    return directions.totalSteps[index].distance;
  }

  LatLng? getStepEnd() {
    if (numSteps == 0) {
      // If there are no routes available, total steps is empty
      // We therefore don't have a step destination point or destination point
      // This case shouldn't happen since we don't search for locations that are unreachable
      return null;
    }
    assert(index < numSteps);
    print(directions.totalSteps[index].endLocation);
    return directions.totalSteps[index].endLocation;
  }

  LatLng? getStepStart() {
    if (numSteps == 0) {
      return null;
    }
    assert(index < numSteps);
    print(directions.totalSteps[index].startLocation);
    return directions.totalSteps[index].startLocation;
  }
  
}

