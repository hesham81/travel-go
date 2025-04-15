class Accomodations{
  final List<String> roomIds;
  final List<String> amenities;
  final List<String> roomTypes;
  final List<String> bedOptions;
  final String locations;
  final double rating;
  const Accomodations({
    required this.roomIds,
    required this.amenities,
    required this.roomTypes,
    required this.bedOptions,
    required this.locations,
    required this.rating,
  });
  Map<String, dynamic> toMap() {
    return {
      'roomIds': roomIds,
      'amenities': amenities,
      'roomTypes': roomTypes,
      'bedOptions': bedOptions,
      'locations': locations,
      'rating': rating,
    };
  }
  factory Accomodations.fromMap(Map<String, dynamic> map) {
    return Accomodations(
      roomIds: List<String>.from(map['roomIds'] ?? []),
      amenities: List<String>.from(map['amenities'] ?? []),
      roomTypes: List<String>.from(map['roomTypes'] ?? []),
      bedOptions: List<String>.from(map['bedOptions'] ?? []),
      locations: map['locations'] ?? '',
      rating: (map['rating'] as num?)?.toDouble() ?? 0.0,
    );
  }
}

