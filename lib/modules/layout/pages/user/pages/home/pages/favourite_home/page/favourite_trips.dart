import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:route_transitions/route_transitions.dart';
import 'package:travel_go/core/extensions/extensions.dart';

import '../../../../../../../../../core/utils/firebase_auth_services.dart';
import '../../../../../../../../../models/trip_data_model.dart';
import '../../../../../../admin/menna/trippp/utils/trips_collections.dart';
import '../../trip/pages/selected_trip/pages/selected_trip.dart';
import '../../trip/widget/home_trip_cart_widget.dart';

class FavouriteTrips extends StatefulWidget {
  const FavouriteTrips({super.key});

  @override
  State<FavouriteTrips> createState() => _FavouriteTripsState();
}

class _FavouriteTripsState extends State<FavouriteTrips> {
  User? user = FirebaseAuthServices.getCurrentUserData();
  List<TripDataModel> favouriteTrips = [];

  _getAllFavouriteTrips() {
    User? user = FirebaseAuthServices.getCurrentUserData();
    TripCollections.getAllTrips().listen(
      (event) {
        favouriteTrips.clear();
        for (var element in event.docs) {
          TripDataModel model = element.data();
          if (model.favourites?.isNotEmpty ?? false)
            for (String id in model.favourites!) {
              if (id == user!.uid) {
                favouriteTrips.add(model);
                setState(() {});
                break;
              }
            }
        }
      },
    );
  }

  @override
  void initState() {
    _getAllFavouriteTrips();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.symmetric(horizontal: 10),
      itemBuilder: (context, index) => GestureDetector(
        onTap: () {
          slideLeftWidget(
            newPage: SelectedHomeScreenTrip(model: favouriteTrips[index]),
            context: context,
          );
        },
        child: HomeTripCartWidget(
          model: favouriteTrips[index],
        ),
      ),
      separatorBuilder: (context, _) => 0.01.height.hSpace,
      itemCount: favouriteTrips.length,
    );
  }
}
