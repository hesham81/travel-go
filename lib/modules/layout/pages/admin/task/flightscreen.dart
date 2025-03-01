import 'package:flutter/material.dart';
import 'package:travel_go/modules/layout/pages/admin/task/flight/ViewFlightToDelete.dart';
import 'Flight_departure/NewDeparture.dart';
import 'Flight_departure/UpdateDepartureSelectAirline.dart';
import 'Flight_departure/delete_departure.dart';


import 'browse_Airline.dart';
import 'flight/NewFlight.dart';
import 'flight/ViewFlightToUpdate.dart';
import 'flight/browseflight2.dart';

class flightscreen extends StatelessWidget {
  final Map<String, Widget Function()> pageRoutes = {
    // Flight
    "Browse Flight": () => BrowseFlight2(),
    "Delete Flight": () => ViewFlightsToDelete(),
    "New Flight": () => NewFlight(),
    "Update Flight": () => ViewFlightsToUpdate(),

    // Flight Departure
    "Browse Flight Departure": () => BrowseAirlines(),
    "Delete Flight Departure": () => DeleteFlightDeparture(),
    "New Flight Departure": () => NewDeparture(),
    "Update Flight Departure": () => UpdateDepartureSelectAirline(),
  };

  void _handleMenuSelection(BuildContext context, String value) {
    if (pageRoutes.containsKey(value)) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => pageRoutes[value]!()));
    } else {
      print("Page not found for: $value");
    }
  }

  void _showPopupMenu(BuildContext context, String title) {
    List<String> menuOptions = [
      "Browse $title",
      "New $title",
      "Update $title",
      "Delete $title"
    ];

    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.6,
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: menuOptions
                .map(
                  (option) => ListTile(
                title: Text(option, style: TextStyle(fontSize: 18)),
                onTap: () {
                  Navigator.pop(context);
                  _handleMenuSelection(context, option);
                },
              ),
            )
                .toList(),
          ),
        ),
      ),
    );
  }

  Widget _buildPopupButton(BuildContext context, String title) {
    return ElevatedButton(
      onPressed: () => _showPopupMenu(context, title),
      style: ElevatedButton.styleFrom(
        minimumSize: Size(250, 70),
        backgroundColor: Color(0xff0d75b4),
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      child: Text(
        title,
        style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff0d75b4),
        title: Text(
          "Tour And Travel",
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildPopupButton(context, "Flight"),
              SizedBox(height: 12),
              _buildPopupButton(context, "Flight Departure"),
            ],
          ),
        ),
      ),
    );
  }
}
