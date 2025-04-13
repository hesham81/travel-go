import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:travel_go/core/extensions/extensions.dart';
import 'package:travel_go/core/services/bot_toast.dart';
import 'package:travel_go/core/utils/flight_collections.dart';
import 'package:travel_go/core/utils/hotels_db.dart';
import 'package:travel_go/core/utils/reservations_collections.dart';
import 'package:travel_go/core/widget/custom_container.dart';
import 'package:travel_go/core/widget/custom_elevated_button.dart';
import 'package:travel_go/core/widget/dividers_word.dart';
import 'package:travel_go/models/flight.dart';
import 'package:travel_go/models/hotel_model.dart';
import 'package:travel_go/models/reservation_model.dart';
import 'package:travel_go/modules/layout/pages/admin/pages/trip_departures/data/model/trip_departure_data_model.dart';
import 'package:travel_go/modules/layout/pages/user/pages/home/pages/home.dart';

import '../../../../../../../../../../../core/providers/reservation_provider.dart';
import '../../../../../../../../../../../core/theme/app_colors.dart';
import '../../../../../../../../../../../core/utils/id_generator.dart';

class ConfirmUserReservations extends StatefulWidget {
  const ConfirmUserReservations({super.key});

  @override
  State<ConfirmUserReservations> createState() =>
      _ConfirmUserReservationsState();
}

class _ConfirmUserReservationsState extends State<ConfirmUserReservations> {
  late Hotel hotel;

  late Flight flight;

  late TripDepartureDataModel trip;

  bool isLoading = true;

  Future<void> initData() async {
    var provider = Provider.of<ReservationProvider>(context, listen: false);
    hotel = await HotelsDB.getHotelById(
      hotelId: provider.getSelectedDeparture!.trip.hotelId,
    );

    flight = (await FlightCollections.getFlightById(
      flightId: provider.getSelectedDeparture!.trip.flightId,
    ))!;

    trip = provider.getSelectedDeparture!;

    isLoading = false;
    setState(() {});
  }

