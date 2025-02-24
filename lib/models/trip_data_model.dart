class TripDataModel {
  final String tripId;

  final String tripDescriptions;

  final double price;

  final String currency;

  int availableSeats;
  double rating;

  final String imageUrl;

  final String countryLocation;

  final String cityLocation;

  TripDataModel({
    required this.tripId,
    required this.tripDescriptions,
    required this.price,
    required this.currency,
    required this.availableSeats,
    required this.rating,
    required this.imageUrl,
    required this.countryLocation,
    required this.cityLocation,
  });
}
