import 'package:flutter/material.dart';
import 'package:route_transitions/route_transitions.dart';
import 'package:travel_go/core/theme/app_colors.dart';
import 'package:travel_go/core/utils/firebase_auth_services.dart';
import 'package:travel_go/modules/layout/pages/admin/task/flightscreen.dart';
import 'package:travel_go/modules/layout/pages/admin/task/hotelscreen.dart';
import 'package:travel_go/modules/layout/pages/admin/task/tripscreen.dart';
import 'package:travel_go/modules/sign_in/pages/sign_in.dart';

import 'Addflight.dart';
import 'attractionscreen.dart';

class AdminHome extends StatelessWidget {
  final Map<String, String> imageUrls = {
    "Trip": "https://www.bsr.org/images/heroes/bsr-travel-hero..jpg",
    "Flight":
        "https://www.flightgift.com/media/wp/FG/2023/08/flightgift-reviews-on-trustpilot-aeroplane.webp",
    "Hotel":
        "https://media.istockphoto.com/id/104731717/photo/luxury-resort.jpg?s=612x612&w=0&k=20&c=cODMSPbYyrn1FHake1xYz9M8r15iOfGz9Aosy9Db7mI=",
    "Attraction":
        "https://res.cloudinary.com/rainforest-cruises/images/c_fill,g_auto/f_auto,q_auto/v1661186650/top-10-tourist-attractions-in-india-kailasa-temple/top-10-tourist-attractions-in-india-kailasa-temple.jpg",
  };

  final Map<String, Widget Function()> screens = {
    "Trip": () => AdminTripScreen(),
    "Flight": () => AdminFlightScreen(),
    "Hotel": () => AdminHotelScreen(),
    "Attraction": () => Attraction(),
  };

  Widget _buildGridItem(BuildContext context, String title) {
    return GestureDetector(
      onTap: () {
        slideLeftWidget(
          newPage: screens[title]!(),
          context: context,
        );
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 135,
            width: 135,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                imageUrls[title]!,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                },
                errorBuilder: (context, error, stackTrace) =>
                    Icon(Icons.error, size: 50, color: Colors.red),
              ),
            ),
          ),
          SizedBox(height: 8),
          Text(
            title,
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xff0d75b4)),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () async {
            Navigator.pushNamedAndRemoveUntil(
              context,
              SignIn.routeName,
              (route) => false,
            );
            await FirebaseAuthServices.logout();
          },
          icon: Icon(
            Icons.login_outlined,
            color: AppColors.errorColor,
          ),
        ),
        title: Text(
          "Tour And Travel",
          style: TextStyle(
              fontSize: 26, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: GridView(
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 20,
              crossAxisSpacing: 20,
              childAspectRatio: 0.9,
            ),
            children: imageUrls.keys
                .map((title) => _buildGridItem(context, title))
                .toList(),
          ),
        ),
      ),
    );
  }
}
