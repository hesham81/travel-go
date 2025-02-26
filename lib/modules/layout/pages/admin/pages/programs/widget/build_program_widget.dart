import 'package:flutter/material.dart';
import 'package:travel_go/core/widget/custom_elevated_button.dart';
import 'package:travel_go/modules/layout/pages/admin/pages/programs/pages/delete_program.dart';
import 'package:travel_go/modules/layout/pages/admin/pages/programs/pages/edit_program.dart';
import '/core/extensions/extensions.dart';
import '/core/theme/app_colors.dart';
import '/core/widget/loading_image_network_widget.dart';
import '/modules/layout/pages/admin/menna/trippp/model/programs.dart';

class BuildProgramWidget extends StatelessWidget {
  final Program model;

  const BuildProgramWidget({
    super.key,
    required this.model,
  });

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).textTheme;
    return Container(
      width: double.maxFinite,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: AppColors.greyColor,
      ),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Column(
              children: [
                Text(
                  model.programTitle,
                  style: theme.titleMedium,
                ),
                0.01.height.hSpace,
                Text(
                  model.programDetails,
                  overflow: TextOverflow.ellipsis,
                  style: theme.titleMedium!.copyWith(),
                ),
                0.01.height.hSpace,
                Row(
                  children: [
                    Expanded(
                      child: IconButton(
                        onPressed: () {
                          Navigator.pushNamed(
                            context,
                            EditProgram.routeName,
                            arguments: model,
                          );
                        },
                        style: IconButton.styleFrom(
                          backgroundColor: AppColors.newBlueColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
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
                        onPressed: () {
                          Navigator.pushNamed(
                            context,
                            DeleteProgram.routeName,
                            arguments: model,
                          );
                        },
                        style: IconButton.styleFrom(
                          backgroundColor: AppColors.errorColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        icon: Icon(
                          Icons.delete_outline,
                          color: AppColors.greyColor,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ).allPadding(10),
          ),
          Expanded(
            flex: 3,
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(12),
                bottomRight: Radius.circular(12),
              ),
              child: LoadingImageNetworkWidget(
                imageUrl: model.attraction.imageUrl,
                height: 0.2.height,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
