import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:route_transitions/route_transitions.dart';
import 'package:travel_go/modules/layout/pages/user/pages/home/pages/payment/pages/credt_card.dart';
import 'package:travel_go/modules/layout/pages/user/pages/home/pages/reservation/pages/hotel_reservation/pages/hotel_reservations_info/pages/hotel_reservation_user.dart';
import '/core/constant/app_assets.dart';
import '/core/extensions/extensions.dart';
import '/core/providers/reservation_provider.dart';
import '/core/theme/app_colors.dart';
import '/core/widget/custom_elevated_button.dart';
import '/modules/layout/pages/user/pages/home/pages/trip/pages/selected_trip/pages/user_trip_flight/widget/source_destination_flight_trip_user.dart';
import '/modules/layout/pages/user/widget/app_bar.dart';

class FlightAccomdationsReservations extends StatelessWidget {
  const FlightAccomdationsReservations({super.key});

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<ReservationProvider>(context);
    var theme = Theme.of(context).textTheme;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SafeArea(
              child: AppBarWidget(),
            ),
            SourceDestinationFlightTripUser(
              model: provider.getSelectedDeparture!.trip,
            ),
            0.02.height.hSpace,
            Row(
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 35, vertical: 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.4),
                        spreadRadius: 1,
                        blurRadius: 5,
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Column(
                        children: [
                          Text(
                            provider.getSelectedDeparture!.from.day.toString(),
                            style: theme.titleLarge!.copyWith(
                              color: AppColors.newBlueColor,
                            ),
                          ),
                          Text(
                            provider.getMonthAbbreviation(
                              provider.getSelectedDeparture!.from.month,
                            ),
                            style: theme.titleLarge!.copyWith(
                              color: AppColors.newBlueColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Spacer(),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 35, vertical: 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.4),
                        spreadRadius: 1,
                        blurRadius: 5,
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Column(
                        children: [
                          Text(
                            provider.getSelectedDeparture!.to.day.toString(),
                            style: theme.titleLarge!.copyWith(
                              color: AppColors.newBlueColor,
                            ),
                          ),
                          Text(
                            provider.getMonthAbbreviation(
                              provider.getSelectedDeparture!.to.month,
                            ),
                            style: theme.titleLarge!.copyWith(
                              color: AppColors.newBlueColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ).hPadding(0.03.width),
            0.02.height.hSpace,
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
                  ),
                ],
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image(
                        image: AssetImage(
                          "assets/icons/seat_flight_attraction.jpg",
                        ),
                        height: 0.05.height,
                      ),
                      Text(
                        provider.user?.displayName ?? "No name",
                        style: theme.titleMedium!.copyWith(
                          color: AppColors.blackColor,
                        ),
                      ),
                      Text(
                        "10000 ${provider.getSelectedDeparture!.trip.currency}",
                        style: theme.titleMedium!.copyWith(
                          color: Colors.green,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ).hPadding(0.03.width),
            0.01.height.hSpace,
            Stack(
              children: [
                Image.asset(
                  AppAssets.flightTicket,
                ),
                Positioned(
                  top: 0.005.height,
                  bottom: 0.00.height,
                  left: 0.0.width,
                  right: 0.28.width,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            provider.selectedDeparture!.trip.flight.flightId
                                        .length >
                                    25
                                ? provider
                                    .selectedDeparture!.trip.flight.flightId
                                    .substring(0, 20)
                                : provider
                                    .selectedDeparture!.trip.flight.flightId,
                            style: theme.labelMedium!.copyWith(
                              color: AppColors.whiteColor,
                            ),
                          ),
                          0.01.height.hSpace,
                          Row(
                            children: [
                              0.2.width.vSpace,
                              Text(
                                "Flight Name: ",
                                style: theme.labelMedium!.copyWith(
                                  color: AppColors.newBlueColor,
                                ),
                              ),
                              Text(
                                provider
                                    .selectedDeparture!.trip.flight.flightName,
                                style: theme.labelMedium!.copyWith(
                                  color: AppColors.blackColor,
                                ),
                              ),
                            ],
                          ),
                          0.007.height.hSpace,
                          Row(
                            children: [
                              0.2.width.vSpace,
                              Text(
                                "From: ",
                                style: theme.labelMedium!.copyWith(
                                  color: AppColors.newBlueColor,
                                ),
                              ),
                              Text(
                                "${provider.selectedDeparture!.from.day}/${provider.selectedDeparture!.from.month}/${provider.selectedDeparture!.from.year}",
                                style: theme.labelMedium!.copyWith(
                                  color: AppColors.blackColor,
                                ),
                              ),
                            ],
                          ),
                          0.007.height.hSpace,
                          Row(
                            children: [
                              0.2.width.vSpace,
                              Text(
                                "To: ",
                                style: theme.labelMedium!.copyWith(
                                  color: AppColors.newBlueColor,
                                ),
                              ),
                              Text(
                                "${provider.selectedDeparture!.to.day}/${provider.selectedDeparture!.to.month}/${provider.selectedDeparture!.to.year}",
                                style: theme.labelMedium!.copyWith(
                                  color: AppColors.blackColor,
                                ),
                              ),
                            ],
                          ),
                          0.003.height.hSpace,
                          Row(
                            children: [
                              0.14.width.vSpace,
                              Text(
                                "Passenger Name: ",
                                style: theme.labelMedium!.copyWith(
                                  color: AppColors.newBlueColor,
                                ),
                              ),
                              Text(
                                provider.user!.displayName ?? "No name",
                                style: theme.labelMedium!.copyWith(
                                  color: AppColors.blackColor,
                                ),
                              ),
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              width: double.maxFinite,
              child: Row(
                children: [
                  Expanded(
                    child: CustomElevatedButton(
                      text: "OK",
                      onPressed: () => slideRightWidget(
                          newPage: CreditCardScreen(
                            route: HotelReservationUser(),
                          ),
                          context: context),
                    ),
                  ),
                  0.02.width.vSpace,
                  Expanded(
                    child: CustomElevatedButton(
                      text: "Cancel",
                      onPressed: () => Navigator.pop(context),
                      btnColor: AppColors.errorColor,
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
