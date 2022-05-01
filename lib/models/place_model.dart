class Place {
  final String name;
  final String id;


  Place({required this.name, required this.id});

  factory Place.fromSearch(Map<String, dynamic> entry) {
    return Place(
      name : entry['description'],
      id: entry['place_id'],
    );
  }

  factory Place.fromNearby(Map<String, dynamic> entry) {
    return Place(
      name : entry['name'],
      id: entry['place_id'],
    );
  }

  @override
  String toString(){
    return "{name: $name, id: $id}";
  }
}