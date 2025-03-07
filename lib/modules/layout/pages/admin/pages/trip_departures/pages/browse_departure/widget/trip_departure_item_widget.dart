import 'package:flutter/material.dart';
import '/core/extensions/extensions.dart';
import '/core/theme/app_colors.dart';
import '/core/widget/labels_widget.dart';
import '/modules/layout/pages/admin/pages/trip_departures/data/model/trip_departure_data_model.dart';

class TripDepartureItemWidget extends StatelessWidget {
  final TripDepartureDataModel model;

  const TripDepartureItemWidget({
    super.key,
    required this.model,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      decoration: BoxDecoration(
        color: AppColors.greyColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          0.01.height.hSpace,
          Expanded(
            child: Column(
              children: [
                LabelsWidget(
                  label: "From : ",
                  value:
                      "${model.from.day}/${model.from.month}/${model.from.year}",
                ),
                0.01.height.hSpace,
                LabelsWidget(
                  label: "To : ",
                  value: "${model.to.day}/${model.to.month}/${model.to.year}",
                ),
                0.01.height.hSpace,
                LabelsWidget(
                  label: "Available Seats : ",
                  value: "${model.availableSeats} Seat",
                ),
              ],
            ),
          ),
          0.01.width.vSpace,
        ],
      ).allPadding(8),
    );
  }
}
