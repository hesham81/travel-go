import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '/core/utils/firebase_auth_services.dart';
import '/models/trip_data_model.dart';
import '/modules/layout/pages/user/pages/home/pages/favourite_home/data/use%20case/favourite_collections.dart';
import '/modules/layout/pages/user/pages/home/pages/favourite_home/widget/favourite_widget.dart';
import '/core/extensions/align.dart';

class FavouriteHome extends StatefulWidget {
  const FavouriteHome({super.key});

  @override
  State<FavouriteHome> createState() => _FavouriteHomeState();
}

class _FavouriteHomeState extends State<FavouriteHome> {
  User? user = FirebaseAuthServices.getCurrentUserData();
  List<TripDataModel> favouriteTrips = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          StreamBuilder(
            stream: FavouriteCollections.getTripStream(user?.uid ?? ""),
            builder: (context, snapshot) {
              if (snapshot.hasData == false) {
                return Lottie.asset(
                  "assets/icons/no_favourite.json",
                ).center;
              } else if (snapshot.hasData) {
                favouriteTrips = snapshot.data!.trips;
              }
              return FavouriteWidget();
            },
          ),
        ],
      ),
    );
  }
}
