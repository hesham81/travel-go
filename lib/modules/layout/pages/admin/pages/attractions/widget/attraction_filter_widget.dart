import 'package:flutter/material.dart';
import 'package:travel_go/core/extensions/dimensions.dart';
import 'package:travel_go/core/extensions/extensions.dart';
import 'package:travel_go/core/widget/custom_elevated_button.dart';

import '../../../../../../../core/theme/app_colors.dart';

class AttractionFilterWidget extends StatefulWidget {
  const AttractionFilterWidget({super.key});

  @override
  State<AttractionFilterWidget> createState() => _AttractionFilterWidgetState();
}

class _AttractionFilterWidgetState extends State<AttractionFilterWidget> {
  List<String> attractionCategories = [
    "   all   ",
    "Natural Attractions",
    "Cultural & Historical Attractions",
    "Urban & Architectural Attractions",
    "Parks & Protected Areas",
    "Entertainment & Recreational Attractions",
    "Religious & Spiritual Attractions",
    "Adventure & Outdoor Attractions",
  ];
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(20),
          topLeft: Radius.circular(20),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            "Categories",
            style: TextTheme.of(context).titleMedium,
          ),
          0.01.height.hSpace,
          SizedBox(
            height: 0.05.height,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) => CustomElevatedButton(
                text: attractionCategories[index],
                btnColor: (selectedIndex == index)
                    ? AppColors.greyColor
                    : AppColors.newBlueColor,
                borderColor: (selectedIndex == index)
                    ? AppColors.newBlueColor
                    : AppColors.greyColor,
                borderWidth: 1.2,
                onPressed: () {
                  selectedIndex = index;
                  Navigator.pop(context);
                },
                textColor: (selectedIndex == index)
                    ? AppColors.blackColor
                    : AppColors.whiteColor,
              ),
              separatorBuilder: (context, index) => 0.01.width.vSpace,
              itemCount: attractionCategories.length,
            ),
          ),
          0.01.height.hSpace,
          Divider(
            color: AppColors.newBlueColor,
          ).hPadding(
            0.05.width,
          ),
          0.01.height.hSpace,
          Text(
            "Sort",
            style: TextTheme.of(context).titleMedium,
          ),
        ],
      ).allPadding(10),
    );
  }
}
