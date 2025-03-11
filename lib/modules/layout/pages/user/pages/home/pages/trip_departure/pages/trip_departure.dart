import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:route_transitions/route_transitions.dart';
import 'package:travel_go/core/constant/app_assets.dart';
import 'package:travel_go/core/providers/connections_provider.dart';
import 'package:travel_go/core/theme/app_colors.dart';
import '/core/providers/reservation_provider.dart';
import '/modules/layout/pages/user/pages/home/pages/reservation/pages/reservation.dart';
import '/core/extensions/extensions.dart';
import '/models/trip_data_model.dart';
import '/modules/layout/pages/admin/pages/trip_departures/data/model/trip_departure_data_model.dart';
import '/modules/layout/pages/admin/pages/trip_departures/data/use_case/departures.dart';
import '/modules/layout/pages/user/pages/home/pages/trip_departure/widget/trip_departure_user_widget.dart';
import '/modules/layout/pages/user/widget/app_bar.dart';

class TripDeparture extends StatefulWidget {
  final TripDataModel model;

  const TripDeparture({
    super.key,
    required this.model,
  });

  @override
  State<TripDeparture> createState() => _TripDepartureState();
}

class _TripDepartureState extends State<TripDeparture> {
  bool? isConnected;

  List<TripDepartureDataModel> departures = [];

  final List<String> _filterList = [
    "all",
    "Available",
    "Today",
    "Tomorrow",
    "This Week",
    "This Month",
  ];
  int selectedIndex = 0;
  List<TripDepartureDataModel> filterList = [];

  bool _checkIsAvailable(TripDepartureDataModel model) {
    print("${DateTime.now().year} ${DateTime.now().month} ${DateTime.now().day}");
    return model.from.isAfter(DateTime.now());

  }

  void _filter() {
    switch (selectedIndex) {
      case 0:
        filterList = departures;
        break;
      case 1:
        filterList = departures
            .where((element) => _checkIsAvailable(element))
            .toList();
        break;
      case 2:
        filterList = departures
            .where((element) => !_checkIsAvailable(element))
            .toList();
        break;
      default: // No filter applied
        filterList = departures;
        break;
    }
    setState(() {}); // Update the UI
    print("Filtered List Length: ${filterList.length}"); // Debugging
  }

  @override
  Widget build(BuildContext context) {
    var providerConnections = Provider.of<ConnectionProvider>(context);
    var provider = Provider.of<ReservationProvider>(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
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
                    _filter();
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
                    _filterList[index],
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          color: (selectedIndex == index)
                              ? AppColors.whiteColor
                              : AppColors.blackColor,
                        ),
                  ),
                ),
                separatorBuilder: (context, _) => 0.02.width.vSpace,
                itemCount: _filterList.length,
              ),
            ),
            0.02.height.hSpace,
            StreamBuilder(
              stream: TripDeparturesCollection.getStreamDepartures(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Column(
                    children: [
                      0.2.height.hSpace,
                      Lottie.file("assets/icons/no_favourite.json"),
                    ],
                  );
                }
                departures = snapshot.data!.docs
                    .map(
                      (e) => e.data(),
                    )
                    .toList()
                    .where(
                        (element) => element.trip.tripId == widget.model.tripId)
                    .toList();
                if (selectedIndex == 0) filterList = departures;
                return (providerConnections.getConnectionStatus)
                    ? ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.zero,
                        itemBuilder: (context, index) => GestureDetector(
                          onTap: (filterList[index]
                                  .from
                                  .isAfter(DateTime.now()))
                              ? () {
                                  provider
                                      .setSelectedDeparture(filterList[index]);
                                  slideRightWidget(
                                    newPage: Reservation(),
                                    context: context,
                                  );
                                }
                              : null,
                          child: TripDepartureUserWidget(
                            model: filterList[index],
                          ),
                        ),
                        separatorBuilder: (context, _) => 0.01.height.hSpace,
                        itemCount: filterList.length,
                      )
                    : Image.asset(AppAssets.noInternetConnections);
              },
            ),
            0.03.height.hSpace,
          ],
        ),
      ),
    );
  }
}
