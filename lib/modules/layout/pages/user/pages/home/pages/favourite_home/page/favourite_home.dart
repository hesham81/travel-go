import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:route_transitions/route_transitions.dart';
import 'package:travel_go/modules/layout/pages/user/pages/home/pages/trip/pages/selected_trip/pages/selected_trip.dart';
import '/core/extensions/extensions.dart';
import '/core/theme/app_colors.dart';
import '/modules/layout/pages/admin/menna/trippp/utils/trips_collections.dart';
import '/modules/layout/pages/user/pages/home/pages/trip/widget/home_trip_cart_widget.dart';
import '/modules/layout/pages/user/widget/app_bar.dart';
import '/core/utils/firebase_auth_services.dart';
import '/models/trip_data_model.dart';
import 'favourite_flights.dart';
import 'favourite_hotels.dart';
import 'favourite_trips.dart';

class FavouriteHome extends StatefulWidget {
  const FavouriteHome({super.key});

  @override
  State<FavouriteHome> createState() => _FavouriteHomeState();
}

class _FavouriteHomeState extends State<FavouriteHome> {
  List<String> favouriteItems = [
    "Trips",
    "Hotels",
    "Flights",
  ];
  List<Widget> body = [
    FavouriteTrips(),
    FavouriteHotels(),
    FavouriteFlights(),
  ];
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SafeArea(
            child: AppBarWidget(),
          ),
          SizedBox(
            height: 0.05.height,
            child: ListView.separated(
              padding: EdgeInsets.symmetric(horizontal: 10),
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) => ElevatedButton(
                onPressed: () {
                  setState(() {
                    selectedIndex = index;
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: (selectedIndex == index)
                      ? AppColors.newBlueColor
                      : AppColors.whiteColor,
                  side: BorderSide(
                    color: (selectedIndex == index)
                        ? AppColors.newBlueColor
                        : AppColors.newBlueColor,
                    width: 1,
                  ),
                ),
                child: Text(
                  favouriteItems[index],
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        color: (selectedIndex == index)
                            ? AppColors.whiteColor
                            : AppColors.blackColor,
                      ),
                ),
              ),
              separatorBuilder: (context, _) => 0.02.width.vSpace,
              itemCount: favouriteItems.length,
            ),
          ),
          0.01.height.hSpace,
          body[selectedIndex]
        ],
      ),
    );
  }
}
