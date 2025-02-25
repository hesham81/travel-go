import 'package:flutter/material.dart';
import 'package:travel_go/core/extensions/align.dart';
import 'package:travel_go/core/extensions/dimensions.dart';
import 'package:travel_go/core/extensions/extensions.dart';
import 'package:travel_go/core/theme/app_colors.dart';
import 'package:travel_go/core/widget/loading_image_network_widget.dart';
import 'package:travel_go/modules/layout/pages/admin/menna/trippp/model/trip_model.dart';

class TripAdminBrowseWidget extends StatefulWidget {
  final TripDataProgramModel model;

  const TripAdminBrowseWidget({
    super.key,
    required this.model,
  });

  @override
  State<TripAdminBrowseWidget> createState() => _TripAdminBrowseWidgetState();
}

class _TripAdminBrowseWidgetState extends State<TripAdminBrowseWidget> {
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Container(
      width: double.maxFinite,
      height: 0.25.height,
      decoration: BoxDecoration(
        color: AppColors.greyColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.model.tripTitle,
                  style: theme.textTheme.titleLarge!.copyWith(
                    color: AppColors.blackColor,
                    fontSize: 20,
                  ),
                ),
                0.01.height.hSpace,
                Text(
                  widget.model.organizedBy.companyName,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.titleMedium!.copyWith(
                    color: AppColors.blackColor,
                  ),
                ),
                0.01.height.hSpace,
                Text(
                  "From ${widget.model.from}",
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.titleMedium!.copyWith(
                    color: AppColors.blackColor,
                  ),
                ),
                0.01.height.hSpace,
                Text(
                  "To ${widget.model.to}",
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.titleMedium!.copyWith(
                    color: AppColors.blackColor,
                  ),
                ),
                0.01.height.hSpace,
                Text(
                  "Duration ${widget.model.tripDuration} Hours",
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.titleMedium!.copyWith(
                    color: AppColors.blackColor,
                  ),
                ),
              ],
            ).allPadding(15).center,
          ),
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(12),
                bottomRight: Radius.circular(12),
              ),
              child: LoadingImageNetworkWidget(
                imageUrl: widget.model.tripImageUrl,
                height: 0.25.height,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
