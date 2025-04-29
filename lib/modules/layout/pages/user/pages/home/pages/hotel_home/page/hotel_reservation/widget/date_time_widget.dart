import 'package:flutter/material.dart';
import 'package:travel_go/core/extensions/dimensions.dart';
import 'package:travel_go/core/extensions/extensions.dart';
import 'package:travel_go/core/theme/app_colors.dart';
import 'package:travel_go/core/widget/custom_container.dart';

class DateTimeWidget extends StatelessWidget {
  final bool isCheckIn;
  final String? date;


  const DateTimeWidget({
    super.key,
    this.isCheckIn = false,
    this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 0.1.height,
      width: double.maxFinite,
      decoration: BoxDecoration(
        color: AppColors.greyColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.calendar_month,
              ),
              0.01.width.vSpace,
              Text(
                "Check In / Out",
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                    ),
              ),
            ],
          ),
          0.01.height.hSpace,
          Text(
            date ?? "No Date Selected",
            style: Theme.of(context).textTheme.labelSmall!.copyWith(
                  color: AppColors.blackColor.withOpacity(0.38),
                ),
          ),
        ],
      ),
    );
  }
}
