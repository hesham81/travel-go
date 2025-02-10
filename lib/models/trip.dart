import 'package:travel_go/models/trip_model.dart';

class Trip extends TripModel {
  final String currency;
  final String destination;
  final String hotelId;
  final int noOfDays;
  final String source;

  Trip({
    required this.currency,
    required this.destination,
    required this.hotelId,
    required this.noOfDays,
    required this.source,
    required super.id,
    required super.imageUrl,
    required super.title,
    required super.startDateTime,
    required super.endDateTime,
    required super.price,
  });

  Map<String, dynamic> toMap() {
    return {
      'currency': currency,
      'destination': destination,
      'hotelId': hotelId,
      'noOfDays': noOfDays,
      'source': source,
      'id': id,
      'imageUrl': imageUrl,
      'title': title,
      'startDateTime': startDateTime.toIso8601String(),
      'endDateTime': endDateTime.toIso8601String(),
      'price': price,
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
      id: map['id'],
      imageUrl: map['imageUrl'],
      title: map['title'],
      startDateTime: DateTime.parse(map['startDateTime']),
      endDateTime: DateTime.parse(map['endDateTime']),
      price: map['price'],
    );
  }
}
