import 'package:flutter/material.dart';
import 'package:route_transitions/route_transitions.dart';
import '/core/extensions/extensions.dart';
import '/core/widget/custom_elevated_button.dart';
import '/core/widget/labels_widget.dart';
import '/core/widget/loading_image_network_widget.dart';
import '/models/flight.dart';
import '/models/trip_data_model.dart';
import '/modules/layout/pages/user/pages/home/pages/trip/pages/selected_trip/pages/user_trip_flight/pages/about_flight.dart';

class UserTripFlight extends StatelessWidget {
  final Flight model;
  final TripDataModel trip;

  const UserTripFlight({
    super.key,
    required this.model,
    required this.trip,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        0.01.height.hSpace,
        SizedBox(
          width: double.maxFinite,
          child: LoadingImageNetworkWidget(
            imageUrl: model.airline!.flightAirLineImageUrl,
          ),
        ),
        0.01.height.hSpace,
        LabelsWidget(
          label: "Airline : ",
          value: model.airline!.flighAirLineName,
        ),
        0.01.height.hSpace,
        LabelsWidget(
          label: "Flight Name : ",
          value: model.flightName,
        ),
        0.05.height.hSpace,
        CustomElevatedButton(
          text: "More About Flight ",
          onPressed: () {
            slideRightWidget(
              newPage: AboutFlight(
                model: model,
                trip: trip,
              ),
              context: context,
            );
          },
        ),
        0.02.height.hSpace,
      ],
    );
  }
}
