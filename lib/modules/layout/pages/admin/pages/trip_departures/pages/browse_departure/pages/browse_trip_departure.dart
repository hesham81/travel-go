import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel_go/core/routes/route_transact.dart';
import 'package:travel_go/models/trip_data_model.dart';
import 'package:travel_go/modules/layout/pages/admin/pages/trip_departures/pages/browse_departure/pages/explore_selected_list_of_departures.dart';
import '/core/providers/collections_provider.dart';
import '/core/extensions/extensions.dart';
import '/core/theme/app_colors.dart';
import '/modules/layout/pages/admin/pages/trip_departures/pages/browse_departure/widget/trip_explorer.dart';

class BrowseTripDeparture extends StatefulWidget {
  const BrowseTripDeparture({super.key});

  @override
  State<BrowseTripDeparture> createState() => _BrowseTripDepartureState();
}

class _BrowseTripDepartureState extends State<BrowseTripDeparture> {
  final TextEditingController searchController = TextEditingController();
  List<TripDataModel> searchList = [];

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).textTheme;
    var provider = Provider.of<CollectionsProvider>(context);
    onSearchChanged(String searchQuery) {
      searchList = [];
      for (var trip in provider.getAllTripsData) {
        if (trip.tripName.toLowerCase().contains(
              searchQuery.toLowerCase(),
            )) {
          searchList.add(trip);
        }
      }
      setState(() {});
    }

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
            CupertinoSearchTextField(
              controller: searchController,
              onChanged: (value) {
                onSearchChanged(value);
                setState(() {});
              },
            ),
            0.01.height.hSpace,
            ListView.separated(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) => GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  SlideRightRoute(
                    page: ExploreSelectedListOfDepartures(
                      model: (searchList.isNotEmpty)
                          ? searchList[index]
                          : provider.getAllTripsData[index],
                    ),
                  ),
                ),
                child: TripExplorer(
                  model: (searchList.isNotEmpty)
                      ? searchList[index]
                      : provider.getAllTripsData[index],
                ),
              ),
              separatorBuilder: (context, _) => 0.01.height.hSpace,
              itemCount: searchList.isNotEmpty
                  ? searchList.length
                  : provider.getAllTripsData.length,
            ),
          ],
        ).hPadding(0.03.width),
      ),
    );
  }
}
