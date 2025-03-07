import 'package:flutter/material.dart';
import '/core/extensions/align.dart';
import '/core/extensions/dimensions.dart';
import '/core/theme/app_colors.dart';
import '/core/widget/loading_image_network_widget.dart';
import '/models/trip_data_model.dart';

class TripExplorer extends StatelessWidget {
  final TripDataModel model;

  const TripExplorer({
    super.key,
    required this.model,
  });

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).textTheme;
    return Container(
      height: 0.1.height,
      width: double.maxFinite,
      decoration: BoxDecoration(
        color: AppColors.greyColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              model.tripName,
              overflow: TextOverflow.ellipsis,
              style: theme.titleMedium!.copyWith(
                color: AppColors.blackColor,
              ),
            ).center,
          ),
          Expanded(
            flex: 5,
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(12),
                bottomRight: Radius.circular(12),
              ),
              child: LoadingImageNetworkWidget(
                imageUrl: model.imageUrl!,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
