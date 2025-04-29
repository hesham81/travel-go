import '/models/flight.dart';
import '/models/hotel_model.dart';
import '/models/program_model.dart';
import '/modules/layout/pages/admin/menna/trippp/model/company_model.dart';

class TripDataModel {
  final String tripId;
  final String? imageUrl;

  final String tripName;

  final String tripVideoUrl;

  final double fromLong;
  final double fromLat;

  final double toLong;
  final double toLat;

  final int totalGuests;

  final double price;

  final String currency;

  final Company organizedBy;

  final List<ProgramModel> programDetails;

  final String hotelId;

  final String flightId;
  final String source;

  final String destination;
  final int totalDays;
  List<String>? favourites;

  TripDataModel({
    required this.tripId,
    required this.tripName,
    required this.tripVideoUrl,
    required this.fromLong,
    required this.fromLat,
    required this.toLong,
    required this.toLat,
    required this.totalGuests,
    required this.price,
    required this.currency,
    required this.organizedBy,
    required this.programDetails,
    required this.hotelId,
    required this.flightId,
    required this.totalDays,
    this.imageUrl,
    required this.source,
    required this.destination,
    this.favourites,
  });

  Map<String, dynamic> toMap() {
    return {
      'tripId': tripId,
      'tripName': tripName,
      'tripVideoUrl': tripVideoUrl,
      'fromLong': fromLong,
      'toLong': toLong,
      "fromLat": fromLat,
      "toLat": toLat,
      'totalGuests': totalGuests,
      'price': price,
      'currency': currency,
      'organizedBy': organizedBy.toJson(),
      'programDetails': programDetails.map((x) => x.toMap()).toList(),
      'hotelId': hotelId,
      'flightId': flightId,
      'imageUrl': imageUrl,
      "source": source,
      "destination": destination,
      "totalDays": totalDays,
      "favourites": favourites ?? [],
    };
  }

  factory TripDataModel.fromMap(Map<String, dynamic> map) {
    return TripDataModel(
      tripId: map['tripId'],
      tripName: map['tripName'],
      tripVideoUrl: map['tripVideoUrl'],
      fromLat: map['fromLat'],
      fromLong: map['fromLong'],
      toLong: map['toLong'],
      toLat: map['toLat'],
      totalGuests: map['totalGuests'],
      price: map['price'],
      currency: map['currency'],
      organizedBy: Company.fromJson(
        map['organizedBy'],
      ),
      programDetails: List<ProgramModel>.from(
        map['programDetails']?.map(
          (x) => ProgramModel.fromMap(x),
        ),
      ),
      hotelId: map['hotelId'],
      flightId: map['flightId'],
      imageUrl: map['imageUrl'],
      source: map['source'],
      destination: map['destination'],
      totalDays: map['totalDays'],
      favourites: List<String>.from(map['favourites']),
    );
  }
}
