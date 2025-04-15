import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:route_transitions/route_transitions.dart';
import '/core/extensions/extensions.dart';
import '/core/theme/app_colors.dart';
import '/core/widget/custom_elevated_button.dart';
import '/models/trip_data_model.dart';
import '/modules/layout/pages/admin/pages/attractions/pages/update_attractions/widget/set_map_location.dart';
import '/modules/layout/pages/user/pages/home/pages/trip_departure/pages/trip_departure.dart';

class UtilitiesTrip extends StatefulWidget {
  final TripDataModel model;
  final int totalPlaces;

  const UtilitiesTrip({
    super.key,
    required this.model,
    required this.totalPlaces,
  });

  @override
  State<UtilitiesTrip> createState() => _UtilitiesTripState();
}

class _UtilitiesTripState extends State<UtilitiesTrip> {
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        0.01.height.hSpace,
        Divider(),
        0.01.height.hSpace,
        Container(
          height: 0.07.height, // Set a fixed height
          child: Row(
            children: [
              Column(
                children: [
                  Icon(Icons.flight),
                  0.01.height.hSpace,
                  Text(
                    "4 Hours",
                    style: theme.labelLarge!.copyWith(
                      color: AppColors.blackColor,
                    ),
                  ),
                ],
              ),
              0.01.width.vSpace,
              Expanded(
                child: VerticalDivider(),
              ),
              0.01.width.vSpace,
              Column(
                children: [
                  Icon(Icons.account_balance_outlined),
                  0.01.height.hSpace,
                  Text(
                    "${widget.totalPlaces} Places",
                    style: theme.labelLarge!.copyWith(
                      color: AppColors.blackColor,
                    ),
                  ),
                ],
              ),
              0.01.width.vSpace,
              Expanded(
                child: VerticalDivider(),
              ),
              0.01.width.vSpace,
              Column(
                children: [
                  Icon(Icons.access_time_rounded),
                  0.01.height.hSpace,
                  Text(
                    "${widget.model.totalDays} Days",
                    style: theme.labelLarge!.copyWith(
                      color: AppColors.blackColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        0.01.height.hSpace,
        Divider(),
        0.01.height.hSpace,
        Text(
          "Location",
          style: theme.titleMedium!.copyWith(
            color: AppColors.blackColor,
          ),
        ),
        0.01.height.hSpace,
        SizedBox(
          height: 0.4.height,
          child: SetMapLocation(
            locations: LatLng(
              widget.model.toLat,
              widget.model.toLat,
            ),
            imageUrl: widget.model.imageUrl,
          ),
        ),
        0.01.height.hSpace,
        SizedBox(
          width: double.maxFinite,
          child: CustomElevatedButton(
            text: "Reserve",
            borderRadius: 10,
            onPressed: () {
              slideRightWidget(
                context: context,
                  newPage:  TripDeparture(model: widget.model,),
              );
            },
          ),
        ),
        0.01.height.hSpace,
      ],
    );
  }
}
