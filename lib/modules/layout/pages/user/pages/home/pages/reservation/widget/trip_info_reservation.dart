import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel_go/core/extensions/align.dart';
import 'package:travel_go/core/extensions/extensions.dart';
import 'package:travel_go/core/providers/reservation_provider.dart';
import 'package:travel_go/core/theme/app_colors.dart';
import 'package:travel_go/core/widget/labels_widget.dart';

import '../../../../../../../../../core/utils/flight_collections.dart';
import '../../../../../../../../../core/utils/hotels_db.dart';
import '../../../../../../../../../models/flight.dart';
import '../../../../../../../../../models/hotel_model.dart';

class TripInfoReservation extends StatefulWidget {
  const TripInfoReservation({super.key});

  @override
  State<TripInfoReservation> createState() => _TripInfoReservationState();
}

class _TripInfoReservationState extends State<TripInfoReservation> {
  late Hotel hotel;

  late Flight flight;

  bool isLoading = true;

  Future<void> initData() async {
    var provider = Provider.of<ReservationProvider>(context, listen: false);
    hotel = await HotelsDB.getHotelById(
      hotelId: provider.getSelectedDeparture!.trip.hotelId,
    );

    flight = (await FlightCollections.getFlightById(
      flightId: provider.getSelectedDeparture!.trip.flightId,
    ))!;

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
    var provider = Provider.of<ReservationProvider>(context);
    return (isLoading)
        ? CircularProgressIndicator(color: AppColors.newBlueColor).center
        : Container(
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
                  label: "Trip Id : ",
                  value: provider.getSelectedDeparture!.trip.tripId,
                ),
                0.01.height.hSpace,
                LabelsWidget(
                  label: "Trip : ",
                  value: provider.getSelectedDeparture!.trip.tripName,
                ),
                0.01.height.hSpace,
                LabelsWidget(
                  label: "From : ",
                  value:
                      "${provider.getSelectedDeparture!.from.day}/${provider.getSelectedDeparture!.from.month}/${provider.getSelectedDeparture!.from.year} ",
                ),
                0.01.height.hSpace,
                LabelsWidget(
                  label: "To : ",
                  value:
                      "${provider.getSelectedDeparture!.to.day}/${provider.getSelectedDeparture!.to.month}/${provider.getSelectedDeparture!.to.year} ",
                ),
                0.01.height.hSpace,
                LabelsWidget(
                  label: "Flight : ",
                  value: flight.flightId,
                ),
                0.01.height.hSpace,
                LabelsWidget(
                  label: "Hotel : ",
                  value: hotel.hotelName,
                ),
                0.01.height.hSpace,
                LabelsWidget(
                  label: "Total Days : ",
                  value:
                      "${provider.getSelectedDeparture!.trip.totalDays.toString()} Days",
                ),
                0.01.height.hSpace,
                LabelsWidget(
                  label: "Total Trip Price : ",
                  value:
                      "${(provider.getTotalUsers == 0 || provider.getTotalUsers == -1) ? provider.getSelectedDeparture!.trip.price : provider.getTotalUsers * provider.getSelectedDeparture!.trip.price} ${provider.getSelectedDeparture!.trip.currency}",
                ),
              ],
            ),
          );
  }
}
