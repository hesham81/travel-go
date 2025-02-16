import 'package:flutter/material.dart';
import 'package:travel_go/core/extensions/align.dart';
import 'package:travel_go/core/extensions/extensions.dart';
import 'package:travel_go/core/widget/loading_image_network_widget.dart';
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
    FlightAirlines(
      flighAirLineName: "Iraqia",
      flightAirLineImageUrl:
          "https://i.pinimg.com/474x/d1/fb/e2/d1fbe23d831f8098df49ea198c4719dd.jpg",
    ),
    FlightAirlines(
      flighAirLineName: "American Airlines",
      flightAirLineImageUrl:
          "https://i.pinimg.com/736x/f9/6d/c1/f96dc1e8ef3621d1d47ec0496dd6472f.jpg",
    ),
    FlightAirlines(
      flighAirLineName: "Hawaiian",
      flightAirLineImageUrl:
          "https://i.pinimg.com/736x/18/f0/e6/18f0e651fb980fb657fd9e63b7b88bf9.jpg",
    ),
    FlightAirlines(
      flighAirLineName: "South Africa",
      flightAirLineImageUrl:
          "https://i.pinimg.com/736x/79/5e/95/795e9556ce96a01b82c828529b566756.jpg",
    ),
    FlightAirlines(
      flighAirLineName: "Etihad",
      flightAirLineImageUrl:
          "https://i.pinimg.com/736x/c6/70/26/c6702655e390f62dce0a8c0909fe06cb.jpg",
    ),
    FlightAirlines(
      flighAirLineName: "Oman",
      flightAirLineImageUrl:
          "https://i.pinimg.com/474x/e9/4c/e6/e94ce6830ebf1e18e9d8faa40a08a794.jpg",
    ),
    FlightAirlines(
      flighAirLineName: "British",
      flightAirLineImageUrl:
          "https://i.pinimg.com/474x/ca/e1/73/cae17378435821a90aa5a99a7473b6af.jpg",
    ),
    FlightAirlines(
      flighAirLineName: "EgyptAir",
      flightAirLineImageUrl:
          "https://i.pinimg.com/736x/99/42/0d/99420d4024985d95bfbf64a4fe1e0007.jpg",
    ),
    FlightAirlines(
      flighAirLineName: "Delta",
      flightAirLineImageUrl:
          "https://i.pinimg.com/474x/65/94/2d/65942dbc81991aaa211c9d20d3037918.jpg",
    ),
    FlightAirlines(
      flighAirLineName: "Air Canada",
      flightAirLineImageUrl:
          "https://i.pinimg.com/736x/35/2c/f1/352cf1cd3ce19cb94dca6828d6ba4fd4.jpg",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            GridView.builder(
              padding: EdgeInsets.zero,
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
              itemBuilder: (context, index) => SizedBox(
                height: 0.3.height,
                child: GestureDetector(
                  onTap: () {
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: LoadingImageNetworkWidget(
                      imageUrl: flightAirlines[index].flightAirLineImageUrl,
                    ),
                  ),
                ),
              ).allPadding(5),
              itemCount: flightAirlines.length,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
            ),
          ],
        ).hPadding(0.03.width).vPadding(0.03.height),
      ),
    );
  }
}
