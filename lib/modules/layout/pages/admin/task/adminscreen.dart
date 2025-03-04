import 'package:flutter/material.dart';
import '/modules/layout/pages/admin/task/attractionscreen.dart';
import '/modules/layout/pages/admin/task/flightscreen.dart';
import '/modules/layout/pages/admin/task/hotelscreen.dart';
import '/modules/layout/pages/admin/task/tripscreen.dart';

class AdminHome extends StatelessWidget {
  final Map<String, Widget Function()> pageRoutes = {
    "Trip": () => Tripscreen(),
    "Flight": () => flightscreen(),
    "Hotel": () => hotelscreen(),
    "Attraction": () => Attraction(),
  };

  void _navigateToPage(BuildContext context, String title) {
    if (pageRoutes.containsKey(title)) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => pageRoutes[title]!(),
        ),
      );
    } else {
      print("Page not found for: $title");
    }
  }

  Widget _buildElevatedButton(BuildContext context, String title) {
    return ElevatedButton(
      onPressed: () => _navigateToPage(context, title),
      style: ElevatedButton.styleFrom(
        minimumSize: Size(250, 70),
        backgroundColor: Color(0xff0d75b4),
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      child: Text(
        title,
        style: TextStyle(
            color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
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
          style: TextStyle(
              fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildElevatedButton(context, "Trip"),
              SizedBox(height: 12),
              _buildElevatedButton(context, "Flight"),
              SizedBox(height: 12),
              _buildElevatedButton(context, "Hotel"),
              SizedBox(height: 12),
              _buildElevatedButton(context, "Attraction"),
            ],
          ),
        ),
      ),
    );
  }
}
