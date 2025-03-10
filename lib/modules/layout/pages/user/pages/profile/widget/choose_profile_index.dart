import 'package:flutter/material.dart';
import 'package:travel_go/core/extensions/extensions.dart';
import 'package:travel_go/core/theme/app_colors.dart';

class ChooseProfileIndex extends StatelessWidget {
  final IconData icon;
  final String title;
  final IconButton button;

  const ChooseProfileIndex({
    super.key,
    required this.icon,
    required this.title,
    required this.button,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      height: 0.07.height,
      decoration: BoxDecoration(
          color: AppColors.greyColor, borderRadius: BorderRadius.circular(15)),
      child: Row(
        children: [
          0.03.width.vSpace,
          Icon(
            icon,
            color: AppColors.blackColor,
          ),
          0.03.width.vSpace,
          Text(
            title,
            style: Theme.of(context).textTheme.titleSmall!.copyWith(
                  color: AppColors.blackColor,
                ),
          ),
          Spacer(),
          button,
          0.01.width.vSpace,
        ],
      ),
    );
  }
}
