import 'package:travel_go/models/departure_model.dart';
import 'package:travel_go/models/flight_airlines.dart';

class FlightModel {
  final String id;

  final Departures departures;

  final Flight flight;

  FlightModel({
    required this.id,
    required this.departures,
    required this.flight,
  });
}

class Flight {
  final String flightId;
  final String flightName;
  final FlightAirlines? airline;

  Flight({
    required this.flightId,
    required this.flightName,
    required this.airline,
  });
}
