import '/models/flight_model.dart';
import '/models/hotel_model.dart';
import '/modules/layout/pages/admin/menna/trippp/model/programs.dart';
import '/modules/layout/pages/admin/menna/trippp/model/trip_departures.dart';

import 'company_model.dart';

class TripDataProgramModel {
  String tripId;

  final String tripTitle;
  final String tripDescription;
  final int tripDuration;
  final String tripPrice;
  final String from;

  final String to;

  final Company organizedBy;
  final List<TripDepartures> departures;

  final List<Program> programs;

  final Hotel hotel;

  final Flight flight;
  final String tripImageUrl;

  TripDataProgramModel({
    required this.tripId,
    required this.tripTitle,
    required this.organizedBy,
    required this.programs,
    required this.hotel,
    required this.flight,
    required this.tripImageUrl,
    required this.departures,
    required this.tripDescription,
    required this.tripDuration,
    required this.tripPrice,
    required this.from,
    required this.to,
  });

  Map<String, dynamic> toMap() {
    return {
      'tripId': tripId,
      'tripTitle': tripTitle,
      'organizedBy': organizedBy.toJson(),
      'programs': programs.map((program) => program.toMap()).toList(),
      'hotel': hotel.toMap(),
      'flight': flight.toMap(),
      'tripImageUrl': tripImageUrl,
      'departures': departures.map((departure) => departure.toJson()).toList(),
      'tripDescription': tripDescription,
      'tripDuration': tripDuration,
      'tripPrice': tripPrice,
      'from': from,
      'to': to,
    };
  }

  factory TripDataProgramModel.fromMap(Map<String, dynamic> map) {
    return TripDataProgramModel(
      tripId: map['tripId'],
      tripTitle: map['tripTitle'],
      organizedBy: Company.fromJson(map['organizedBy']),
      programs: List<Program>.from(
        map['programs'].map((program) => Program.fromMap(program)),
      ),
      hotel: Hotel.fromMap(map['hotel']),
      flight: Flight.fromMap(map['flight']),
      tripImageUrl: map['tripImageUrl'],
      departures: List<TripDepartures>.from(
        map['departures']
            .map((departure) => TripDepartures.fromJson(departure)),
      ),
      tripDescription: map['tripDescription'],
      tripDuration: map['tripDuration'],
      tripPrice: map['tripPrice'],
      from: map['from'],
      to: map['to'],
    );
  }
}
