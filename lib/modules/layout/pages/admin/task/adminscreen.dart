import 'package:flutter/material.dart';
import 'package:travel_go/core/routes/route_names.dart';
import 'package:travel_go/core/utils/firebase_auth_services.dart';
import '/modules/layout/pages/admin/task/attractionscreen.dart';
import '/modules/layout/pages/admin/task/flightscreen.dart';
import '/modules/layout/pages/admin/task/hotelscreen.dart';
import '/core/routes/route_transact.dart';
import '/modules/layout/pages/admin/task/tripscreen.dart';
import '/core/extensions/extensions.dart';

class AdminHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(onPressed: () {
                    FirebaseAuthServices.logout();
                    Navigator.pushNamedAndRemoveUntil(context, RouteNames.signIn, (route) => false,);
                  }, icon: Icon(Icons.logout)),
                  GestureDetector(
                    onTap: () => Navigator.push(
                      context,
                      SlideRightRoute(
                        page: Tripscreen(),
                      ),
                    ),
                    child: Container(
                      height: 0.2.height,
                      width: 0.42.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        image: DecorationImage(
                          image: AssetImage(
                            "assets/images/trip_background_admin_page.jpeg",
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.push(
                      context,
                      SlideRightRoute(
                        page: HotelScreen(),
                      ),
                    ),
                    child: Container(
                      height: 0.2.height,
                      width: 0.42.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        image: DecorationImage(
                          image: AssetImage(
                            "assets/images/hotel_admin_bg.jpg",
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              0.01.height.hSpace,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.push(
                      context,
                      SlideRightRoute(
                        page: flightscreen(),
                      ),
                    ),
                    child: Container(
                      height: 0.2.height,
                      width: 0.42.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        image: DecorationImage(
                          image: AssetImage(
                            "assets/images/flight_admin_bg_image.jpg",
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.push(
                      context,
                      SlideRightRoute(
                        page: Attraction(),
                      ),
                    ),
                    child: Container(
                      height: 0.2.height,
                      width: 0.42.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        image: DecorationImage(
                          image: AssetImage(
                            "assets/images/attraction_background_image_admin.jpg",
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
