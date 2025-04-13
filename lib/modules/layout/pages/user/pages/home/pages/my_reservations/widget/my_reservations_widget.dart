import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:route_transitions/route_transitions.dart';
import 'package:travel_go/core/extensions/align.dart';
import 'package:travel_go/core/extensions/extensions.dart';
import 'package:travel_go/core/providers/reservation_provider.dart';
import 'package:travel_go/core/utils/reservations_collections.dart';
import 'package:travel_go/core/widget/custom_container.dart';
import 'package:travel_go/core/widget/loading_image_network_widget.dart';
import 'package:travel_go/models/flight.dart';
import 'package:travel_go/models/hotel_model.dart';
import 'package:travel_go/models/reservation_model.dart';
import 'package:travel_go/models/trip_data_model.dart';
import 'package:travel_go/modules/layout/pages/admin/pages/trip_departures/data/model/trip_departure_data_model.dart';
import 'package:travel_go/modules/layout/pages/admin/pages/trip_departures/data/use_case/departures.dart';
import 'package:travel_go/modules/layout/pages/user/pages/home/pages/my_reservations/pages/my_selected_reservation.dart';

import '../../../../../../../../../core/theme/app_colors.dart';
import '../../../../../../../../../core/utils/flight_collections.dart';
import '../../../../../../../../../core/utils/hotels_db.dart';

class MyReservationsWidget extends StatefulWidget {
  final ReservationModel model;

  const MyReservationsWidget({
    super.key,
    required this.model,
  });

  @override
  State<MyReservationsWidget> createState() => _MyReservationsWidgetState();
}

class _MyReservationsWidgetState extends State<MyReservationsWidget> {
  late TripDepartureDataModel? trip;

  late Flight? flight;

  late Hotel? hotel;


  bool isLoading = true;

  Future<void> initData() async {
    if (widget.model.flightId != null) {
      flight = await FlightCollections.getFlightById(
        flightId: widget.model.flightId!,
      );
    }

    if (widget.model.hotelId != null) {
      hotel = await HotelsDB.getHotelById(
        hotelId: widget.model.hotelId!,
      );
    }
    isLoading = false;
    if(widget.model.tripId != null)
      {
        trip = await TripDeparturesCollection.getDepartureUsingId(
          departureId: widget.model.tripId!,
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
    return (isLoading)
        ? CircularProgressIndicator(
            color: AppColors.newBlueColor,
          ).center
        : GestureDetector(
            onTap: () {
              provider.setReservation(widget.model);
              slideLeftWidget(
                newPage: MySelectedReservation(),
                context: context,
              );
            },
            child: CustomContainer(
              padding: EdgeInsets.zero,
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        flex: 5,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Trip",
                              style: Theme.of(context)
                                  .textTheme
                                  .labelSmall!
                                  .copyWith(
                                    color: Colors.grey,
                                  ),
                            ),
                            0.01.height.hSpace,
                            Text(
                              provider.user!.displayName ?? "No Name",
                              style: Theme.of(context).textTheme.labelMedium,
                            ),
                            0.01.height.hSpace,
                            Text(
                              "${trip?.from.day} / ${trip?.from.month} / ${trip?.from.year}",
                              style: Theme.of(context).textTheme.labelMedium,
                            ),
                            0.01.height.hSpace,
                            Text(
                              "${trip?.to.day} / ${trip?.to.month} / ${trip?.to.year}",
                              style: Theme.of(context).textTheme.labelMedium,
                            ),
                            0.01.height.hSpace,
                            Text(
                              "${trip?.trip.price} ${trip?.trip.currency}",
                              style: Theme.of(context).textTheme.labelMedium,
                            ),
                          ],
                        ).allPadding(15),
                      ),
                      Expanded(
                        flex: 4,
                        child: ClipRRect(
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(8.0),
                            bottomRight: Radius.circular(8.0),
                          ),
                          child: LoadingImageNetworkWidget(
                            height: 0.19.height,
                            imageUrl: trip?.trip.imageUrl ??
                                "https://via.placeholder.com/150",
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
  }
}
