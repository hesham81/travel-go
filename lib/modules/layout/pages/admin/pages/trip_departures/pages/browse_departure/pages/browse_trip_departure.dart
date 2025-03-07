import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel_go/core/routes/route_transact.dart';
import 'package:travel_go/modules/layout/pages/admin/pages/trip_departures/pages/browse_departure/pages/explore_selected_list_of_departures.dart';
import '/core/providers/collections_provider.dart';
import '/core/extensions/extensions.dart';
import '/core/theme/app_colors.dart';
import '/modules/layout/pages/admin/pages/trip_departures/pages/browse_departure/widget/trip_explorer.dart';

class BrowseTripDeparture extends StatelessWidget {
  const BrowseTripDeparture({super.key});

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
          "Trip Departures",
          style: theme.titleLarge!.copyWith(
            color: AppColors.whiteColor,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            0.01.height.hSpace,
            ListView.separated(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) => GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  SlideRightRoute(
                    page: ExploreSelectedListOfDepartures(
                      model: provider.getAllTripsData[index],
                    ),
                  ),
                ),
                child: TripExplorer(
                  model: provider.getAllTripsData[index],
                ),
              ),
              separatorBuilder: (context, _) => 0.01.height.hSpace,
              itemCount: provider.getAllTripsData.length,
            ),
          ],
        ).hPadding(0.03.width),
      ),
    );
  }
}
