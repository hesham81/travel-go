import 'package:flutter/material.dart';
import 'package:roundcheckbox/roundcheckbox.dart';
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

  @override
  void initState() {
    FlightCollections.getAllFlight().then(
      (value) {
        flights = value;
        print(value.first.flightName);
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var style = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Assign Flight",
          style: style.titleLarge!.copyWith(
            color: AppColors.whiteColor,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
                RoundCheckBox(
                  onTap: (p0) {},
                  uncheckedColor: AppColors.greyColor,
                  checkedWidget: Icon(
                    Icons.flight_outlined,
                    color: AppColors.whiteColor,
                  ),
                  checkedColor: AppColors.newBlueColor,
                ),
                Text(
                  ""
                ),
              ],
            ),
          ],
        ).allPadding(10),
      ),
    );
  }
}
