import 'package:flutter/material.dart';
import 'package:travel_go/models/flight.dart';

class FlightDetails extends StatelessWidget {
  final Flight flight;

  const FlightDetails({
    super.key,
    required this.flight,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            Icons.arrow_back_ios,
          ),
        ),
        title: Text(
          flight.flightName,
        ),
      ),
    );
  }
}
