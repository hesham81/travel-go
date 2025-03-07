import 'package:travel_go/models/trip_data_model.dart';

class TripDepartureDataModel {
  final TripDataModel trip;
  final String id;

  final DateTime from;

  final DateTime to;

  final int availableSeats;

  TripDepartureDataModel({
    required this.trip,
    required this.from,
    required this.to,
    required this.availableSeats,
    required this.id,
  });

  Map<String, dynamic> toMap() {
    return {
      'trip': trip.toMap(),
      'from': from.toIso8601String(),
      'to': to.toIso8601String(),
      'availableSeats': availableSeats,
      'id': id,
    };
  }

  factory TripDepartureDataModel.fromMap(Map<String, dynamic> map) {
    return TripDepartureDataModel(
      trip: TripDataModel.fromMap(map['trip']),
      from: DateTime.parse(map['from']),
      to: DateTime.parse(map['to']),
      availableSeats: map['availableSeats'],
      id: map['id'],
    );
  }
}
