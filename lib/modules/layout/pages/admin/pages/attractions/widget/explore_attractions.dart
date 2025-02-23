import 'package:flutter/material.dart';
import 'package:travel_go/core/extensions/align.dart';
import 'package:travel_go/core/widget/loading_image_network_widget.dart';
import 'package:travel_go/models/attractions_model.dart';
import '/core/extensions/extensions.dart';
import '/core/theme/app_colors.dart';

class ExploreAttractions extends StatelessWidget {
  final AttractionsModel model;

  const ExploreAttractions({
    super.key,
    required this.model,
  });

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return SafeArea(
      child: Container(
        width: double.maxFinite,
        height: 0.2.height,
        decoration: BoxDecoration(
          color: AppColors.greyColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    model.location,
                    style: theme.textTheme.titleLarge!.copyWith(
                      color: AppColors.blackColor,
                    ),
                  ),
                  Text(
                    model.description,
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
                  imageUrl: model.imageUrl,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
