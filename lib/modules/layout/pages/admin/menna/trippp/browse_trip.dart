import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/core/extensions/extensions.dart';
import '/core/providers/collections_provider.dart';
import '/core/theme/app_colors.dart';
import '/models/trip_data_model.dart';
import '/modules/layout/pages/admin/menna/trippp/utils/trips_collections.dart';
import '/modules/layout/pages/admin/widget/trip_cart_widget.dart';

class BrowseTrip extends StatefulWidget {
  const BrowseTrip({super.key});

  @override
  State<BrowseTrip> createState() => _BrowseTripState();
}

class _BrowseTripState extends State<BrowseTrip> {
  List<TripDataModel> trips = [];

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).textTheme;
    var provider = Provider.of<CollectionsProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Browse Trip",
          style: theme.titleLarge!.copyWith(
            color: AppColors.whiteColor,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            StreamBuilder(
              stream: TripCollections.getAllTrips(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                }
                trips = snapshot.data!.docs
                    .map(
                      (e) => e.data(),
                    )
                    .toList();
                return ListView.separated(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) => TripCartWidget(
                    model: trips[index],
                  ),
                  separatorBuilder: (context, index) => 0.02.height.hSpace,
                  itemCount: trips.length,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
