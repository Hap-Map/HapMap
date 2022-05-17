import 'package:flutter_test/flutter_test.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hap_map/api/place_api.dart';
import 'package:hap_map/models/place_model.dart';

void main() {
    LatLng origin = const LatLng(47.6534424035837, -122.30589365409594); // Paul G. Allen Center
    Place originPlace = Place(name: "Paul G. Allen Center for Computer Science & Engineering", id: "ChIJf_BRMu0UkFQRSlDYGi2L3hI");
    String originAddress = "185 E Stevens Way NE, Seattle, WA 98195, USA";

    String search = "university bookstore";

    // Tests the autocomplete search returns expected results
    // Expected results are walkable destinations within 5 miles, ordered starting with the locations closest to user
    test('Places Model: Place Suggestions (Place API Autocomplete)', () async {
      List<Place?> result = await PlaceApi.getPlaceSuggestions(search, origin);

      List<Place> suggestionsResult = [Place(name: "University Book Store, University Way NE, Seattle, WA, USA", id: "ChIJjwucI4sUkFQR6pdUeAufRqg"),
                                       Place(name: "Seattle Pacific University Bookstore, West Bertona Street, Seattle, WA, USA", id: "ChIJqc6c2qcVkFQR2Gmc-wG994I"),
                                       Place(name: "University Book Store - HUB Branch, East Stevens Way Northeast, Seattle, WA, USA", id: "ChIJmcXywQkVkFQRn8PITvTAOTk"),
                                       Place(name: "UW Bothell University Bookstore, Campus Way Northeast, Bothell, WA, USA", id: "ChIJay7DpmUOkFQREa1kM8I5Eg4"),
                                       Place(name: "Bastyr University Bookstore, Juanita Drive Northeast, Kenmore, WA, USA", id: "ChIJUc0zJfQRkFQRXcHEbRrXCNw")];

      for (int i = 0; i < result.length; i++) {
        expect(result[i], suggestionsResult[i]);
      }
    });

    // Tests place ID return using nearby position as input
    test('Places Model: Get Place (Place API Nearby Search)', () async {
      Place? result = await PlaceApi.getPlace(origin);
      expect(result, originPlace);
    });

    // Tests place details (Address) returned using a place ID as input
    test('Places Model: Get nearby address (Place API Details)', () async {
      String result = await PlaceApi.getAddress(originPlace);
      expect(result, originAddress);
    });
}