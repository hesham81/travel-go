import 'package:flutter/material.dart';
import '/core/widget/search_widget.dart';
import '/modules/layout/pages/admin/pages/flights/widget/flights_widget.dart';
import '/models/flight_airlines.dart';
import '/models/flight_model.dart';
import '/modules/layout/pages/admin/pages/flights/pages/add_flight.dart';
import '/core/extensions/extensions.dart';
import '/core/theme/app_colors.dart';

class EditFlights extends StatefulWidget {
  const EditFlights({super.key});

  @override
  State<EditFlights> createState() => _EditFlightsState();
}

class _EditFlightsState extends State<EditFlights> {
  var searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Flight model = Flight(
      flightId: "flightId",
      flightName: "flightName",
      airline: FlightAirlines(
        flighAirLineName: "flighAirLineName",
        flightAirLineImageUrl:
            "https://i.pinimg.com/236x/97/e5/de/97e5de6a97d30d0198354c521e3e9989.jpg",
      ),
    );
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddFlight(),
            ),
          );
        },
        backgroundColor: AppColors.primaryColor.withOpacity(0.8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(
          Icons.add,
          color: AppColors.blackColor,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SearchWidget(
              controller: searchController,
              borderRadius: 25,
            ),
            0.01.height.hSpace,
            ListView.separated(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) => FlightsWidget(
                model: model,
                onTap: () {
                  print("Clicked");
                },
              ),
              separatorBuilder: (context, _) => 0.01.height.hSpace,
              itemCount: 4,
            ),
          ],
        ),
      ).hPadding(
        0.03.width,
      ),
    );
  }
}
