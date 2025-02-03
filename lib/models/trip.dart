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
//   tripMap = {
//     'currency': 'EGP',
//     'destination': 'Cairo',
//     'hotelId': '/Hotel/K35oO9Avssk04uuKhecp',
//     'noOfDays': 3,
//     'source': 'Sharm El Sheikh',
//     'id': 'trip123',
//     'imageUrl': 'https://ulmlgjxomyybsvsjesuv.supabase.co/storage/v1/object/sign/trip/sharm/dahab.png?token=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1cmwiOiJ0cmlwL3NoYXJtL2RhaGFiLnBuZyIsImlhdCI6MTczODYyMDMyMSwiZXhwIjoxNzcwMTU2MzIxfQ.OXBFOIOybFO9FQs19GLg0DYASGOetLwPqHhvox4Ovb8',
//     'title': 'Cairo Adventure',
//     'startDateTime': '2023-10-01T00:00:00.000',
//     'endDateTime': '2023-10-04T00:00:00.000',
//     'price': 350,
//   };
}
