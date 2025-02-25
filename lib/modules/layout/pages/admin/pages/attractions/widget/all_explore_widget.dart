import 'package:flutter/material.dart';
import '/core/extensions/align.dart';
import '/core/widget/loading_image_network_widget.dart';
import '/models/attractions_model.dart';
import '/core/extensions/extensions.dart';
import '/core/theme/app_colors.dart';

class AllExploreAttractions extends StatelessWidget {
  final AttractionsModel model;
  final Function()? deleteFunction;

  final Function()? editFunction;

  const AllExploreAttractions({
    super.key,
    required this.model,
    this.deleteFunction,
    this.editFunction,
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    model.title,
                    style: theme.textTheme.titleLarge!.copyWith(
                      color: AppColors.blackColor,
                      fontSize: 20,
                    ),
                  ),
                  Text(
                    model.location,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.titleMedium!.copyWith(
                      color: AppColors.blackColor,
                    ),
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: IconButton(
                            onPressed: editFunction,
                            style: IconButton.styleFrom(
                              backgroundColor: AppColors.newBlueColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(3),
                              ),
                            ),
                            icon: Icon(
                              Icons.edit,
                              color: AppColors.greyColor,
                            ),
                          ),
                        ),
                        0.01.width.vSpace,
                        Expanded(
                          child: IconButton(
                            onPressed: deleteFunction,
                            style: IconButton.styleFrom(
                              backgroundColor: AppColors.errorColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(3),
                              ),
                            ),
                            icon: Icon(
                              Icons.delete,
                              color: AppColors.greyColor,
                            ),
                          ),
                        ),
                      ],
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
