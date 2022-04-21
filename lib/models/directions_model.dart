import 'package:google_maps_flutter/google_maps_flutter.dart';

class Step{
  final LatLng startLocation;
  final LatLng endLocation;
  final String duration;
  final String distance;
  final String htmlInstructions;
  final String maneuver;

  Step(this.startLocation, this.endLocation, this.duration, this.distance, this.htmlInstructions, this.maneuver);
}

class Directions {
  final String totalDistance;
  final String totalDuration;
  final List<Step> totalSteps;

  const Directions({
    required this.totalDistance,
    required this.totalDuration,
    required this.totalSteps,
  });

  factory Directions.fromMap(Map<String, dynamic> map) {
    // Check if route is not available
    if ((map['routes'] as List).isEmpty) {
      throw Exception('No Routes Match Query');
    }

    // Get route information
    final data = Map<String, dynamic>.from(map['routes'][0]);

    String distance = '';
    String duration = '';
    List<Step> steps = [];
    if ((data['legs'] as List).isNotEmpty) {
      final leg = data['legs'][0];
      distance = leg['distance']['text'];
      duration = leg['duration']['text'];
      for(var i in leg['steps']) {
        steps.add(Step(
            LatLng(i['start_location']['lat'], i['start_location']['lng']),
            LatLng(i['end_location']['lat'], i['end_location']['lng']),
            i['duration']['text'],
            i['distance']['text'],
            i['html_instructions'],
            i['maneuver'])
        );
      }
    }

    return Directions(
      totalDistance: distance,
      totalDuration: duration,
      totalSteps: steps,
    );
  }

  @override
  String toString(){
    return "{total dur: $totalDuration, total distance: $totalDistance, steps ${totalSteps.toString()}}";
  }
}

