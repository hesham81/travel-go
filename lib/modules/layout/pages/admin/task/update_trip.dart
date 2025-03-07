import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel_go/modules/layout/pages/admin/menna/trippp/update_cart_widget.dart';
import '/core/widget/search_widget.dart';
import '/modules/layout/pages/admin/menna/trippp/browse_selected_trip.dart';
import '/core/extensions/extensions.dart';
import '/core/providers/collections_provider.dart';
import '/core/theme/app_colors.dart';
import '/models/trip_data_model.dart';
import '/modules/layout/pages/admin/menna/trippp/utils/trips_collections.dart';

class UpdateTrip extends StatefulWidget {
  const UpdateTrip({super.key});

  @override
  State<UpdateTrip> createState() => _UpdateTripState();
}

class _UpdateTripState extends State<UpdateTrip> {
  List<TripDataModel> trips = [];

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).textTheme;
    var provider = Provider.of<CollectionsProvider>(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            Icons.arrow_back_ios,
          ),
        ),
        title: Text(
          "Update Trips",
          style: theme.titleLarge!.copyWith(
            color: AppColors.whiteColor,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            0.01.height.hSpace,
            SearchWidget(
              controller: TextEditingController(),
            ),
            0.01.height.hSpace,
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
                  itemBuilder: (context, index) => GestureDetector(
                    onTap: () => Navigator.pushNamed(
                      context,
                      BrowseSelectedTrip.routeName,
                      arguments: trips[index],
                    ),

                    child: UpdateTripCartWidget(
                      model: trips[index],
                    ),
                  ),
                  separatorBuilder: (context, index) => 0.02.height.hSpace,
                  itemCount: trips.length,
                );
              },
            ),
          ],
        ).hPadding(0.03.width),
      ),
    );
  }
}
