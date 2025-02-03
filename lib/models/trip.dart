class Trip {
  final String currency;
  final String destination;
  final String hotelId;
  final int noOfDays;
  final String source;
  final double tripPrice;

  Trip({
    required this.currency,
    required this.destination,
    required this.hotelId,
    required this.noOfDays,
    required this.source,
    required this.tripPrice,
  });

  Map<String, dynamic> toMap() {
    return {
      'currency': currency,
      'destination': destination,
      'hotelId': hotelId,
      'noOfDays': noOfDays,
      'source': source,
      'tripPrice': tripPrice,
    };
  }

  // Create an object from a Map (useful for Firestore)
  factory Trip.fromMap(Map<String, dynamic> map) {
    return Trip(
      currency: map['currency'],
      destination: map['destination'],
      hotelId: map['hotelId'],
      noOfDays: map['noOfDays'],
      source: map['source'],
      tripPrice: map['tripPrice'],
    );
  }
}