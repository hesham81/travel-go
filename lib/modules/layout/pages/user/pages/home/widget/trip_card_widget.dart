import 'package:flutter/material.dart';
import '/core/extensions/extensions.dart';
import '/core/widget/label.dart';
import '/models/trip_model.dart';

import '../../../../../../../core/theme/app_colors.dart';

class TripCardWidget extends StatelessWidget {
  final TripModel tripModel;

  const TripCardWidget({
    super.key,
    required this.tripModel,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Expanded(
        child: Row(
          children: [
            Expanded(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Label(
                    text: tripModel.title,
                    textSize: 20,
                    textWeight: FontWeight.w500,
                  ),
                  15.hSpace,
                  Label(
                    text:
                        "Start Date : ${tripModel.startDateTime.day}/${tripModel.startDateTime.month}/${tripModel.startDateTime.year} ",
                    textSize: 18,
                    textWeight: FontWeight.w400,
                  ),
                  15.hSpace,
                  Label(
                    text:
                        "End Date : ${tripModel.endDateTime.day}/${tripModel.endDateTime.month}/${tripModel.endDateTime.year} ",
                    textSize: 18,
                    textWeight: FontWeight.w400,
                  ),
                  15.hSpace,
                  Label(
                    text: "Price : ${tripModel.price} ${tripModel.currency}",
                    textSize: 18,
                    textWeight: FontWeight.w400,
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Image.asset(tripModel.imageUrl),
            ),
          ],
        ).allPadding(10),
      ),
    ).hPadding(0.04.width);
  }
}
