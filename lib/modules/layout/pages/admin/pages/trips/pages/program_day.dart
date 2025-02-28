import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/core/providers/trip_admin_provider.dart';
import '/core/extensions/extensions.dart';
import '/core/theme/app_colors.dart';
import '/modules/layout/pages/admin/pages/trips/widget/program_day_widget.dart';

class ProgramDay extends StatelessWidget {
  static const routeName = '/program-day';

  const ProgramDay({super.key});

  @override
  Widget build(BuildContext context) {
    var provider  = Provider.of<TripAdminProvider>(context);
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
              index: index,
            ),
            separatorBuilder: (context, index) => 0.02.height.hSpace,
            itemCount: provider.getTotalDays,
          )
        ],
      ).allPadding(10),
    );
  }
}
