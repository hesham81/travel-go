import 'package:flutter/material.dart';
import '/core/extensions/extensions.dart';
import '/core/widget/labels_widget.dart';
import '/core/widget/loading_image_network_widget.dart';
import '/modules/layout/pages/admin/pages/trip_departures/data/model/trip_departure_data_model.dart';

class MyTripReservations extends StatelessWidget {
  final TripDepartureDataModel trip;

  const MyTripReservations({
    super.key,
    required this.trip,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          LoadingImageNetworkWidget(
            imageUrl: trip.trip.imageUrl!,
          ),
          0.01.height.hSpace,
          Column(
            children: [
              LabelsWidget(
                label: "Source : ",
                value: trip.trip.source,
              ),
              0.01.height.hSpace,
              LabelsWidget(
                label: "Destination : ",
                value: trip.trip.destination,
              ),
              0.01.height.hSpace,
              LabelsWidget(
                label: "From : ",
                value: "${trip.from.day}/${trip.from.month}/${trip.from.year} ",
              ),
              0.01.height.hSpace,
              LabelsWidget(
                label: "To : ",
                value: "${trip.to.day}/${trip.to.month}/${trip.to.year} ",
              ),
              0.01.height.hSpace,
              LabelsWidget(
                label: "Price : ",
                value: "${trip.trip.price} ${trip.trip.currency}",
              ),
              0.01.height.hSpace,
              LabelsWidget(
                label: "Total Days : ",
                value: "${trip.trip.totalDays} Days",
              ),
              0.01.height.hSpace,
              LabelsWidget(
                label: "Organized By : ",
                value: trip.trip.organizedBy.companyName,
              ),
              0.01.height.hSpace,
              LabelsWidget(
                label: "Phone Number : ",
                value: trip.trip.organizedBy.phoneNumber,
              ),
              0.01.height.hSpace,
              LabelsWidget(
                label: "Website : ",
                value: trip.trip.organizedBy.companyWebsite,
              ),
            ],
          ).hPadding(0.03.width)
        ],
      ),
    );
  }
}
