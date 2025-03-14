import 'package:flutter/material.dart';
import 'package:travel_go/core/extensions/extensions.dart';
import 'package:travel_go/core/theme/app_colors.dart';
import 'package:travel_go/core/widget/custom_elevated_button.dart';
import 'package:travel_go/models/trip_data_model.dart';

class ModelSheetTripFilter extends StatefulWidget {
  final Function() sortAToZ;
  final Function() sortZToA;
  final Function() bookMarked;
  final Function() lessThanWeek;
  final Function() sortPriceLowToHigh;
  final Function() sortPriceHighToLow;
  final int sortIndex;
  final int filterIndex;
  final List<TripDataModel> trips;

  const ModelSheetTripFilter({
    super.key,
    required this.sortAToZ,
    required this.sortZToA,
    required this.sortIndex,
    required this.filterIndex,
    required this.bookMarked,
    required this.sortPriceLowToHigh,
    required this.sortPriceHighToLow,
    required this.trips,
    required this.lessThanWeek,
  });

  @override
  State<ModelSheetTripFilter> createState() => _ModelSheetTripFilterState();
}

class _ModelSheetTripFilterState extends State<ModelSheetTripFilter> {
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).textTheme;
    return SingleChildScrollView(
      physics: AlwaysScrollableScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          0.01.height.hSpace,
          Text(
            "Sort",
            style: theme.titleMedium!.copyWith(
              color: AppColors.blackColor,
            ),
          ),
          Row(
            children: [
              CustomElevatedButton(
                onPressed: widget.sortAToZ,
                text: "A-Z",
                borderColor: AppColors.newBlueColor,
                borderWidth: 2,
                textColor: (widget.sortIndex == 0)
                    ? AppColors.newBlueColor
                    : AppColors.whiteColor,
                btnColor: (widget.sortIndex == 0)
                    ? AppColors.whiteColor
                    : AppColors.newBlueColor,
              ),
              Spacer(),
              CustomElevatedButton(
                onPressed: widget.sortZToA,
                text: "Z-A",
                borderWidth: 2,
                borderColor: AppColors.newBlueColor,
                textColor: (widget.sortIndex == 1)
                    ? AppColors.newBlueColor
                    : AppColors.whiteColor,
                btnColor: (widget.sortIndex == 1)
                    ? AppColors.whiteColor
                    : AppColors.newBlueColor,
              ),
            ],
          ),
          0.01.height.hSpace,
          Row(
            children: [
              CustomElevatedButton(
                onPressed: widget.sortPriceLowToHigh,
                text: "The cheapest",
                borderColor: AppColors.newBlueColor,
                borderWidth: 2,
                textColor: (widget.sortIndex == 2)
                    ? AppColors.newBlueColor
                    : AppColors.whiteColor,
                btnColor: (widget.sortIndex == 2)
                    ? AppColors.whiteColor
                    : AppColors.newBlueColor,
              ),
              Spacer(),
              CustomElevatedButton(
                onPressed: widget.sortPriceHighToLow,
                text: "most expensive",
                borderWidth: 2,
                borderColor: AppColors.newBlueColor,
                textColor: (widget.sortIndex == 3)
                    ? AppColors.newBlueColor
                    : AppColors.whiteColor,
                btnColor: (widget.sortIndex == 3)
                    ? AppColors.whiteColor
                    : AppColors.newBlueColor,
              ),
            ],
          ),
          0.01.height.hSpace,
          Divider(),
          0.01.height.hSpace,
          Text(
            "Filter",
            style: theme.titleMedium!.copyWith(
              color: AppColors.blackColor,
            ),
          ),
          0.01.height.hSpace,
          Column(
            children: [
              Row(
                children: [
                  CustomElevatedButton(
                    text: "BookMarked",
                    onPressed: widget.bookMarked,
                    borderWidth: 2,
                    borderColor: AppColors.newBlueColor,
                    textColor: (widget.filterIndex == 0)
                        ? AppColors.newBlueColor
                        : AppColors.whiteColor,
                    btnColor: (widget.filterIndex == 0)
                        ? AppColors.whiteColor
                        : AppColors.newBlueColor,
                  ),
                  Spacer(),
                  CustomElevatedButton(
                    text: "Less Than Week",
                    onPressed: widget.lessThanWeek,
                    borderWidth: 2,
                    borderColor: AppColors.newBlueColor,
                    textColor: (widget.filterIndex == 1)
                        ? AppColors.newBlueColor
                        : AppColors.whiteColor,
                    btnColor: (widget.filterIndex == 1)
                        ? AppColors.whiteColor
                        : AppColors.newBlueColor,
                  ),
                ],
              ),
              0.01.height.hSpace,
            ],
          ),
          Divider(),
          0.01.height.hSpace,
        ],
      ).allPadding(10),
    );
  }
}
