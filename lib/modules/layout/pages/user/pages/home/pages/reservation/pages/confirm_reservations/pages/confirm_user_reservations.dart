import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:travel_go/core/extensions/align.dart';
import 'package:travel_go/core/extensions/extensions.dart';
import 'package:travel_go/core/services/bot_toast.dart';
import 'package:travel_go/core/utils/flight_collections.dart';
import 'package:travel_go/core/utils/flight_departures_collections.dart';
import 'package:travel_go/core/utils/hotels_db.dart';
import 'package:travel_go/core/utils/reservations_collections.dart';
import 'package:travel_go/core/widget/custom_container.dart';
import 'package:travel_go/core/widget/custom_elevated_button.dart';
import 'package:travel_go/core/widget/dividers_word.dart';
import 'package:travel_go/models/flight.dart';
import 'package:travel_go/models/hotel_model.dart';
import 'package:travel_go/models/reservation_model.dart';
import 'package:travel_go/modules/layout/pages/admin/pages/trip_departures/data/model/trip_departure_data_model.dart';
import 'package:travel_go/modules/layout/pages/admin/pages/trip_departures/data/use_case/departures.dart';
import 'package:travel_go/modules/layout/pages/user/pages/home/pages/home.dart';

import '../../../../../../../../../../../core/providers/reservation_provider.dart';
import '../../../../../../../../../../../core/theme/app_colors.dart';
import '../../../../../../../../../../../core/utils/id_generator.dart';
import '../../../../../../../../../../../models/trip_data_model.dart';
import '../../../../../../../../admin/menna/trippp/utils/trips_collections.dart';

class ConfirmUserReservations extends StatefulWidget {
  const ConfirmUserReservations({super.key});

  @override
  State<ConfirmUserReservations> createState() =>
      _ConfirmUserReservationsState();
}

class _ConfirmUserReservationsState extends State<ConfirmUserReservations> {
  late Hotel hotel;

  late Flight flight;
  TripDataModel? trip;

  late TripDepartureDataModel tripDeparture;

  bool isLoading = true;

  Future<void> initData() async {
    TripDepartureDataModel tripDepartureDataModel =
        Provider.of<ReservationProvider>(context, listen: false)
            .getSelectedDeparture!;
    trip = await TripCollections.getTrip(tripDepartureDataModel.tripId);
    var provider = Provider.of<ReservationProvider>(context, listen: false);
    hotel = await HotelsDB.getHotelById(
      hotelId: trip!.hotelId,
    );

    flight = (await FlightCollections.getFlightById(
      flightId: trip!.flightId,
    ))!;

    tripDeparture = provider.getSelectedDeparture!;

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
          ? CircularProgressIndicator(
              color: AppColors.newBlueColor,
            ).center
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
                                trip!.tripName,
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
                                trip!.source,
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
                                trip!.destination,
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
                                "${trip!.totalDays} Days",
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
                                trip!.organizedBy.companyName,
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
                                "${tripDeparture.from.day}/${tripDeparture.from.month}/${tripDeparture.from.year}",
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
                                "${trip!.price * (provider.totalUsers + 1)} ${trip!.currency}",
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
                                        uid: FirebaseAuth
                                            .instance.currentUser!.uid,
                                        id: IdGenerator.generateReservationId(
                                          name: trip!.tripName,
                                          date: tripDeparture.from,
                                          type: "Trip",
                                          uid: FirebaseAuth
                                              .instance.currentUser!.uid,
                                        ),
                                        totalGuests: provider.totalUsers + 1,
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
                                    var departure =
                                        provider.getSelectedDeparture;
                                    departure!.availableSeats -=
                                        provider.totalUsers + 1;
                                    await TripDeparturesCollection.addDeparture(
                                        departure);
                                    if (provider.getReserveFlight) {
                                      var flightDeparture =
                                          provider.getFlightDeparture;
                                      flightDeparture!.availableSeats -=
                                          provider.totalUsers + 1;
                                      await FlightDeparturesCollections
                                          .updateDeparture(flightDeparture);
                                    }
                                    if (provider.getReserveHotel) {
                                      var hotel = provider.getHotel;
                                      hotel!.availableRooms -=
                                          provider.totalUsers + 1;
                                      var acc = hotel.accomdations.firstWhere(
                                        (element) =>
                                            element ==
                                            provider.getAccomdationsDataModel,
                                      );
                                      acc.roomAvailable -=
                                          provider.totalUsers + 1;
                                      int index = hotel.accomdations.indexOf(
                                          provider.getAccomdationsDataModel!);
                                      hotel.accomdations[index] = acc;
                                      await HotelsDB.updateHotel(hotel);
                                    }

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
