import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/core/constant/app_assets.dart';
import '/core/extensions/center.dart';
import '/core/widget/custom_elevated_button.dart';
import '/modules/layout/pages/admin/pages/trips/pages/trip_program.dart';
import '/modules/layout/pages/admin/pages/trips/widget/program_widget.dart';
import '/core/providers/trip_admin_provider.dart';
import '/core/extensions/extensions.dart';
import '/core/theme/app_colors.dart';

class ProgramDay extends StatelessWidget {
  static const routeName = '/program-day';

  const ProgramDay({super.key});

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<TripAdminProvider>(context);
    var style = Theme.of(context).textTheme;
    log("Length Of List is ${provider.listOfPrograms.length}");
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Program',
          style: style.titleLarge!.copyWith(
            color: AppColors.whiteColor,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            (provider.listOfPrograms.isEmpty)
                ? Column(
                    children: [
                      0.3.height.hSpace,
                      Image.asset(
                        AppAssets.noAvailableImages,
                      ).centerWidget(),
                    ],
                  )
                : ListView.separated(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) => ProgramWidget(
                      model: provider.listOfPrograms[index],
                    ),
                    separatorBuilder: (context, index) => 0.01.height.hSpace,
                    itemCount: provider.listOfPrograms.length,
                  ),
            0.17.height.hSpace,
            CustomElevatedButton(
              text: "Add Program",
              onPressed:
                  (provider.listOfPrograms.length == provider.getTotalPrograms)
                      ? null
                      : () => Navigator.pushNamed(
                            context,
                            TripProgram.routeName,
                          ),
              borderRadius: 10,
            ),
          ],
        ).allPadding(10),
      ),
    );
  }
}
