import 'package:flutter/material.dart';
import 'package:travel_go/core/widget/labels_widget.dart';
import 'package:travel_go/core/widget/loading_image_network_widget.dart';
import 'package:travel_go/models/trip_data_model.dart';
import 'package:travel_go/modules/layout/pages/user/pages/home/pages/trip/pages/selected_trip/pages/user_trip_flight/widget/source_destination_flight_trip_user.dart';
import '/core/extensions/extensions.dart';
import '/core/theme/app_colors.dart';
import '/models/flight.dart';

class AboutFlight extends StatelessWidget {
  final Flight model;
  final TripDataModel trip;

  const AboutFlight({
    super.key,
    required this.model,
    required this.trip,
  });

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).textTheme;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 0.25.height,
              width: double.maxFinite,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                    "https://i.pinimg.com/474x/ac/01/c2/ac01c256589eb1a052a73bd481bf32d9.jpg",
                  ),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(25),
                  bottomRight: Radius.circular(25),
                ),
                color: AppColors.newBlueColor,
              ),
              child: Row(
                children: [
                  BackButton(
                    color: AppColors.whiteColor,
                  ),
                ],
              ),
            ),
            0.03.height.hSpace,
            SourceDestinationFlightTripUser(
              model: trip,
            ),
            0.02.height.hSpace,
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Text(
                    model.airline!.flighAirLineName,
                    style: theme.titleMedium!.copyWith(),
                  ),
                  0.01.width.vSpace,
                  Expanded(
                    child: LoadingImageNetworkWidget(
                      imageUrl: model.airline!.flightAirLineImageUrl,
                    ),
                  ),
                ],
              ).hPadding(0.03.width),
            ).hPadding(0.03.width),
            0.02.height.hSpace,
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                children: [
                  LabelsWidget(
                    label: "",
                    value: model.flightId,
                  ).allPadding(10),
                  LabelsWidget(
                    label: "Flight Name : ",
                    value: model.flightName,
                  ),
                  0.03.height.hSpace,
                  LabelsWidget(
                    label: "Allowed Bag Weight : ",
                    value: "15 KG",
                  ),
                  0.03.height.hSpace,
                  LabelsWidget(
                    label: "Standard Economy Seats : ",
                    value: (trip.currency == "EGP")
                        ? "8000 ${trip.currency}"
                        : "15 ${trip.currency}",
                  ),
                  0.03.height.hSpace,
                  LabelsWidget(
                    label: "Premium Economy Seats : ",
                    value: (trip.currency == "EGP")
                        ? "18000 ${trip.currency}"
                        : "65 ${trip.currency}",
                  ),
                  0.03.height.hSpace,
                  LabelsWidget(
                    label: "Exit Row Seat : ",
                    value: (trip.currency == "EGP")
                        ? "14000 ${trip.currency}"
                        : "55 ${trip.currency}",
                  ),
                  0.03.height.hSpace,
                  LabelsWidget(
                    label: "Bulkhead Seat : ",
                    value: (trip.currency == "EGP")
                        ? "11000 ${trip.currency}"
                        : "60 ${trip.currency}",
                  ),
                  0.03.height.hSpace,
                  LabelsWidget(
                    label: "Standard Middle Seat : ",
                    value: (trip.currency == "EGP")
                        ? "18000 ${trip.currency}"
                        : "90 ${trip.currency}",
                  ),
                  LoadingImageNetworkWidget(
                    imageUrl:
                        "https://i.pinimg.com/736x/87/d2/fa/87d2fa372a26b188ae2d2801feefcc30.jpg",
                    height: 0.15.height,
                  ),
                ],
              ).allPadding(5),
            ).hPadding(0.03.width),
            0.02.height.hSpace,
          ],
        ),
      ),
    );
  }
}
