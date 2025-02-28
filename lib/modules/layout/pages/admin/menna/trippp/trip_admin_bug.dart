import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import '/core/providers/trip_admin_provider.dart';
import '/core/extensions/align.dart';
import '/core/widget/map.dart';
import '/modules/layout/pages/admin/menna/trippp/assign_flight_trip.dart';
import '/modules/layout/pages/admin/menna/trippp/assign_hotel.dart';
import '/core/widget/custom_elevated_button.dart';
import '/core/widget/loading_image_network_widget.dart';
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
  TextEditingController idController = TextEditingController();
  TextEditingController tripNameController = TextEditingController();
  TextEditingController tripVideoUrlController = TextEditingController();
  TextEditingController tripTotalGuestsController = TextEditingController();
  TextEditingController tripTotalDaysController = TextEditingController();
  var controller = DateRangePickerController();

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<TripAdminProvider>(context);

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
              hintText: "Trip Name ",
            ),
            0.02.height.hSpace,
            // CustomTextFormField(
            //   hintText: "Trip Description",
            //   minLine: 3,
            // ),
            // 0.01.height.hSpace,
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, AppMaps.routeName);
              },
              child: Text(
                "From .. To",
                style: theme.titleMedium!.copyWith(
                  color: AppColors.blackColor,
                ),
              ),
            ),
            0.01.height.hSpace,
            Container(
              height: 0.2.height,
              decoration: BoxDecoration(
                border: Border.all(
                  width: 2,
                  color: AppColors.newBlueColor,
                ),
              ),
              child: AppMaps(),
            ).center,
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
              controller: tripTotalDaysController,
              onComplete: (p0) {
                int value = int.tryParse(tripTotalDaysController.text) ?? 0;
                provider.setTotalDays(value);
              },
            ),
            0.02.height.hSpace,
            WidgetElevetedButton(
              borderRadius: 10,
              onPressed: () => Navigator.pushNamed(
                context,
                ProgramDay.routeName,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    "Program ${provider.getTotalDays} Days",
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
                      provider.getSelectionFlight == null
                          ? "Assign Flight"
                          : "${provider.getSelectionFlight!.flightName}  ${provider.getSelectionFlight!.airline!.flighAirLineName}",
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
              onPressed: () {
                Navigator.pushNamed(context, AssignHotel.routeName);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    provider.getSelectionHotel == null
                        ? "Assign Hotel"
                        : provider.getSelectionHotel!.hotelName,
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
