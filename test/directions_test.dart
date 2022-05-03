import 'package:flutter_test/flutter_test.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hap_map/api/directions_api.dart';
import 'package:hap_map/models/directions_model.dart';
import 'package:hap_map/models/place_model.dart';

void main() {
  LatLng origin = const LatLng(47.6534424035837, -122.30589365409594); // Paul G. Allen Center

  Place originPlace = Place(name: "Paul G. Allen Center for Computer Science & Engineering", id: "ChIJf_BRMu0UkFQRSlDYGi2L3hI");
  Place destPlace = Place(name: "University Book Store - HUB Branch", id: "ChIJmcXywQkVkFQRn8PITvTAOTk");
  Place noRoutePlace = Place(name: "Ka'u Desert Trailhead", id: "ChIJ5T4jxyfZU3kRq53nVPUa6xs");

  List<Step> normalCaseSteps = [Step(const LatLng(47.6534211, -122.3061126), const LatLng(47.6534211, -122.3061126), "1 min", "1 ft", "Head"),
                             Step(const LatLng(47.6534211, -122.3061126), const LatLng(47.6534267, -122.3056207), "1 min", "167 ft", "Walk for 167&nbsp;ft"),
                             Step(const LatLng(47.6534267, -122.3056207), const LatLng(47.65340920000001, -122.3053086), "1 min", "115 ft", "Head <b>east</b> toward <b>E Stevens Way NE</b><div style=\"font-size:0.9em\">Take the stairs</div>"),
                             Step(const LatLng(47.65340920000001, -122.3053086), const LatLng(47.6547983, -122.3048892), "2 mins", "0.1 mi", "Turn <b>left</b> onto <b>E Stevens Way NE</b><div style=\"font-size:0.9em\">Destination will be on the right</div>")];




  List<Step> originEqualsDestSteps = [Step(const LatLng(47.6534211, -122.3061126), const LatLng(47.6534211, -122.3061126), "1 min", "1 ft", "Head"),
                                  Step(const LatLng(47.6534211, -122.3061126), const LatLng(47.6534267, -122.3056207), "1 min", "167 ft", "Walk for 167&nbsp;ft"),
                                  Step(const LatLng(47.6534267, -122.3056207), const LatLng(47.65340920000001, -122.3053086), "1 min", "115 ft", "Head <b>east</b> toward <b>E Stevens Way NE</b><div style=\"font-size:0.9em\">Take the stairs</div>"),
                                  Step(const LatLng(47.65340920000001, -122.3053086), const LatLng(47.65353820000001, -122.3052619), "1 min", "56 ft", "Turn <b>left</b> onto <b>E Stevens Way NE</b><div style=\"font-size:0.9em\">Destination will be on the right</div>")];

  Directions normalCaseDirections = Directions(totalDistance: "0.2 mi", totalDuration: "3 mins", totalSteps: normalCaseSteps);

  Directions originEqualsDest = Directions(totalDistance: "1 min", totalDuration: "338 ft", totalSteps: originEqualsDestSteps);

  Directions noRouteDirection = const Directions(totalDistance: "", totalDuration: "", totalSteps: []);

  test('Normal Case', () async {
      Directions? result = await DirectionsAPI().getDirections(origin: origin, destination: destPlace);
      expect(result?.equals(normalCaseDirections), equals(true));
  });


  test('origin == destination', () async {
      Directions? result = await DirectionsAPI().getDirections(origin: origin, destination: originPlace);
      expect(result?.equals(originEqualsDest), equals(true));
  });


  test('No Routes', () async {
      Directions? result = await DirectionsAPI().getDirections(origin: origin, destination: noRoutePlace);
      expect(result?.equals(noRouteDirection), equals(true));
  });

}
