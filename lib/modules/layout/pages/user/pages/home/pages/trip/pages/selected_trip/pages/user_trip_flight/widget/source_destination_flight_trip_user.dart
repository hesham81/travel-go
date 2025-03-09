import 'package:flutter/material.dart';
import '/core/constant/app_assets.dart';
import '/core/extensions/extensions.dart';
import '/models/trip_data_model.dart';

class SourceDestinationFlightTripUser extends StatelessWidget {
  final TripDataModel model;

  const SourceDestinationFlightTripUser({
    super.key,
    required this.model,
  });

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).textTheme;
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
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
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Text(
                model.source.substring(0,3).toUpperCase(),
                style: theme.titleMedium!.copyWith(
                  fontWeight: FontWeight.w800,
                  fontSize: 27,
                ),
              ),
              Text(
                model.source,
                style: theme.titleSmall!.copyWith(
                  fontSize: 13
                ),
              ),
              
            ],
          ),
          Image.asset(
            AppAssets.sourceDestinationFlightTripUser,
            height: 0.15.height,
          ),
          Column(
            children: [
              Text(
                model.destination.substring(0,3).toUpperCase(),
                style: theme.titleMedium!.copyWith(
                  fontWeight: FontWeight.w800,
                  fontSize: 27,
                ),
              ),
              Text(
                model.destination,
                style: theme.titleSmall!.copyWith(
                    fontSize: 13
                ),
              ),

            ],
          ),
        ],
      ).hPadding(0.02.width),
    ).hPadding(0.03.width);
  }
}
