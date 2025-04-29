import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:route_transitions/route_transitions.dart';
import 'package:travel_go/core/extensions/align.dart';
import 'package:travel_go/core/extensions/dimensions.dart';
import 'package:travel_go/core/extensions/extensions.dart';
import 'package:travel_go/core/providers/reservation_provider.dart';
import 'package:travel_go/core/theme/app_colors.dart';
import 'package:travel_go/core/utils/check_tour_guide.dart';
import 'package:travel_go/core/widget/custom_container.dart';
import 'package:travel_go/core/widget/custom_elevated_button.dart';
import 'package:travel_go/core/widget/dividers_word.dart';
import 'package:travel_go/core/widget/loading_image_network_widget.dart';
import 'package:travel_go/models/tour_guide_data_model.dart';
import 'package:travel_go/modules/layout/pages/user/pages/home/pages/my_reservations/pages/track_locations.dart';
import 'package:travel_go/modules/layout/pages/user/pages/home/pages/my_reservations/widget/my_flight_reservation.dart';
import 'package:travel_go/modules/layout/pages/user/pages/home/pages/my_reservations/widget/my_hotel_reservation.dart';
import 'package:travel_go/modules/layout/pages/user/pages/home/pages/my_reservations/widget/my_trip_reservations.dart';

import '../../../../../../../../../core/utils/flight_collections.dart';
import '../../../../../../../../../core/utils/hotels_db.dart';
import '../../../../../../../../../models/flight.dart';
import '../../../../../../../../../models/hotel_model.dart';
import '../../../../../../admin/pages/trip_departures/data/model/trip_departure_data_model.dart';
import '../../../../../../admin/pages/trip_departures/data/use_case/departures.dart';

class MySelectedReservation extends StatefulWidget {
  const MySelectedReservation({super.key});

  @override
  State<MySelectedReservation> createState() => _MySelectedReservationState();
}

class _MySelectedReservationState extends State<MySelectedReservation> {
  TripDepartureDataModel? trip;

  Flight? flight;

  Hotel? hotel;

  bool isLoading = true;

  bool tripStarted = false;

  TourGuideDataModel? tourGuide;

  Future<void> initData() async {
    var provider = Provider.of<ReservationProvider>(context, listen: false);
    if (provider.reservation!.flightId != null) {
      flight = await FlightCollections.getFlightById(
        flightId: provider.reservation!.flightId!,
      );
    }
    tripStarted = (provider.getSelectedDeparture == null)
        ? await TourGuideServices.checkIfTourGuideExists(
            provider.getSelectedDeparture?.id ??
                "Departure-Italy-2025:4:16-2025:4:18")
        : false;

    if (provider.reservation!.hotelId != null) {
      hotel = await HotelsDB.getHotelById(
        hotelId: provider.reservation!.hotelId!,
      );
    }
    isLoading = false;
    if (provider.reservation!.tripId != null) {
      trip = await TripDeparturesCollection.getDepartureUsingId(
        departureId: provider.reservation!.tripId!,
      );
    }
    setState(() {});
  }

  @override
  void initState() {
    Future.wait([initData()]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<ReservationProvider>(context);
    return Scaffold(
      bottomNavigationBar: CustomContainer(
        child: CustomElevatedButton(
          text: "Track Locations",
          onPressed: (tripStarted)
              ? () {
                  slideLeftWidget(
                    newPage: TrackLocations(),
                    context: context,
                  );
                }
              : null,
        ),
      ),
      appBar: AppBar(
        title: Text(
          "Reservations Details",
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: AppColors.whiteColor,
              ),
        ),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            Icons.arrow_back_ios,
            color: AppColors.whiteColor,
          ),
        ),
      ),
      body: (isLoading)
          ? CircularProgressIndicator(
              color: AppColors.newBlueColor,
            ).center
          : SingleChildScrollView(
              child: Column(
                children: [
                  (trip != null)
                      ? MyTripReservations(trip: trip!)
                      : Container(),
                  0.01.height.hSpace,
                  (flight != null) ? DividersWord(text: "Flight") : Container(),
                  0.01.height.hSpace,
                  (flight != null)
                      ? MyFlightReservation(flight: flight!)
                      : Container(),
                  0.01.height.hSpace,
                  (hotel != null) ? DividersWord(text: "Hotel") : Container(),
                  (hotel != null)
                      ? MyHotelReservation(hotel: hotel!)
                      : Container(),
                ],
              ),
            ),
    );
  }
}
