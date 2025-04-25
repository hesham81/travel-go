import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:route_transitions/route_transitions.dart';
import 'package:travel_go/core/constant/app_assets.dart';
import 'package:travel_go/core/providers/connections_provider.dart';
import 'package:travel_go/core/theme/app_colors.dart';
import '../../../../../../admin/menna/trippp/utils/trips_collections.dart';
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
  TripDataModel? trip;

  Future<void> _getCurrentTrip() async {
    TripDepartureDataModel tripDepartureDataModel =
        Provider.of<ReservationProvider>(context, listen: false)
            .getSelectedDeparture!;
    trip = await TripCollections.getTrip(tripDepartureDataModel.tripId);
    setState(() {});
  }

  @override
  void initState() {
    Future.wait([
      _getCurrentTrip(),
    ]);
    super.initState();
  }

  List<TripDepartureDataModel> departures = [];

  final List<String> _filterList = [
    "all",
    "Today",
    "Tomorrow",
    "This Week",
    "This Month",
  ];
  int selectedIndex = 0;
  List<TripDepartureDataModel> filterList = [];

  bool _checkIsAvailable(TripDepartureDataModel model) {
    bool isAvailable = false;
    if (model.availableSeats > 0 &&
        model.from.day != DateTime.now().day &&
        DateTime.now().isBefore(model.from)) {
      isAvailable = true;
    }
    return isAvailable;
  }

  bool _checkIsTomorrow(TripDepartureDataModel model) {
    DateTime tomorrow = DateTime.now().add(Duration(days: 1));
    return model.from.year == tomorrow.year &&
        model.from.month == tomorrow.month &&
        model.from.day == tomorrow.day;
  }

  bool _checkIfToday(TripDepartureDataModel model) {
    if (model.from.day == DateTime.now().day &&
        model.from.month == DateTime.now().month &&
        model.from.year == DateTime.now().year) {
      return true;
    }
    return false;
  }

  bool _checkIsThisWeek(TripDepartureDataModel model) {
    DateTime now = DateTime.now();
    DateTime startOfWeek = now.subtract(Duration(days: now.weekday - 1));
    DateTime endOfWeek = startOfWeek.add(Duration(days: 6));
    return model.from.isAfter(startOfWeek) && model.from.isBefore(endOfWeek);
  }

  bool _checkIsThisMonth(TripDepartureDataModel model) {
    DateTime now = DateTime.now();
    DateTime startOfMonth = DateTime(now.year, now.month, 1);
    DateTime endOfMonth = DateTime(now.year, now.month + 1, 0);
    return model.from.isAfter(startOfMonth) && model.from.isBefore(endOfMonth);
  }

  void _filter() {
    switch (selectedIndex) {
      case 0:
        filterList = departures;
        setState(() {});
        break;

      case 1:
        filterList =
            departures.where((element) => _checkIfToday(element)).toList();
        setState(() {});
        break;
      case 2:
        filterList =
            departures.where((element) => _checkIsTomorrow(element)).toList();
        setState(() {});
        break;
      case 3:
        filterList =
            departures.where((element) => _checkIsThisWeek(element)).toList();
        setState(() {});
        break;
      case 4:
        filterList =
            departures.where((element) => _checkIsThisMonth(element)).toList();
        setState(() {});
        break;
      default:
        filterList = departures;
        setState(() {});
        break;
    }
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
                    setState(() {
                      selectedIndex = index;
                      _filter();
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
                    .where((element) => widget.model.tripId == element.tripId)
                    .toList();
                departures = departures
                    .where(
                      (element) => (element.availableSeats != 0 &&
                          element.from.day != DateTime.now().day),
                    )
                    .toList();
                if (selectedIndex == 0) filterList = departures;
                if (filterList.isEmpty) {
                  return Image.asset(AppAssets.noSearchResult);
                }
                return (providerConnections.getConnectionStatus)
                    ? ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.zero,
                        itemBuilder: (context, index) => GestureDetector(
                          onTap: (filterList[index].availableSeats > 0 &&
                                  filterList[index].from.day !=
                                      DateTime.now().day)
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
                            isAvaialble: filterList[index]
                                    .from
                                    .isAfter(DateTime.now()) &&
                                filterList[index].availableSeats > 0 &&
                                filterList[index].from.day !=
                                    DateTime.now().day,
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
