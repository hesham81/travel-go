import 'package:flutter/material.dart';
import '/core/extensions/align.dart';
import '/core/extensions/extensions.dart';
import '/core/theme/app_colors.dart';
import '/core/widget/loading_image_network_widget.dart';
import '/models/trip_data_model.dart';

class TripCartWidget extends StatelessWidget {
  final TripDataModel model;

  const TripCartWidget({
    super.key,
    required this.model,
  });

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).textTheme;
    return Container(
      height: 0.2.height,
      decoration: BoxDecoration(
        color: AppColors.greyColor,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 9,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    model.tripId,
                    style: theme.labelLarge,
                  ).center,
                  0.01.height.hSpace,
                  Row(
                    children: [
                      Text(
                        "Total Days : ",
                        style: theme.labelLarge!.copyWith(
                          color: AppColors.newBlueColor,
                        ),
                      ),
                      Text(
                        "${model.totalDays}",
                        style: theme.labelLarge!.copyWith(
                          color: AppColors.blackColor,
                        ),
                      ),
                    ],
                  ),
                  0.01.height.hSpace,
                  Row(
                    children: [
                      Text(
                        "From : ",
                        style: theme.labelLarge!.copyWith(
                          color: AppColors.newBlueColor,
                        ),
                      ),
                      Text(
                        model.source,
                        style: theme.labelLarge!.copyWith(
                          color: AppColors.blackColor,
                        ),
                      ),
                    ],
                  ),
                  0.01.height.hSpace,
                  Row(
                    children: [
                      Text(
                        "To : ",
                        style: theme.labelLarge!.copyWith(
                          color: AppColors.newBlueColor,
                        ),
                      ),
                      Text(
                        model.destination,
                        style: theme.labelLarge!.copyWith(
                          color: AppColors.blackColor,
                        ),
                      ),
                    ],
                  ),
                  0.01.height.hSpace,
                  Row(
                    children: [
                      Text(
                        "Total Guests : ",
                        style: theme.labelLarge!.copyWith(
                          color: AppColors.newBlueColor,
                        ),
                      ),
                      Text(
                        model.totalGuests.toString(),
                        style: theme.labelLarge!.copyWith(
                          color: AppColors.blackColor,
                        ),
                      ),
                    ],
                  ),
                  0.01.height.hSpace,
                  Row(
                    children: [
                      Text(
                        "Price : ",
                        style: theme.labelLarge!.copyWith(
                          color: AppColors.newBlueColor,
                        ),
                      ),
                      Text(
                        "${model.price} ${model.currency}",
                        style: theme.labelLarge!.copyWith(
                          color: AppColors.blackColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ).allPadding(7),
            ),
          ),
          Expanded(
            flex: 7,
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(25),
                bottomRight: Radius.circular(25),
              ),
              child: LoadingImageNetworkWidget(
                imageUrl: model.imageUrl!,
                height: 0.2.height,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
