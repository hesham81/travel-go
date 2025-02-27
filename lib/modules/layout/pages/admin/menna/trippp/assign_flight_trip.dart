import 'package:flutter/material.dart';
import 'package:roundcheckbox/roundcheckbox.dart';
import 'package:travel_go/core/extensions/align.dart';
import '/core/extensions/extensions.dart';
import '/core/theme/app_colors.dart';
import '/core/utils/flight_collections.dart';
import '/models/flight.dart';

class AssignFlightTrip extends StatefulWidget {
  static const routeName = '/assign-flight-trip';

  const AssignFlightTrip({super.key});

  @override
  State<AssignFlightTrip> createState() => _AssignFlightTripState();
}

class _AssignFlightTripState extends State<AssignFlightTrip> {
  List<Flight> flights = [];

  _loadFlightsData() async {
    flights = await FlightCollections.getAllFlight().then(
      (value) => value,
    );
  }

  @override
  void initState() {
    _loadFlightsData();
    super.initState();
  }

  int? selectedIndex;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Assign Flight",
          style: theme.titleLarge!.copyWith(
            color: AppColors.whiteColor,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            StreamBuilder(
              stream: FlightCollections.StreamFlight(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator(
                    color: AppColors.newBlueColor,
                  ).center;
                }
                flights = snapshot.data!.docs
                    .map(
                      (e) => e.data(),
                )
                    .toList();
                return ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) => Row(
                    children: [
                      RoundCheckBox(
                        onTap: (_) {
                          selectedIndex = index;
                          setState(() {});
                        },
                        uncheckedColor: AppColors.greyColor,
                        isChecked:
                        (selectedIndex == index && selectedIndex != null)
                            ? true
                            : false,
                        borderColor: AppColors.newBlueColor,
                        checkedWidget: Icon(
                          Icons.flight_outlined,
                          color: AppColors.whiteColor,
                        ),
                        checkedColor: AppColors.newBlueColor,
                      ),
                      0.02.width.vSpace,
                      Text(
                        "Flight ${flights[index].flightName}",
                        style: theme.titleMedium,
                      ),
                      0.02.width.vSpace,
                      Text(
                        flights[index].airline!.flighAirLineName,
                        style: theme.titleMedium,
                      ),
                    ],
                  ),
                  separatorBuilder: (context, _) => 0.01.height.hSpace,
                  itemCount: flights.length,
                );
              },
            ),
          ],
        ).allPadding(10),
      ),
    );
  }
}
