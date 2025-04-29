import 'package:travel_go/models/seat_economy.dart';

import 'flight_airlines.dart';

class Flight {
  final String flightId;
   String flightName;
  final FlightAirlines airline;
  List<SeatEconomyDataModel> seats;
  int totalSeats;

  Flight({
    required this.flightId,
    required this.flightName,
    required this.airline,
    required this.seats,
    this.totalSeats = 120,
  });

  Map<String, dynamic> toMap() {
    return {
      'flightId': flightId,
      'flightName': flightName,
      'airline': airline?.toMap(),
      'seats': seats.map((seat) => seat.toMap()).toList(),
      'totalSeats': totalSeats,
    };
  }

  factory Flight.fromMap(Map<String, dynamic> map) {
    return Flight(
      flightId: map['flightId'],
      flightName: map['flightName'],
      airline: FlightAirlines.fromMap(map['airline']),
      totalSeats: map['totalSeats'],
      seats: List<SeatEconomyDataModel>.from(
        map['seats']?.map((seat) => SeatEconomyDataModel.fromJson(seat)),
      ),
    );
  }
}
