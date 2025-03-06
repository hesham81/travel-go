import 'package:flutter/material.dart';
import '/core/extensions/extensions.dart';
import '/core/theme/app_colors.dart';
import '/models/trip_data_model.dart';
import '/modules/layout/pages/admin/pages/trips/widget/program_widget.dart';

class ProgramDetails extends StatelessWidget {
  static const routeName = '/program-details';

  const ProgramDetails({super.key});

  @override
  Widget build(BuildContext context) {
    var model = ModalRoute.of(context)!.settings.arguments as TripDataModel;
    var theme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            Icons.arrow_back_ios,
          ),
        ),
        title: Text(
          model.tripId,
          style: theme.titleMedium!.copyWith(
            color: AppColors.whiteColor,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            0.01.height.hSpace,
            ListView.separated(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) => GestureDetector(
                onTap: () {},
                child: ProgramWidget(
                  model: model.programDetails[index],
                ),
              ),
              separatorBuilder: (context, _) => 0.01.height.hSpace,
              itemCount: model.programDetails.length,
            ),
          ],
        ).hPadding(0.03.width),
      ),
    );
  }
}
