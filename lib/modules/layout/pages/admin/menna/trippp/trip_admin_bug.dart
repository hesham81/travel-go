import 'package:flutter/material.dart';
import 'package:travel_go/modules/layout/pages/admin/menna/trippp/assign_flight_trip.dart';
import '/core/widget/custom_elevated_button.dart';
import '/core/widget/loading_image_network_widget.dart';
import '/models/trip_program_day.dart';
import '/modules/layout/pages/admin/pages/trips/pages/program_day.dart';
import '/core/extensions/extensions.dart';
import '/core/widget/custom_text_form_field.dart';
import '/core/widget/numbers_text_form_field.dart';
import '/core/widget/widget_eleveted_button.dart';

import '/core/theme/app_colors.dart';

class NewTripScreen extends StatefulWidget {
  const NewTripScreen({super.key});

  @override
  State<NewTripScreen> createState() => _NewTripScreenState();
}

class _NewTripScreenState extends State<NewTripScreen> {
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "New Trip",
          style: theme.titleLarge!.copyWith(
            color: AppColors.whiteColor,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            LoadingImageNetworkWidget(
                imageUrl:
                    "https://i.pinimg.com/736x/5d/63/e1/5d63e18215fd5e1ab2cc1fe3db2d8359.jpg"),
            CustomTextFormField(
              hintText: " Trip ID",
              isReadOnly: true,
            ),
            0.02.height.hSpace,
            CustomTextFormField(
              hintText: "Trip Title ",
            ),
            0.02.height.hSpace,
            CustomTextFormField(
              hintText: "Trip Description",
              minLine: 3,
            ),
            0.02.height.hSpace,
            CustomTextFormField(
              hintText: "Video Url",
            ),
            0.02.height.hSpace,
            NumbersTextFormField(
              hintText: "Total Guests",
            ),
            0.02.height.hSpace,
            NumbersTextFormField(
              hintText: "Total Days",
            ),
            0.02.height.hSpace,
            WidgetElevetedButton(
              borderRadius: 10,
              onPressed: () => Navigator.pushNamed(
                context,
                ProgramDay.routeName,
                arguments: TripProgramDay(
                  id: "1",
                  startDate: DateTime(2025, 1, 1),
                  endDate: DateTime(2025, 1, 5),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    "Program",
                    style: theme.titleMedium!.copyWith(
                      color: AppColors.whiteColor,
                    ),
                  ),
                  Spacer(),
                  Icon(
                    Icons.arrow_forward_ios,
                    color: AppColors.whiteColor,
                  )
                ],
              ),
            ),
            0.02.height.hSpace,
            WidgetElevetedButton(
              borderRadius: 10,
              onPressed: () {},
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    AssignFlightTrip.routeName,
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      "Assign Flight",
                      style: theme.titleMedium!.copyWith(
                        color: AppColors.whiteColor,
                      ),
                    ),
                    Spacer(),
                    Icon(
                      Icons.arrow_forward_ios,
                      color: AppColors.whiteColor,
                    )
                  ],
                ),
              ),
            ),
            0.02.height.hSpace,
            WidgetElevetedButton(
              borderRadius: 10,
              onPressed: () {},
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    "Assign Hotel",
                    style: theme.titleMedium!.copyWith(
                      color: AppColors.whiteColor,
                    ),
                  ),
                  Spacer(),
                  Icon(
                    Icons.arrow_forward_ios,
                    color: AppColors.whiteColor,
                  )
                ],
              ),
            ),
            0.02.height.hSpace,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: CustomElevatedButton(
                    text: "OK",
                    borderRadius: 10,
                    onPressed: () {},
                  ),
                ),
                0.03.width.vSpace,
                Expanded(
                  child: CustomElevatedButton(
                    text: "Cancel",
                    borderRadius: 10,
                    btnColor: AppColors.errorColor,
                    onPressed: () {},
                  ),
                ),
              ],
            ),
            0.02.height.hSpace,
          ],
        ).allPadding(10),
      ),
    );
  }
}
