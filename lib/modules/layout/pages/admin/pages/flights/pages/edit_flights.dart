import 'package:flutter/material.dart';
import 'package:travel_go/core/extensions/align.dart';
import 'package:travel_go/core/extensions/extensions.dart';
import 'package:travel_go/modules/layout/pages/admin/pages/flights/widget/flight_cart_widget.dart';

import '../../../../../../../models/flight_airlines.dart';
import '/core/theme/app_colors.dart';

class EditFlights extends StatefulWidget {
  const EditFlights({super.key});

  @override
  State<EditFlights> createState() => _EditFlightsState();
}

class _EditFlightsState extends State<EditFlights> {
  final flightAirlines = [
    FlightAirlines(
      flighAirLineName: "Emirates",
      flightAirLineImageUrl:
          "https://i.pinimg.com/736x/64/9e/1c/649e1c738c189557e58cf78e1ec21cfe.jpg",
    ),
    FlightAirlines(
      flighAirLineName: "Qatar",
      flightAirLineImageUrl:
          "https://i.pinimg.com/736x/88/45/10/884510a2d764ce27643bcca063c1855e.jpg",
    ),
    FlightAirlines(
      flighAirLineName: "Algeria",
      flightAirLineImageUrl:
          "https://i.pinimg.com/736x/5a/d7/bf/5ad7bfcdd9cfc7885dd434aefd9b06ff.jpg",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: ListView.separated(
              itemCount: flightAirlines.length,
              itemBuilder: (context, index) => FlightCartWidget(
                model: flightAirlines[index],
              ),
              separatorBuilder: (context , _ )=> 0.01.height.hSpace,
            ),
          ),
        ],
      ).hPadding(0.03.width).vPadding(0.03.height),
    );
  }
}
