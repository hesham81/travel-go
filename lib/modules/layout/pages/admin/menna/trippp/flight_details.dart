import 'package:flutter/material.dart';
import 'package:travel_go/core/utils/flight_collections.dart';
import 'package:travel_go/models/flight.dart';

class FlightDetails extends StatefulWidget {
  final String flight;

  const FlightDetails({
    super.key,
    required this.flight,
  });

  @override
  State<FlightDetails> createState() => _FlightDetailsState();
}

class _FlightDetailsState extends State<FlightDetails> {
  Flight? flight;

  Future<void> _getFlightData() async {
    flight = await FlightCollections.getFlightById(
      flightId: widget.flight,
    );
    setState(() {});
  }

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
          flight?.flightName ?? "No Flight Name",
        ),
      ),
    );
  }
}
