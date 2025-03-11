import 'package:flutter/material.dart';
import '/modules/layout/pages/admin/pages/trip_departures/data/model/trip_departure_data_model.dart';
import '/core/extensions/extensions.dart';
import '/core/theme/app_colors.dart';
import '/core/widget/labels_widget.dart';

class TripDepartureUserWidget extends StatefulWidget {
  final TripDepartureDataModel model;

  const TripDepartureUserWidget({
    super.key,
    required this.model,
  });

  @override
  State<TripDepartureUserWidget> createState() =>
      _TripDepartureUserWidgetState();
}

class _TripDepartureUserWidgetState extends State<TripDepartureUserWidget> {
  late Duration availableDate;

  @override
  void initState() {
    availableDate = widget.model.from.difference(DateTime.now());
    if (availableDate == Duration.zero) {}
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).textTheme;
    return Stack(
      children: [
        Container(
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
                value:
                    "${widget.model.from.day}/${widget.model.from.month}/${widget.model.from.year}",
              ),
              0.01.height.hSpace,
              LabelsWidget(
                label: "To : ",
                value:
                    "${widget.model.to.day}/${widget.model.to.month}/${widget.model.to.year}",
              ),
              0.01.height.hSpace,
              LabelsWidget(
                label: "Available : ",
                value: "${widget.model.availableSeats} Guests",
              ),
              0.01.height.hSpace,
              (availableDate.inDays > 0)
                  ? Row(
                      children: [
                        Text(
                          "After : ",
                          style: theme.labelLarge!.copyWith(
                            color: AppColors.newBlueColor,
                          ),
                        ),
                        Text(
                          "${availableDate.inDays} Days",
                          style: theme.labelLarge!.copyWith(
                            color: AppColors.blackColor.withAlpha(80),
                          ),
                        ),
                        0.02.width.vSpace,
                        if (availableDate.inDays == 1)
                          Text(
                            "Last Date To Reserve",
                            style: theme.labelMedium!.copyWith(
                              color: Colors.green,
                            ),
                          )
                      ],
                    )
                  : Row(
                      children: [
                        Text(
                          "Not Available",
                          style: theme.labelLarge!.copyWith(
                            color: AppColors.errorColor,
                          ),
                        ),
                      ],
                    ),
            ],
          ),
        ),
      ],
    ).hPadding(0.03.width);
  }
}
