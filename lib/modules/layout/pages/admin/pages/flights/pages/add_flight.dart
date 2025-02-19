import 'package:flutter/material.dart';
import 'package:travel_go/modules/layout/pages/admin/pages/flight_seat_accomdations/pages/flight_seat_accommodation.dart';
import '/modules/layout/pages/admin/pages/flights/widget/accomdation_widget.dart';
import '/core/extensions/extensions.dart';
import '/core/theme/app_colors.dart';
import '/core/widget/custom_elevated_button.dart';
import '/core/widget/custom_text_form_field.dart';
import '/core/widget/label.dart';
import '/core/widget/numbers_text_form_field.dart';

class AddFlight extends StatelessWidget {
  const AddFlight({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Manage Flight",
          style: TextStyle(
            fontSize: 28,
            color: Colors.blueAccent,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Label(
                text: "Flight ID",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueAccent,
                ),
              ),
              0.01.height.hSpace,
              CustomTextFormField(hintText: "Enter Flight ID"),
              0.01.height.hSpace,
              Label(
                text: "Flight Name",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueAccent,
                ),
              ),
              0.01.height.hSpace,
              CustomTextFormField(hintText: "Enter Flight Name"),
              0.01.height.hSpace,
              Label(
                text: "Flight Airline",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueAccent,
                ),
              ),
              0.01.height.hSpace,
              CustomTextFormField(hintText: "Enter Flight Airline"),
              0.01.height.hSpace,
              Label(
                text: "Flight Price",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueAccent,
                ),
              ),
              0.01.height.hSpace,
              NumbersTextFormField(
                hintText: "Flight Price",
              ),
              0.01.height.hSpace,
              AccomdationWidget(
                textDescription: 'Enter Number Of Seats',
                onTap: () => Navigator.pushNamed(
                  context,
                  FlightSeatAccommodation.routeName,
                ),
              ),
              0.01.height.hSpace,
              Row(
                children: [
                  Expanded(
                    child: CustomElevatedButton(
                      text: "Submit",
                      onPressed: () => Navigator.pop(context),
                      textSize: 15,
                      borderRadius: 10,
                    ),
                  ),
                  0.02.width.vSpace,
                  Expanded(
                    child: CustomElevatedButton(
                      text: "Delete",
                      onPressed: () {},
                      textSize: 15,
                      borderRadius: 10,
                      btnColor: AppColors.errorColor.withOpacity(0.5),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ).hPadding(0.05.width),
      ),
    );
  }
}
