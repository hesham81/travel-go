import 'package:flutter/material.dart';
import 'package:travel_go/models/flight_airlines.dart';
import 'package:travel_go/models/flight_model.dart';

class SelectedAirline extends StatelessWidget {
  static const String routeName = "selected-air-lines";

  const SelectedAirline({super.key});

  @override
  Widget build(BuildContext context) {
    final airline =
        ModalRoute.of(context)!.settings.arguments as FlightAirlines;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          airline.flighAirLineName,
        ),
      ),
    );
  }
}
