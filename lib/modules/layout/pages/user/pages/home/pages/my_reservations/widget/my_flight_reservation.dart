import 'package:flutter/material.dart';
import 'package:travel_go/core/extensions/dimensions.dart';
import 'package:travel_go/core/extensions/extensions.dart';
import 'package:travel_go/core/theme/app_colors.dart';
import 'package:travel_go/core/widget/custom_container.dart';
import 'package:travel_go/core/widget/labels_widget.dart';
import 'package:travel_go/core/widget/loading_image_network_widget.dart';

import '../../../../../../../../../models/flight.dart';

class MyFlightReservation extends StatelessWidget {
  final Flight flight;

  const MyFlightReservation({
    super.key,
    required this.flight,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        LoadingImageNetworkWidget(
          imageUrl: flight.airline!.flightAirLineImageUrl,
        ),
        Column(
          children: [
            LabelsWidget(
              label: "Flight Air Line : ",
              value: flight.airline!.flighAirLineName,
            ),
            0.01.height.hSpace,
            LabelsWidget(
              label: "Flight Id : ",
              value: flight.flightId,
            ),
            0.01.height.hSpace,
            LabelsWidget(
              label: "From : ",
              value: flight.flightName,
            ),
          ],
        ).hPadding(0.03.width)
      ],
    );
  }
}
