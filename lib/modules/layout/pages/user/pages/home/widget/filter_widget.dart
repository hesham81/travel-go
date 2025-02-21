import 'package:chips_choice/chips_choice.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '/core/extensions/align.dart';
import '/core/theme/app_colors.dart';
import '/core/widget/custom_elevated_button.dart';
import '/core/extensions/extensions.dart';

class FilterWidget extends StatefulWidget {
  const FilterWidget({super.key});

  @override
  State<FilterWidget> createState() => _FilterWidgetState();
}

class _FilterWidgetState extends State<FilterWidget> {
  List<String> generalOptions = [
    "Start Date",
    "End Date",
  ];

  List<String> selectedGeneral = [];
  List<String> availableOptions = [
    "Available",
  ];

  List<String> selectedAvailable = [];
  List<String> locationOptions = [
    "Destination",
    "Source",
    "Air Port",
    "City",
    "Country",
  ];
  double endRating = 0.0;

  List<String> selectedLocation = [];
  RangeValues _distanceRange = const RangeValues(100, 50000); // Default values

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).textTheme;
    return Container(
      color: AppColors.greyColor,
      height: 0.8.height,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Text(
            //   "Filter",
            //   style: theme.titleLarge,
            // ),
            ChipsChoice<String>.multiple(
              value: selectedGeneral,
              wrapped: true,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              alignment: WrapAlignment.center,
              onChanged: (val) => setState(() => selectedGeneral = val),
              choiceItems: C2Choice.listFrom<String, String>(
                source: generalOptions,
                value: (index, item) => item,
                label: (index, item) => item,
              ),
              choiceStyle: C2ChipStyle.filled(
                selectedStyle: const C2ChipStyle(
                  borderColor: Colors.blue,
                  borderWidth: 1.5,
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.blue,
                ),
              ),
            ).center,
            Divider().hPadding(
              0.15.width,
            ),
            0.01.height.hSpace,
            Text(
              "Location",
              style: theme.titleSmall,
            ),
            ChipsChoice<String>.multiple(
              value: selectedLocation,
              wrapped: true,
              alignment: WrapAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              onChanged: (val) => setState(() => selectedLocation = val),
              choiceItems: C2Choice.listFrom<String, String>(
                source: locationOptions,
                value: (index, item) => item,
                label: (index, item) => item,
              ),
              choiceStyle: C2ChipStyle.filled(
                selectedStyle: const C2ChipStyle(
                  borderColor: Colors.blue,
                  borderWidth: 1.5,
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.blue,
                ),
              ),
            ).center,
            Divider().hPadding(
              0.15.width,
            ),
            0.01.height.hSpace,
            Text(
              "Price",
              style: theme.titleSmall,
            ),
            SliderTheme(
              data: SliderTheme.of(context).copyWith(
                trackHeight: 2,
                rangeThumbShape: const RoundRangeSliderThumbShape(
                  enabledThumbRadius: 10,
                ),
                activeTrackColor: Colors.blue,
                inactiveTrackColor: Colors.grey.shade300,
                thumbColor: Colors.blue,
                overlayColor: AppColors.dodgurBlueColor.withAlpha(80),
              ),
              child: RangeSlider(
                values: _distanceRange,
                min: 100,
                max: 50000,
                divisions: 100,
                labels: RangeLabels(
                  "${_distanceRange.start.toInt()} \$",
                  "${_distanceRange.end.toInt()} \$",
                ),
                onChanged: (RangeValues values) {
                  setState(
                    () {
                      _distanceRange = values;
                    },
                  );
                },
              ),
            ),
            Divider().hPadding(
              0.15.width,
            ),
            0.01.height.hSpace,
            Text(
              "availability",
              style: theme.titleSmall,
            ),
            ChipsChoice<String>.multiple(
              value: selectedAvailable,
              wrapped: true,
              alignment: WrapAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              onChanged: (val) => setState(
                () => selectedAvailable = val,
              ),
              choiceItems: C2Choice.listFrom<String, String>(
                source: availableOptions,
                value: (index, item) => item,
                label: (index, item) => item,
              ),
              choiceStyle: C2ChipStyle.filled(
                selectedStyle: const C2ChipStyle(
                  borderColor: Colors.blue,
                  borderWidth: 1.5,
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.blue,
                ),
              ),
            ).center,
            Divider().hPadding(
              0.15.width,
            ),
            0.01.height.hSpace,
            Text(
              "Rating",
              style: theme.titleSmall,
            ),
            0.01.height.hSpace,
            RatingBar.builder(
              initialRating: 0,
              minRating: 0,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
              itemBuilder: (context, _) => Icon(
                Icons.star,
                color: Colors.amber,
              ),
              onRatingUpdate: (rating) {
                endRating = rating;
              },
            ).center,
            // Spacer(),
            0.02.height.hSpace,
            CustomElevatedButton(
              text: "Filter (2)",
              onPressed: () {},
              textSize: 15,
              borderRadius: 10,
            ),
          ],
        ).allPadding(15),
      ),
    );
  }
}
