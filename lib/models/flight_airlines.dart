import 'package:flutter/material.dart';

class FlightAirlines {
  final String flighAirLineName;

  final String flightAirLineImageUrl;

  FlightAirlines({
    required this.flighAirLineName,
    required this.flightAirLineImageUrl,
  });

  Map<String, dynamic> toMap() {
    return {
      'flighAirLineName': flighAirLineName,
      'flightAirLineImageUrl': flightAirLineImageUrl,
    };
  }

  factory FlightAirlines.fromMap(Map<String, dynamic> map) {
    return FlightAirlines(
      flighAirLineName: map['flighAirLineName'] ?? '',
      flightAirLineImageUrl: map['flightAirLineImageUrl'] ?? '',
    );
  }
}
