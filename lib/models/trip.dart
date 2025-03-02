import 'package:travel_go/models/hotel_model.dart';
import 'package:travel_go/models/trip_model.dart';

class Trip extends TripModel {
  final String currency;
  final String destination;
  final Hotel hotel;
  final int noOfDays;
  final String source;

  Trip({
    required this.currency,
    required this.destination,
    required this.hotel,
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
      'hotel': hotel.toMap(),
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

  factory Trip.fromMap(Map<String, dynamic> map) {
    return Trip(
      currency: map['currency'],
      destination: map['destination'],
      hotel: Hotel.fromMap(map['hotel']),
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
