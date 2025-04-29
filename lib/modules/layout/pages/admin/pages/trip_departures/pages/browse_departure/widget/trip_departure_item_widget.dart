import 'package:flutter/material.dart';
import 'package:route_transitions/route_transitions.dart';
import 'package:travel_go/core/widget/custom_container.dart';
import 'package:travel_go/modules/layout/pages/admin/pages/trip_departures/pages/delete_departure/pages/delete_trip_departure.dart';
import 'package:travel_go/modules/layout/pages/admin/pages/trip_departures/pages/update_departure/pages/update_departure.dart';
import '/core/extensions/extensions.dart';
import '/core/theme/app_colors.dart';
import '/core/widget/labels_widget.dart';
import '/modules/layout/pages/admin/pages/trip_departures/data/model/trip_departure_data_model.dart';

class TripDepartureItemWidget extends StatelessWidget {
  final TripDepartureDataModel model;
  final bool isUpdate;

  final bool isDelete;

  const TripDepartureItemWidget({
    super.key,
    required this.model,
    this.isUpdate = true,
    this.isDelete = true,
  });

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
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
                  label: "${model.availableSeats} Seats",
                  value: "",
                ),
              ],
            ),
          ),
          0.01.width.vSpace,
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                (isUpdate)
                    ? Expanded(
                        child: IconButton(
                          onPressed: () => slideLeftWidget(
                              newPage: UpdateDeparture(
                                departureDataModel: model,
                              ),
                              context: context),
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
                      )
                    : SizedBox(),
                0.01.width.vSpace,
                (isDelete)
                    ? Expanded(
                        child: IconButton(
                          onPressed: () => slideLeftWidget(
                            newPage: DeleteTripDeparture(
                              tripDepartureDataModel: model,
                            ),
                            context: context,
                          ),
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
                      )
                    : SizedBox(),
              ],
            ),
          )
        ],
      ).allPadding(8),
    );
  }
}
