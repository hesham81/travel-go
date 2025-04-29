import 'package:flutter/material.dart';

class FlightDeparture {
  String id;
  final String flightId;
  final DateTime depDay;
  final DateTime arrDay;

  final TimeOfDay depTime;
  final TimeOfDay arrTime;

   int availableSeats;
  final String arrAirport;
  final String depAirport;

  FlightDeparture({
    this.id = "",
    required this.flightId,
    required this.depDay,
    required this.arrDay,
    required this.depTime,
    required this.arrTime,
    required this.availableSeats,
    required this.arrAirport,
    required this.depAirport,
  });

  // Convert TimeOfDay to a string (HH:mm format)
  String _timeOfDayToString(TimeOfDay time) {
    final hours = time.hour.toString().padLeft(2, '0');
    final minutes = time.minute.toString().padLeft(2, '0');
    return '$hours:$minutes';
  }

  // Parse a string (HH:mm format) into a TimeOfDay
  static TimeOfDay _stringToTimeOfDay(String timeString) {
    final parts = timeString.split(':');
    final hours = int.parse(parts[0]);
    final minutes = int.parse(parts[1]);
    return TimeOfDay(hour: hours, minute: minutes);
  }

  // Convert FlightDeparture object to a Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'flight': flightId,
      'depDay': depDay.toIso8601String(),
      'arrDay': arrDay.toIso8601String(),
      'depTime': _timeOfDayToString(depTime), // Convert TimeOfDay to string
      'arrTime': _timeOfDayToString(arrTime), // Convert TimeOfDay to string
      'availableSeats': availableSeats,
      'arrAirport': arrAirport,
      'depAirport': depAirport,
    };
  }

  // Create a FlightDeparture object from a Map
  factory FlightDeparture.fromMap(Map<String, dynamic> map) {
    return FlightDeparture(
      id: map['id'],
      flightId: map['flight'],
      depDay: DateTime.parse(map['depDay']),
      arrDay: DateTime.parse(map['arrDay']),
      depTime: FlightDeparture._stringToTimeOfDay(map['depTime']), // Call static method
      arrTime: FlightDeparture._stringToTimeOfDay(map['arrTime']), // Call static method
      availableSeats: map['availableSeats'],
      arrAirport: map['arrAirport'],
      depAirport: map['depAirport'],
    );
  }
}