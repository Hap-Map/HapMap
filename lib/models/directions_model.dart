import 'package:google_maps_flutter/google_maps_flutter.dart';

class Step{
  final LatLng startLocation;
  final LatLng endLocation;
  final String duration;
  final String distance;
  final String htmlInstructions;

  Step(this.startLocation, this.endLocation, this.duration, this.distance, this.htmlInstructions);

  @override
  String toString(){
    return "{start: $startLocation, end: $endLocation, dur: $duration, distance: $distance, html: $htmlInstructions}}";
  }

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
    String distance = '';
    String duration = '';
    List<Step> steps = [];

    if ((map['routes'] as List).isNotEmpty) {
      // Get route information
      final data = Map<String, dynamic>.from(map['routes'][0]);

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
          //print(s);
          steps.add(s);
        }
      }
    }

    return Directions(
      totalDistance: distance,
      totalDuration: duration,
      totalSteps: steps,
    );
  }

  List<LatLng> getPolylines() {
    List<LatLng> points = [];
    for (Step s in totalSteps) {
      points.add(LatLng(s.startLocation.latitude, s.startLocation.longitude));
      points.add(LatLng(s.endLocation.latitude, s.endLocation.longitude));
    }
    return points;
  }

  @override
  String toString(){
    return "{total dur: $totalDuration, total distance: $totalDistance, steps ${totalSteps.toString()}}";
  }
}

