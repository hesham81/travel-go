import 'package:travel_go/models/trip_data_model.dart';

class TripDepartureDataModel {
  final TripDataModel trip;

  final DateTime from;

  final DateTime to;

  final int availableSeats;

  TripDepartureDataModel(
      {required this.trip,
      required this.from,
      required this.to,
      required this.availableSeats});

  Map<String, dynamic> toMap() {
    return {
      'trip': trip.toMap(),
      'from': from.toIso8601String(),
      'to': to.toIso8601String(),
      'availableSeats': availableSeats,
    };
  }

  factory TripDepartureDataModel.fromMap(Map<String, dynamic> map) {
    return TripDepartureDataModel(
      trip: TripDataModel.fromMap(map['trip']),
      from: DateTime.parse(map['from']),
      to: DateTime.parse(map['to']),
      availableSeats: map['availableSeats'],
    );
  }
}
