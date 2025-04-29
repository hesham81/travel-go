import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../../../../../../core/providers/reservation_provider.dart';
import '../../../../../../../../../models/trip_data_model.dart';
import '../../../../../../admin/menna/trippp/utils/trips_collections.dart';
import '/core/extensions/extensions.dart';
import '/core/widget/labels_widget.dart';
import '/core/widget/loading_image_network_widget.dart';
import '/modules/layout/pages/admin/pages/trip_departures/data/model/trip_departure_data_model.dart';

class MyTripReservations extends StatefulWidget {
  final TripDepartureDataModel trip;

  const MyTripReservations({
    super.key,
    required this.trip,
  });

  @override
  State<MyTripReservations> createState() => _MyTripReservationsState();
}

class _MyTripReservationsState extends State<MyTripReservations> {
  TripDataModel? tripData;

  Future<void> _getCurrentTrip() async {
    TripDepartureDataModel tripDepartureDataModel =
        Provider.of<ReservationProvider>(context, listen: false)
            .getSelectedDeparture!;
    tripData = await TripCollections.getTrip(tripDepartureDataModel.tripId);
    setState(() {});
  }

  @override
  void initState() {
    Future.wait([
      _getCurrentTrip(),
    ]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          LoadingImageNetworkWidget(
            imageUrl: tripData!.imageUrl!,
          ),
          0.01.height.hSpace,
          Column(
            children: [
              LabelsWidget(
                label: "Source : ",
                value: tripData!.source,
              ),
              0.01.height.hSpace,
              LabelsWidget(
                label: "Destination : ",
                value: tripData!.destination,
              ),
              0.01.height.hSpace,
              LabelsWidget(
                label: "From : ",
                value:
                    "${widget.trip!.from.day}/${widget.trip!.from.month}/${widget.trip!.from.year} ",
              ),
              0.01.height.hSpace,
              LabelsWidget(
                label: "To : ",
                value:
                    "${widget.trip!.to.day}/${widget.trip!.to.month}/${widget.trip!.to.year} ",
              ),
              0.01.height.hSpace,
              LabelsWidget(
                label: "Price : ",
                value: "${tripData!.price} ${tripData!.currency}",
              ),
              0.01.height.hSpace,
              LabelsWidget(
                label: "Total Days : ",
                value: "${tripData!.totalDays} Days",
              ),
              0.01.height.hSpace,
              LabelsWidget(
                label: "Organized By : ",
                value: tripData!.organizedBy.companyName,
              ),
              0.01.height.hSpace,
              LabelsWidget(
                label: "Phone Number : ",
                value: tripData!.organizedBy.phoneNumber,
              ),
              0.01.height.hSpace,
              LabelsWidget(
                label: "Website : ",
                value: tripData!.organizedBy.companyWebsite,
              ),
            ],
          ).hPadding(0.03.width)
        ],
      ),
    );
  }
}
