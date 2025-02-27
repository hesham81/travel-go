import 'flight_airlines.dart';

class Flight {
  final String flightId;
  final String flightName;
  final FlightAirlines? airline;

  Flight({
    required this.flightId,
    required this.flightName,
    required this.airline,
  });

  Map<String, dynamic> toMap() {
    return {
      'flightId': flightId,
      'flightName': flightName,
      'airline': airline?.toMap(),
    };
  }

  factory Flight.fromMap(Map<String, dynamic> map) {
    return Flight(
      flightId: map['flightId'],
      flightName: map['flightName'],
      airline: FlightAirlines.fromMap(map['airline']),
    );
  }
}