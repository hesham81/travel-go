import 'flight.dart';

class FlightDeparture {
  final Flight flight;
  final DateTime depDay;
  final DateTime arrDay;

  final DateTime depTime;
  final DateTime arrTime;

  final int availableSeats;
  final double price;
  final String arrAirport;

  final String depAirport;

  FlightDeparture({
    required this.flight,
    required this.depDay,
    required this.arrDay,
    required this.depTime,
    required this.arrTime,
    required this.availableSeats,
    required this.price,
    required this.arrAirport,
    required this.depAirport,
  });

  Map<String, dynamic> toMap() {
    return {
      'flight': flight.toMap(),
      'depDay': depDay.toIso8601String(),
      'depTime': depTime.toIso8601String(),
      'availableSeats': availableSeats,
      'price': price,
      'arrAirport': arrAirport,
      'depAirport': depAirport,
      'arrDay': arrDay.toIso8601String(),
      'arrTime': arrTime.toIso8601String(),
    };
  }

  factory FlightDeparture.fromMap(Map<String, dynamic> map) {
    return FlightDeparture(
      flight: Flight.fromMap(map['flight']),
      depDay: DateTime.parse(map['depDay']),
      arrDay: DateTime.parse(map['arrDay']),
      depTime: DateTime.parse(map['depTime']),
      arrTime: DateTime.parse(map['arrTime']),
      availableSeats: map['availableSeats'],
      price: map['price'],
      arrAirport: map['arrAirport'],
      depAirport: map['depAirport'],
    );
  }
}