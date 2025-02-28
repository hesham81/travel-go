import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:roundcheckbox/roundcheckbox.dart';
import 'package:travel_go/core/extensions/align.dart';
import 'package:travel_go/core/providers/trip_admin_provider.dart';
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

  int? selectedIndex;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).textTheme;
    var provider = Provider.of<TripAdminProvider>(context);

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
                  itemBuilder: (context, index) => SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        RoundCheckBox(
                          onTap: (_) {
                            provider.setSelectionFlight(flights[index]);
                          },
                          uncheckedColor: AppColors.greyColor,
                          isChecked: (provider.getSelectionFlight != null)
                              ? (provider.getSelectionFlight!.flightId ==
                                      flights[index].flightId)
                                  ? true
                                  : false
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
