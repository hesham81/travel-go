import 'package:flutter/material.dart';
import '/core/extensions/extensions.dart';
import '/core/theme/app_colors.dart';
import '/models/trip_program_day.dart';
import '/modules/layout/pages/admin/pages/trips/widget/program_day_widget.dart';

class ProgramDay extends StatelessWidget {
  static const routeName = '/program-day';

  const ProgramDay({super.key});

  @override
  Widget build(BuildContext context) {
    var model = ModalRoute.of(context)!.settings.arguments as TripProgramDay;
    var style = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Program',
          style: style.titleLarge!.copyWith(
            color: AppColors.whiteColor,
          ),
        ),
      ),
      body: Column(
        children: [
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) => ProgramDayWidget(
              model: model,
              index: index,
            ),
            separatorBuilder: (context, index) => 0.02.height.hSpace,
            itemCount: model.calcTotalDays(),
          )
        ],
      ).allPadding(10),
    );
  }
}
