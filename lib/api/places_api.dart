import 'dart:convert';

import 'package:http/http.dart' as http;

class Place {
  final String name;

  const Place({
    required this.name,
  });

  static Place fromJson(Map<String, dynamic> json) => Place(
    name: json['name'],
  );
}

class PlaceApi {
  static Future<List<Place>> getPlaceSuggestions(String query) async {
    // can set up fake data in a json file and use jsonplaceholder to mimick an API call
    final url = Uri.parse('https://jsonplaceholder.typicode.com/users');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List places = json.decode(response.body);

      return places.map((json) => Place.fromJson(json)).where((user) {
        final nameLower = user.name.toLowerCase();
        final queryLower = query.toLowerCase();

        return nameLower.contains(queryLower);
      }).toList();
    } else {
      throw Exception();
    }
  }
}