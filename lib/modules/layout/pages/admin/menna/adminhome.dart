import 'package:flutter/material.dart';
import 'package:travel_go/core/theme/app_colors.dart';
import 'package:travel_go/modules/layout/pages/admin/menna/trippp/trip_admin_screen.dart';
import 'package:travel_go/modules/layout/pages/admin/pages/programs/pages/browse_program/pages/explore_programs.dart';
import '/modules/layout/pages/admin/menna/trippp/trip_admin_bug.dart';
import '/modules/layout/pages/admin/pages/attractions/pages/browse_attractions/pages/browse_attractions.dart';
import '/modules/layout/pages/admin/pages/attractions/pages/delete_attractions/pages/delete_attraction.dart';
import '/modules/layout/pages/admin/pages/attractions/pages/update_attractions/pages/update_attraction.dart';
import '/modules/layout/pages/admin/menna/updateflight.dart';
import '/modules/layout/pages/admin/pages/attractions/pages/new_attractions/pages/new_attraction.dart';
import '/modules/layout/pages/admin/pages/hotels/pages/rana/add_hotel/admin_add_hotel.dart';
import '/modules/layout/pages/admin/pages/hotels/pages/rana/delete_hotel/admin_delete_hotel.dart';
import '/modules/layout/pages/admin/pages/hotels/pages/rana/update_hotel/admin_update_hotel.dart';

import 'addflight.dart';
import 'browseflight.dart';
import 'deleteflight.dart';


class AdminHomeScreen extends StatelessWidget {
  final Map<String, Widget Function()> pageRoutes = {
    "Browse Trip": () => TripAdminScreen(),
    "Delete Trip": () => NewTripScreen(),
    "New Trip": () => NewTripScreen(),
    "Update Trip": () => NewTripScreen(),
    "Programs": () => ExploreProgram(),
    "Assign Flight": () => Addflight(),
    "Assign Hotel": () => Addflight(),
    "Browse Flight": () => Browseflight(),
    "Delete Flight": () => Deleteflight(),
    "New Flight": () => Addflight(),
    "Update Flight": () => Updateflight(),
    "Browse Hotel": () => Addflight(),
    "Delete Hotel": () => AdminHotelScreenDelete(),
    "New Hotel": () => AdminHotelScreenAdd(),
    "Update Hotel": () => AdminHotelScreenUpdate(),
    "Browse Attraction": () => BrowseAttractions(),
    "Delete Attraction": () => DeleteAttraction(),
    "New Attraction": () => NewAttraction(),
    "Update Attraction": () => UpdateAttraction(),
  };

  void _handleMenuSelection(BuildContext context, String value) {
    if (pageRoutes.containsKey(value)) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => pageRoutes[value]!(),
        ),
      );
    } else {
      print("Page not found for: $value");
    }
  }

  Widget _buildLargePopupMenu(BuildContext context, String title) {
    List<String> menuOptions = title == "Trip"
        ? [
            "Browse Trip",
            "Delete Trip",
            "New Trip",
            "Update Trip",
            "Programs",
            "Assign Flight",
            "Assign Hotel"
          ]
        : ["Browse $title", "Delete $title", "New $title", "Update $title"];

    return PopupMenuButton<String>(
      onSelected: (value) => _handleMenuSelection(context, value),
      itemBuilder: (BuildContext context) => menuOptions
          .map(
            (option) => PopupMenuItem(
              value: option,
              child: Text(
                option,
                style: TextStyle(fontSize: 18),
              ),
            ),
          )
          .toList(),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
        decoration: BoxDecoration(
          color: Color(0xff0d75b4),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title,
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(width: 10),
            Icon(
              Icons.arrow_drop_down,
              color: Colors.white,
              size: 18,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Travel GO",
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: AppColors.whiteColor,
          ),
        ),
        centerTitle: true,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.article_rounded,
              color: Color(0xff0d75b4),
            ),
            label: 'Reports',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              color: Color(0xff0d75b4),
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
              color: Color(0xff0d75b4),
            ),
            label: 'Profile',
          ),
        ],
        selectedItemColor: Color(0xff0d75b4),
        unselectedItemColor: Color(0xff0d75b4),
      ),
      body: Column(
        children: [
          SizedBox(height: 20),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildLargePopupMenu(context, "Trip"),
                  SizedBox(width: 10),
                  _buildLargePopupMenu(context, "Flight"),
                  SizedBox(width: 10),
                  _buildLargePopupMenu(context, "Hotel"),
                  SizedBox(width: 10),
                  _buildLargePopupMenu(context, "Attraction"),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