  @override
  void initState() {
    Future.wait([
      initData(),
    ]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).textTheme;
    var provider = Provider.of<ReservationProvider>(context);
    return Scaffold(
      body: (isLoading)
          ? CircularProgressIndicator(color: AppColors.newBlueColor)
          : SingleChildScrollView(
              child: SafeArea(
                child: Column(
                  children: [
                    CustomContainer(
                      width: double.maxFinite,
                      child: Column(
                        children: [
                          DividersWord(
                            text: "Trip",
                          ),
                          0.01.height.hSpace,
                          Row(
                            children: [
                              Text(
                                "Trip Name: ",
                                style: theme.titleMedium!.copyWith(
                                  color: AppColors.newBlueColor,
                                ),
                              ),
                              Text(
                                provider.getSelectedDeparture!.trip.tripName,
                                style: theme.titleMedium!.copyWith(
                                  color: AppColors.blackColor,
                                ),
                              ),
                            ],
                          ),
                          0.01.height.hSpace,
                          Row(
                            children: [
                              Text(
                                "Source: ",
                                style: theme.titleMedium!.copyWith(
                                  color: AppColors.newBlueColor,
                                ),
                              ),
                              Text(
                                provider.getSelectedDeparture!.trip.source,
                                style: theme.titleMedium!.copyWith(),
                              ),
                            ],
                          ),
                          0.01.height.hSpace,
                          Row(
                            children: [
                              Text(
                                "Destination: ",
                                style: theme.titleMedium!.copyWith(
                                  color: AppColors.newBlueColor,
                                ),
                              ),
                              Text(
                                provider.getSelectedDeparture!.trip.destination,
                                style: theme.titleMedium!.copyWith(),
                              ),
                            ],
                          ),
                          0.01.height.hSpace,
                          Row(
                            children: [
                              Text(
                                "Total Days: ",
                                style: theme.titleMedium!.copyWith(
                                  color: AppColors.newBlueColor,
                                ),
                              ),
                              Text(
                                "${provider.getSelectedDeparture!.trip.totalDays} Days",
                                style: theme.titleMedium!.copyWith(),
                              ),
                            ],
                          ),
                          0.01.height.hSpace,
                          Row(
                            children: [
                              Text(
                                "Organized By: ",
                                style: theme.titleMedium!.copyWith(
                                  color: AppColors.newBlueColor,
                                ),
                              ),
                              Text(
                                provider.getSelectedDeparture!.trip.organizedBy
                                    .companyName,
                                style: theme.titleMedium!.copyWith(),
                              ),
                            ],
                          ),
                          0.01.height.hSpace,
                          Row(
                            children: [
                              Text(
                                "From: ",
                                style: theme.titleMedium!.copyWith(
                                  color: AppColors.newBlueColor,
                                ),
                              ),
                              Text(
                                "${provider.getSelectedDeparture!.from.day}/${provider.getSelectedDeparture!.from.month}/${provider.getSelectedDeparture!.from.year}",
                                style: theme.titleMedium!.copyWith(),
                              ),
                            ],
                          ),
                          0.01.height.hSpace,
                          Row(
                            children: [
                              Text(
                                "To: ",
                                style: theme.titleMedium!.copyWith(
                                  color: AppColors.newBlueColor,
                                ),
                              ),
                              Text(
                                "${provider.getSelectedDeparture!.to.day}/${provider.getSelectedDeparture!.to.month}/${provider.getSelectedDeparture!.to.year}",
                                style: theme.titleMedium!.copyWith(),
                              ),
                            ],
                          ),
                          0.01.height.hSpace,
                          Row(
                            children: [
                              Text(
                                "Total Guests: ",
                                style: theme.titleMedium!.copyWith(
                                  color: AppColors.newBlueColor,
                                ),
                              ),
                              Text(
                                "${provider.totalUsers + 1}",
                                style: theme.titleMedium!.copyWith(),
                              ),
                            ],
                          ),
                          0.01.height.hSpace,
                          Row(
                            children: [
                              Text(
                                "Total Price: ",
                                style: theme.titleMedium!.copyWith(
                                  color: AppColors.newBlueColor,
                                ),
                              ),
                              Text(
                                "${provider.getSelectedDeparture!.trip.price * (provider.totalUsers + 1)} ${provider.getSelectedDeparture!.trip.currency}",
                                style: theme.titleMedium!.copyWith(),
                              ),
                            ],
                          ),
                          0.01.height.hSpace,
                          DividersWord(text: "Flight"),
                          Row(
                            children: [
                              Text(
                                "Flight Id: ",
                                style: theme.titleMedium!.copyWith(
                                  color: AppColors.newBlueColor,
                                ),
                              ),
                              Text(
                                flight.flightId,
                                style: theme.titleSmall!.copyWith(),
                              ),
                            ],
                          ),
                          0.01.height.hSpace,
                          Row(
                            children: [
                              Text(
                                "Flight Name: ",
                                style: theme.titleMedium!.copyWith(
                                  color: AppColors.newBlueColor,
                                ),
                              ),
                              Text(
                                flight.flightName,
                                style: theme.titleSmall!.copyWith(),
                              ),
                            ],
                          ),
                          0.01.height.hSpace,
                          Row(
                            children: [
                              Text(
                                "Flight Name: ",
                                style: theme.titleMedium!.copyWith(
                                  color: AppColors.newBlueColor,
                                ),
                              ),
                              Text(
                                flight.airline!.flighAirLineName,
                                style: theme.titleSmall!.copyWith(),
                              ),
                            ],
                          ),
                          0.01.height.hSpace,
                          DividersWord(
                            text: "Hotel",
                          ),
                          0.01.height.hSpace,
                          Row(
                            children: [
                              Text(
                                "Hotel Name: ",
                                style: theme.titleMedium!.copyWith(
                                  color: AppColors.newBlueColor,
                                ),
                              ),
                              Text(
                                hotel.hotelName,
                                style: theme.titleMedium!.copyWith(),
                              ),
                            ],
                          ),
                          0.01.height.hSpace,
                          Row(
                            children: [
                              Text(
                                "Location: ",
                                style: theme.titleMedium!.copyWith(
                                  color: AppColors.newBlueColor,
                                ),
                              ),
                              Text(
                                hotel.hotelLocation,
                                style: theme.titleMedium!.copyWith(),
                              ),
                            ],
                          ),
                          0.03.height.hSpace,
                          Row(
                            children: [
                              Expanded(
                                child: CustomElevatedButton(
                                  borderRadius: 10,
                                  text: "Confirm",
                                  onPressed: () async {
                                    EasyLoading.show();
                                    await ReservationCollections.addReservation(
                                      ReservationModel(
                                        uid: provider.user!.uid,
                                        id: IdGenerator.generateReservationId(
                                          name: trip.trip.tripName,
                                          date: trip.from,
                                          type: "Trip",
                                          uid: FirebaseAuth
                                              .instance.currentUser!.uid,
                                        ),
                                        totalGuests: provider.totalUsers + 1 ,
                                        tripId:
                                            provider.getSelectedDeparture!.id,
                                        hotelId: (provider.getReserveHotel)
                                            ? hotel.id
                                            : null,
                                        flightId: (provider.getReserveFlight)
                                            ? flight.flightId
                                            : null,
                                      ),
                                    );
                                    EasyLoading.dismiss();
                                    BotToastServices.showSuccessMessage(
                                      "Reservation Confirmed",
                                    );
                                    Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => Home(),
                                      ),
                                      (route) => false,
                                    );
                                  },
                                ),
                              ),
                              0.01.width.vSpace,
                              Expanded(
                                child: CustomElevatedButton(
                                  borderRadius: 10,
                                  btnColor: Colors.red,
                                  text: "Cancel",
                                  onPressed: () => Navigator.pop(context),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ).hPadding(0.02.width),
                  ],
                ),
              ),
            ),
    );
  }
}
