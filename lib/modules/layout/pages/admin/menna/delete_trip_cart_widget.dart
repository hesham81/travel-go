import 'package:flutter/material.dart';
import 'package:travel_go/core/routes/route_transact.dart';
import 'package:travel_go/modules/layout/pages/admin/menna/delete_selected_trip.dart';
import '/core/extensions/align.dart';
import '/core/extensions/extensions.dart';
import '/core/theme/app_colors.dart';
import '/core/widget/loading_image_network_widget.dart';
import '/models/trip_data_model.dart';

class DeleteTripCartWidget extends StatelessWidget {
  final TripDataModel model;

  const DeleteTripCartWidget({
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
                      Expanded(
                        child: IconButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              SlideRightRoute(
                                page: DeleteSelectedTrip(
                                  trip: model,
                                ),
                              ),
                            );
                          },
                          style: IconButton.styleFrom(
                            backgroundColor: AppColors.errorColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(3),
                            ),
                          ),
                          icon: Icon(
                            Icons.delete_outline,
                            color: AppColors.whiteColor,
                          ),
                        ),
                      ),
                    ],
                  )
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
