import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:travel_go/core/constant/app_assets.dart';
import 'package:travel_go/core/extensions/extensions.dart';
import 'package:travel_go/core/providers/reservation_provider.dart';
import 'package:travel_go/core/theme/app_colors.dart';
import 'package:travel_go/core/widget/custom_elevated_button.dart';
import 'package:travel_go/core/widget/labels_widget.dart';
import 'package:travel_go/modules/layout/pages/user/pages/home/pages/trip/pages/selected_trip/pages/user_trip_flight/widget/source_destination_flight_trip_user.dart';
import 'package:travel_go/modules/layout/pages/user/widget/app_bar.dart';

class FlightReservations extends StatefulWidget {
  const FlightReservations({super.key});

  @override
  State<FlightReservations> createState() => _FlightReservationsState();
}

class _FlightReservationsState extends State<FlightReservations> {
  String _getMonthAbbreviation(int month) {
    const List<String> monthAbbreviations = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ];
    return monthAbbreviations[month - 1];
  }

  String _getDayOfWeek(DateTime date) {
    return DateFormat('EEEE').format(date);
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).textTheme;
    var provider = Provider.of<ReservationProvider>(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SafeArea(
              child: AppBarWidget(),
            ),
            Image.asset(
              AppAssets.flightReservationUsers,
            ),
            SourceDestinationFlightTripUser(
              model: provider.getSelectedDeparture!.trip,
            ),
            0.02.height.hSpace,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.4),
                        spreadRadius: 1,
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Icon(
                        Icons.date_range,
                        color: AppColors.blackColor.withAlpha(90),
                      ),
                      0.01.height.hSpace,
                      Text(
                        "Date",
                        style: theme.labelLarge!.copyWith(
                          color: AppColors.blackColor,
                        ),
                      ),
                      0.01.height.hSpace,
                      Text(
                        "${provider.getSelectedDeparture!.from.day} ${_getMonthAbbreviation(provider.getSelectedDeparture!.from.month)} ${_getDayOfWeek(provider.getSelectedDeparture!.from).substring(0, 3)}",
                        style: theme.labelLarge!.copyWith(
                          color: AppColors.blackColor,
                        ),
                      ),
                    ],
                  ),
                ),
                0.07.width.vSpace,
                Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.4),
                        spreadRadius: 1,
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Icon(
                        Icons.person_outline,
                        color: AppColors.blackColor.withAlpha(90),
                      ),
                      0.01.height.hSpace,
                      Text(
                        "Passengers",
                        style: theme.labelLarge!.copyWith(
                          color: AppColors.blackColor,
                        ),
                      ),
                      0.01.height.hSpace,
                      Text(
                        "${provider.totalUsers + 1} Persons",
                        style: theme.labelLarge!.copyWith(
                          color: AppColors.blackColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ).hPadding(0.03.width),
            0.01.height.hSpace,
            Divider().hPadding(0.25.width),
            0.01.height.hSpace,
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.4),
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                children: [
                  LabelsWidget(
                    label: "Airline : ",
                    value: provider.getSelectedDeparture!.trip.flight.airline!
                        .flighAirLineName,
                  ),
                  0.01.height.hSpace,
                  LabelsWidget(
                    label: "Flight ID : ",
                    value: provider.getSelectedDeparture!.trip.flight.flightId,
                  ),
                  0.01.height.hSpace,
                  LabelsWidget(
                    label: "Duration : ",
                    value: "8 Hours",
                  ),
                  0.01.height.hSpace,
                ],
              ),
            ).hPadding(0.03.width),
            0.03.height.hSpace,
            SizedBox(
              width: double.maxFinite,
              child: Row(
                children: [
                  Expanded(
                    child: CustomElevatedButton(
                      text: "OK",
                      onPressed: () {},
                    ),
                  ),
                  0.03.width.vSpace,
                  Expanded(
                    child: CustomElevatedButton(
                      text: "Cancel",
                      btnColor: AppColors.errorColor,
                      onPressed: ()=> Navigator.pop(context),
                    ),
                  ),
                ],
              ),
            ).hPadding(0.03.width)
          ],
        ),
      ),
    );
  }
}
