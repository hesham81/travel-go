import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:travel_go/core/extensions/dimensions.dart';
import 'package:travel_go/core/extensions/extensions.dart';
import 'package:travel_go/core/theme/app_colors.dart';
import 'package:travel_go/core/widget/custom_container.dart';
import 'package:travel_go/core/widget/loading_image_network_widget.dart';
import 'package:travel_go/models/flight_departures.dart';

import '../../../../../../../../../../../../models/flight.dart';

class TicketFlightGenerator extends StatelessWidget {
  final FlightDeparture departure;
  final Flight flight;

  const TicketFlightGenerator({
    super.key,
    required this.departure,
    required this.flight,
  });

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Image.network(
                flight.airline.flightAirLineImageUrl,
                height: 50,
                width: 80,
              ),
              Spacer(),
              Text(
                flight.airline.flighAirLineName,
                style: Theme.of(context).textTheme.labelLarge,
              )
            ],
          ),
          0.01.height.hSpace,
          Divider(),
          0.01.height.hSpace,
          Row(
            children: [
              Column(
                children: [
                  Text(
                    departure.depAirport.substring(0, 3),
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                  0.01.height.hSpace,
                  Text(
                    "${departure.depTime.hour}:${departure.depTime.minute}",
                    style: Theme.of(context).textTheme.labelMedium,
                  )
                ],
              ),
              Expanded(
                child: Image.asset(
                  "assets/images/flight_divider.png",
                ),
              ),
              Column(
                children: [
                  Text(
                    departure.arrAirport.substring(0, 3),
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                  0.01.height.hSpace,
                  Text(
                    "${departure.arrTime.hour}:${departure.arrTime.minute}",
                    style: Theme.of(context).textTheme.labelMedium,
                  )
                ],
              ),
            ],
          ),
          0.01.height.hSpace,
          Row(
            children: [
              Icon(
                Icons.info,
                color: AppColors.greyColor,
              ),
              0.01.width.vSpace,
              Text(
                "Flight Info",
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                      color: AppColors.greyColor,
                    ),
              ),
              Spacer(),
              Text(
                "${flight.seats.first.price.toString()}\$",
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                  color: Colors.green
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
