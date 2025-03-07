import 'package:flutter/material.dart';
import 'package:travel_go/models/program_model.dart';
import 'package:travel_go/modules/layout/pages/user/pages/home/pages/trip/pages/selected_trip/pages/trip_program/pages/day_content.dart';
import '/core/extensions/extensions.dart';
import '/core/widget/custom_elevated_button.dart';
import '/models/trip_data_model.dart';
import '/core/theme/app_colors.dart';

class TripProgramHome extends StatefulWidget {
  final TripDataModel model;

  const TripProgramHome({
    super.key,
    required this.model,
  });

  @override
  State<TripProgramHome> createState() => _TripProgramHomeState();
}

class _TripProgramHomeState extends State<TripProgramHome> {
  ProgramModel? selectedProgram;
  List<ProgramModel> programsDays = [];

  ProgramModel? searchByDay(int day) {
    for (var element in widget.model.programDetails) {
      if (element.dayNumber.contains(day)) {
        return element;
      }
    }
    return null;
  }

  totalDayNumberProgram(int day) {
    programsDays = [];
    for (var element in widget.model.programDetails) {
      if (element.dayNumber.contains(day)) {
        programsDays.add(element);
      }
    }
    setState(() {});
  }

  int _calcTotalWeeks(totalDays) {
    return ((totalDays ~/ 7) == 0) ? 1 : (totalDays ~/ 7);
  }

  int dayIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        0.01.height.hSpace,
        SizedBox(
          height: 0.08.height,
          child: ListView.separated(
            padding: EdgeInsets.zero,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) => CustomElevatedButton(
              text: (_calcTotalWeeks(widget.model.totalDays) == 1)
                  ? "Day ${index + 1}"
                  : "Week ${index + 1}",
              onPressed: () {
                dayIndex = index;
                totalDayNumberProgram(index + 1);
                setState(() {});
              },
              borderColor: (dayIndex != index)
                  ? AppColors.greyColor
                  : AppColors.newBlueColor,
              borderWidth: 0,
              borderRadius: 10,
              textColor: (dayIndex == index)
                  ? AppColors.whiteColor
                  : AppColors.blackColor,
              btnColor: (dayIndex != index)
                  ? AppColors.greyColor
                  : AppColors.newBlueColor,
            ),
            separatorBuilder: (context, index) => 0.02.width.vSpace,
            itemCount: (_calcTotalWeeks(widget.model.totalDays) == 1)
                ? widget.model.totalDays
                : _calcTotalWeeks(
                    widget.model.totalDays,
                  ),
          ),
        ),
        0.01.height.hSpace,
        ListView.separated(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) => DayContent(
            model: programsDays[index],
          ),
          separatorBuilder: (context, index) => Divider().hPadding(0.1.width),
          itemCount: programsDays.length,
        ),
        0.01.height.hSpace,
        Divider().hPadding(0.1.width)
      ],
    );
  }
}
