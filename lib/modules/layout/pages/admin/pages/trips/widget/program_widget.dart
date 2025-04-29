import 'dart:developer';

import 'package:flutter/material.dart';
import '/core/extensions/align.dart';
import '/core/extensions/extensions.dart';
import '/core/theme/app_colors.dart';
import '/core/widget/loading_image_network_widget.dart';
import '/models/program_model.dart';

class ProgramWidget extends StatelessWidget {
  final ProgramModel model;

  const ProgramWidget({
    super.key,
    required this.model,
  });

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).textTheme;
    log("Length is ${model.images.length}");
    return Container(
      height: 0.21.height,
      decoration: BoxDecoration(
        color: AppColors.greyColor,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 9,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  model.id,
                  overflow: TextOverflow.ellipsis,
                  style: theme.labelLarge!.copyWith(
                    color: AppColors.blackColor,
                  ),
                ).center,
                0.01.height.hSpace,
                Text(
                  model.programDetails,
                  overflow: TextOverflow.ellipsis,
                  style: theme.labelLarge!.copyWith(
                    color: AppColors.blackColor,
                  ),
                ),
                0.01.height.hSpace,
                Text(
                  "Days ${model.dayNumber.map(
                    (e) => e.toString(),
                  )}",
                  overflow: TextOverflow.ellipsis,
                  style: theme.labelLarge!.copyWith(
                    color: AppColors.blackColor,
                  ),
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
                      " ${model.from.format(context)}",
                      overflow: TextOverflow.ellipsis,
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
                      " ${model.to.format(context)}",
                      overflow: TextOverflow.ellipsis,
                      style: theme.labelLarge!.copyWith(
                        color: AppColors.blackColor,
                      ),
                    ),
                  ],
                ),
              ],
            ).allPadding(5),
          ),
          Expanded(
            flex: 7,
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(25),
                bottomRight: Radius.circular(25),
              ),
              child: LoadingImageNetworkWidget(
                height: 0.21.height,
                imageUrl: model.images.last ?? "",
              ),
            ),
          ),
        ],
      ),
    );
  }
}
