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

List<Tripppp> trips = [
  Tripppp(
    id: "T001",
    name: "Paris Getaway",
    organizedBy: "Global Travels",
    source: "New York, USA",
    destination: "Paris, France",
    days: 7,
    imageUrl:
        "https://i.pinimg.com/474x/fa/95/98/fa95986f2c408098531ca7cc78aee3a4.jpg",
    price: 2500.00,
    hotel: "Eiffel Grand Hotel",
    flight: "Air France",
  ),
  Tripppp(
    id: "T002",
    name: "Egyptian Wonders",
    organizedBy: "Sunshine Tours",
    source: "London, UK",
    destination: "Cairo, Egypt",
    days: 10,
    imageUrl:
        "https://i.pinimg.com/474x/dc/12/01/dc12011c464a71a27804617a107135e0.jpg",
    price: 1800.00,
    program: "Pyramids, Nile Cruise, Museum Tour",
    hotel: "Cairo Royal Hotel",
  ),
  Tripppp(
    id: "T003",
    name: "Tokyo Adventure",
    organizedBy: "Explore Japan",
    source: "Los Angeles, USA",
    destination: "Tokyo, Japan",
    days: 12,
    imageUrl:
        "https://i.pinimg.com/originals/a8/9e/48/a89e48d3bfa44e3832736fd72a6d612b.jpg",
    price: 3200.00,
    flight: "Japan Airlines",
  ),
  Tripppp(
    id: "T004",
    name: "Bali Retreat",
    organizedBy: "Paradise Travels",
    source: "Sydney, Australia",
    destination: "Bali, Indonesia",
    days: 7,
    imageUrl:
        "https://i.pinimg.com/474x/eb/40/44/eb40447e0413f2a4ee29ffaa81df012b.jpg",
    price: 2100.00,
    hotel: "Bali Beach Resort",
    flight: "Garuda Indonesia",
  ),
  Tripppp(
    id: "T005",
    name: "Santorini Escape",
    organizedBy: "Blue Wave Tours",
    source: "Rome, Italy",
    destination: "Santorini, Greece",
    days: 5,
    imageUrl:
        "https://i.pinimg.com/474x/12/7b/d2/127bd284cc443c874d884288ba19cf2c.jpg",
    price: 1700.00,
    hotel: "Santorini Sunset Hotel",
  ),
  Tripppp(
    id: "T006",
    name: "Swiss Alps Adventure",
    organizedBy: "Alpine Holidays",
    source: "Berlin, Germany",
    destination: "Zurich, Switzerland",
    days: 8,
    imageUrl:
        "https://i.pinimg.com/474x/4c/bd/16/4cbd163316ca0c0e2bb798103eaf7631.jpg",
    price: 2900.00,
    program: "Mountain Hiking, Skiing, City Tour",
  ),
  Tripppp(
    id: "T007",
    name: "Dubai Luxury Tour",
    organizedBy: "Elite Voyages",
    source: "Toronto, Canada",
    destination: "Dubai, UAE",
    days: 6,
    imageUrl:
        "https://i.pinimg.com/474x/42/90/3a/42903acd55a146c739f74682ea3aab2c.jpg",
    price: 3500.00,
    hotel: "Burj Al Arab",
    flight: "Emirates",
  ),
  Tripppp(
    id: "T008",
    name: "Maldives Honeymoon",
    organizedBy: "Romantic Escapes",
    source: "Mumbai, India",
    destination: "Maldives",
    days: 7,
    imageUrl:
        "https://i.pinimg.com/originals/1c/8b/98/1c8b98e4d98e3c5c9847fb179733875d.jpg",
    price: 4500.00,
    hotel: "Maldives Water Villas",
  ),
  Tripppp(
    id: "T009",
    name: "Rome Historical Tour",
    organizedBy: "Ancient Paths",
    source: "Madrid, Spain",
    destination: "Rome, Italy",
    days: 5,
    imageUrl:
        "https://i.pinimg.com/474x/ad/7f/d2/ad7fd2eb79a48fe8b9cae8869d7fd5fd.jpg",
    price: 1900.00,
    program: "Colosseum, Vatican, Roman Forum",
  ),
  Tripppp(
    id: "T010",
    name: "New York City Lights",
    organizedBy: "Urban Explorer",
    source: "Chicago, USA",
    destination: "New York, USA",
    days: 4,
    imageUrl:
        "https://i.pinimg.com/474x/e0/b3/9d/e0b39de139ed656413d74c22e725fc0f.jpg",
    price: 1400.00,
    hotel: "Times Square Marriott",
  ),
  Tripppp(
    id: "T011",
    name: "Machu Picchu Expedition",
    organizedBy: "Inca Trails",
    source: "Lima, Peru",
    destination: "Machu Picchu, Peru",
    days: 6,
    imageUrl:
        "https://i.pinimg.com/474x/f4/04/d3/f404d3e6b96fe02851b14a0d5b2ef4c2.jpg",
    price: 2300.00,
    program: "Hiking the Inca Trail",
  ),
  Tripppp(
    id: "T012",
    name: "London City Tour",
    organizedBy: "UK Adventures",
    source: "Dublin, Ireland",
    destination: "London, UK",
    days: 5,
    imageUrl:
        "https://i.pinimg.com/474x/aa/a4/cb/aaa4cbf7a92dc6d8302199b08eadf9d5.jpg",
    price: 1600.00,
    flight: "British Airways",
  ),
  Tripppp(
    id: "T013",
    name: "Iceland Northern Lights",
    organizedBy: "Aurora Travels",
    source: "Oslo, Norway",
    destination: "Reykjavik, Iceland",
    days: 7,
    imageUrl:
        "https://i.pinimg.com/474x/7e/b0/6d/7eb06dd56e7fa99fb1696a975c9c0a6f.jpg",
    price: 2700.00,
    program: "Northern Lights Hunting, Ice Caves",
  ),
];

class AdminHomeScreen extends StatelessWidget {
  final Map<String, Widget Function()> pageRoutes = {
    "Browse Trip": () => TripAdminScreen(),
    "Delete Trip": () => BrowseTripScreen(trips: trips),
    "New Trip": () => NewTripScreen(),
    "Update Trip": () => BrowseTripScreen(trips: trips),
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
