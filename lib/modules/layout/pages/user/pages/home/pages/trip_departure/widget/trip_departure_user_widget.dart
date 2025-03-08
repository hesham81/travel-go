import 'package:flutter/material.dart';
import 'package:travel_go/modules/layout/pages/admin/pages/trip_departures/data/model/trip_departure_data_model.dart';
import '/core/extensions/extensions.dart';
import '/core/theme/app_colors.dart';
import '/core/widget/labels_widget.dart';

class TripDepartureUserWidget extends StatelessWidget {
  final TripDepartureDataModel model;

  const TripDepartureUserWidget({
    super.key,
    required this.model,
  });

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).textTheme;
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.4),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          LabelsWidget(
            label: "From : ",
            value: "${model.from.day}/${model.from.month}/${model.from.year}",
          ),
          0.01.height.hSpace,
          LabelsWidget(
            label: "To : ",
            value: "${model.to.day}/${model.to.month}/${model.to.year}",
          ),
          0.01.height.hSpace,
          LabelsWidget(
            label: "Available : ",
            value: "${model.availableSeats} Guests",
          ),
          0.01.height.hSpace,
          Row(
            children: [
              Text(
                "After : ",
                style: theme.labelLarge!.copyWith(
                  color: AppColors.newBlueColor,
                ),
              ),
              Text(
                "${model.from.difference(DateTime.now()).inDays} Days",
                style: theme.labelLarge!.copyWith(
                  color: AppColors.blackColor.withAlpha(80),
                ),
              ),
            ],
          )
        ],
      ),
    ).hPadding(0.03.width);
  }
}
