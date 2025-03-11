import 'package:flutter/material.dart';
import 'package:travel_go/core/extensions/align.dart';
import 'package:travel_go/core/extensions/extensions.dart';
import 'package:travel_go/core/theme/app_colors.dart';
import 'package:travel_go/core/widget/custom_rating_widget.dart';
import 'package:travel_go/core/widget/labels_widget.dart';
import 'package:travel_go/core/widget/loading_image_network_widget.dart';
import 'package:travel_go/models/trip_data_model.dart';

class UserTripHotel extends StatelessWidget {
  final TripDataModel model;

  const UserTripHotel({
    super.key,
    required this.model,
  });

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).textTheme;
    return Column(
      children: [
        LoadingImageNetworkWidget(
          imageUrl: model.hotel.imageUrl,
        ),
        0.02.height.hSpace,
        Container(
          width: double.maxFinite,
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.0),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.4),
                spreadRadius: 1,
                blurRadius: 5,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              LabelsWidget(
                label: "Hotel Name : ",
                value: model.hotel.hotelName,
              ),
              0.01.height.hSpace,
              LabelsWidget(
                label: "Location : ",
                value: model.hotel.hotelLocation,
              ),
              0.01.height.hSpace,
              LabelsWidget(
                label: "Available Rooms : ",
                value: "${model.hotel.availableRooms} Room",
              ),
              0.01.height.hSpace,
              CustomRatingWidget(
                minRating: model.hotel.hotelRating,
              )
            ],
          ),
        ),
        0.02.height.hSpace,
        Container(
          width: double.maxFinite,
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.0),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.4),
                spreadRadius: 1,
                blurRadius: 5,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Column(
            children: [
              Text(
                "Room Prices  ",
                style: theme.titleMedium!.copyWith(
                  color: AppColors.blackColor,
                ),
              ).alignTopLeft(),
              0.01.height.hSpace,
              LabelsWidget(
                label: "Single Room : ",
                value: "\$Audit 80 / \$Child 40",
              ),
              0.01.height.hSpace,
              LabelsWidget(
                label: "Double Room : ",
                value: "\$Audit 100 / \$Child 50",
              ),
              0.01.height.hSpace,
              LabelsWidget(
                label: "Suit Room : ",
                value: "\$Audit 200 / \$Child 100",
              ),
            ],
          ),
        ),
        0.02.height.hSpace,
        Container(
          width: double.maxFinite,
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.0),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.4),
                spreadRadius: 1,
                blurRadius: 5,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Column(
            children: [
              Text(
                "Amenities Included",
                style: theme.titleMedium!.copyWith(
                  color: AppColors.blackColor,
                ),
              ).alignTopLeft(),
              0.01.height.hSpace,
              Row(
                children: [
                  Icon(
                    Icons.check,
                    color: Colors.green,
                  ),
                  0.03.width.vSpace,
                  Text(
                    "Free Wifi",
                    style: theme.labelLarge!.copyWith(
                      color: AppColors.blackColor,
                    ),
                  ),
                ],
              ),
              0.01.height.hSpace,
              Row(
                children: [
                  Icon(
                    Icons.check,
                    color: Colors.green,
                  ),
                  0.03.width.vSpace,
                  Text(
                    "Pool",
                    style: theme.labelLarge!.copyWith(
                      color: AppColors.blackColor,
                    ),
                  ),
                ],
              ),
              0.01.height.hSpace,
              Row(
                children: [
                  Icon(
                    Icons.check,
                    color: Colors.green,
                  ),
                  0.03.width.vSpace,
                  Text(
                    "Free Cancellation",
                    style: theme.labelLarge!.copyWith(
                      color: AppColors.blackColor,
                    ),
                  ),
                ],
              ),
              0.01.height.hSpace,
              Row(
                children: [
                  Icon(
                    Icons.check,
                    color: Colors.green,
                  ),
                  0.03.width.vSpace,
                  Text(
                    "BreakFast",
                    style: theme.labelLarge!.copyWith(
                      color: AppColors.blackColor,
                    ),
                  ),
                ],
              ),
              0.01.height.hSpace,
              Row(
                children: [
                  Icon(
                    Icons.check,
                    color: Colors.green,
                  ),
                  0.03.width.vSpace,
                  Text(
                    "Restaurant",
                    style: theme.labelLarge!.copyWith(
                      color: AppColors.blackColor,
                    ),
                  ),
                ],
              ),
              0.01.height.hSpace,
              Row(
                children: [
                  Icon(
                    Icons.check,
                    color: Colors.green,
                  ),
                  0.03.width.vSpace,
                  Text(
                    "Public Parking",
                    style: theme.labelLarge!.copyWith(
                      color: AppColors.blackColor,
                    ),
                  ),
                ],
              ),
              0.01.height.hSpace,
              Row(
                children: [
                  Icon(
                    Icons.check,
                    color: Colors.green,
                  ),
                  0.03.width.vSpace,
                  Text(
                    "Air Conditioning",
                    style: theme.labelLarge!.copyWith(
                      color: AppColors.blackColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        0.02.height.hSpace,
      ],
    );
  }
}
