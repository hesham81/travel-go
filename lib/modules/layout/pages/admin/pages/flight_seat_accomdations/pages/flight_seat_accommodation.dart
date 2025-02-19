import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:roundcheckbox/roundcheckbox.dart';
import 'package:travel_go/core/widget/custom_elevated_button.dart';
import 'package:travel_go/main.dart';
import '/core/extensions/align.dart';
import '/core/extensions/extensions.dart';
import '/core/theme/app_colors.dart';
import '/core/widget/label.dart';
import 'package:easy_stepper/easy_stepper.dart';
import '/core/widget/numbers_text_form_field.dart';

class FlightSeatAccommodation extends StatefulWidget {
  static const String routeName = "flight-seat-accommodation";

  const FlightSeatAccommodation({super.key});

  @override
  State<FlightSeatAccommodation> createState() =>
      _FlightSeatAccommodationState();
}

class _FlightSeatAccommodationState extends State<FlightSeatAccommodation> {
  int activeStep = 0;
  var economies = [
    "basic",
    "standard",
    "economy",
    "premium",
  ];
  TextEditingController noOfSeatsController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Flight Seats",
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              EasyStepper(
                lineStyle: LineStyle(
                  activeLineColor: AppColors.greyColor,
                  finishedLineColor: AppColors.trueColor,
                ),
                activeStepBackgroundColor:
                    AppColors.dodgurBlueColor.withOpacity(0.5),
                borderThickness: 1.1,
                activeStepBorderType: BorderType.dotted,
                disableScroll: true,
                padding: EdgeInsets.zero,
                stepRadius: 20,
                finishedStepIconColor: AppColors.trueColor,
                finishedStepTextColor: AppColors.trueColor,
                steps: [
                  EasyStep(
                    customTitle: Text(
                      'Basic',
                      style: theme.textTheme.titleMedium,
                    ).center,
                    icon: Icon(
                      Icons.airplane_ticket,
                      color: Colors.white,
                    ),
                    finishIcon: Icon(
                      Icons.done,
                      color: AppColors.trueColor,
                    ),
                    activeIcon: Icon(
                      Icons.airplane_ticket,
                      color: Colors.blue,
                    ),
                  ),
                  EasyStep(
                    customTitle: Text(
                      'Standard',
                      style: theme.textTheme.titleMedium,
                    ).center,
                    icon: Icon(Icons.event_seat, color: Colors.white),
                    finishIcon: Icon(
                      Icons.done,
                      color: AppColors.trueColor,
                    ),
                    activeIcon: Icon(Icons.event_seat, color: Colors.blue),
                  ),
                  EasyStep(
                    customTitle: Text(
                      'Economy',
                      style: theme.textTheme.titleMedium,
                    ).center,
                    icon: Icon(
                      Icons.airline_seat_legroom_extra,
                      color: Colors.white,
                    ),
                    finishIcon: Icon(
                      Icons.done,
                      color: AppColors.trueColor,
                    ),
                    activeIcon: Icon(
                      Icons.airline_seat_legroom_extra,
                      color: Colors.blue,
                    ),
                  ),
                  EasyStep(
                    customTitle: Text(
                      'Premium',
                      style: theme.textTheme.titleMedium,
                    ).center,
                    icon: Icon(
                      Icons.king_bed,
                      color: Colors.white,
                    ),
                    finishIcon: Icon(
                      Icons.done,
                      color: AppColors.trueColor,
                    ),
                    activeIcon: Icon(
                      Icons.king_bed,
                      color: Colors.blue,
                    ),
                  ),
                ],
                onStepReached: (index) {
                  index = activeStep;
                  setState(
                    () {},
                  );
                },
                activeStep: activeStep,
              ).hPadding(
                0.03.width,
              ),
              0.01.height.hSpace,
              Label(
                text: "Number Of Seats",
                style: theme.textTheme.titleMedium,
              ),
              0.01.height.hSpace,
              NumbersTextFormField(
                hintText: "Number Of Seats",
                validation: (_) => noOfSeatsController.text == ""
                    ? "Please Enter Number Of Seats"
                    : null,
                controller: noOfSeatsController,
                suffixIcon: Icons.chair_alt_sharp,
              ),
              0.01.height.hSpace,
              Label(
                text: "Price Of Seat",
                style: theme.textTheme.titleMedium,
              ),
              0.01.height.hSpace,
              NumbersTextFormField(
                hintText: "Price",
                validation: (_) => noOfSeatsController.text.isEmpty
                    ? "Please Enter Number Price"
                    : null,
                controller: noOfSeatsController,
                suffixIcon: Icons.monetization_on_outlined,
              ),
              0.01.height.hSpace,
              Label(
                text: "Amenities",
                style: theme.textTheme.titleMedium,
              ),
              0.01.height.hSpace,
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          RoundCheckBox(
                            onTap: (p0) {},
                            size: 25,
                          ),
                          0.01.width.vSpace,
                          Text(
                            "BreakFast",
                            style: theme.textTheme.titleMedium,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          RoundCheckBox(
                            onTap: (p0) {},
                            size: 25,
                          ),
                          0.01.width.vSpace,
                          Text(
                            "Dinner",
                            style: theme.textTheme.titleMedium,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          RoundCheckBox(
                            onTap: (p0) {},
                            size: 25,
                          ),
                          0.01.width.vSpace,
                          Text(
                            "Drinks",
                            style: theme.textTheme.titleMedium,
                          ),
                        ],
                      ),
                    ],
                  ),
                  0.01.height.hSpace,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          RoundCheckBox(
                            onTap: (p0) {},
                            size: 25,
                          ),
                          0.01.width.vSpace,
                          Text(
                            "Bag",
                            style: theme.textTheme.titleMedium,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          RoundCheckBox(
                            onTap: (p0) {},
                            size: 25,
                          ),
                          0.01.width.vSpace,
                          Text(
                            "noiseless head phone",
                            style: theme.textTheme.titleMedium,
                          ),
                        ],
                      ),
                    ],
                  ),
                  0.01.height.hSpace,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          RoundCheckBox(
                            onTap: (p0) {},
                            size: 25,
                          ),
                          0.01.width.vSpace,
                          Text(
                            "Wifi",
                            style: theme.textTheme.titleMedium,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          RoundCheckBox(
                            onTap: (p0) {},
                            size: 25,
                          ),
                          0.01.width.vSpace,
                          Text(
                            "leg room",
                            style: theme.textTheme.titleMedium,
                          ),
                        ],
                      ),
                      0.01.width.vSpace,
                      Row(
                        children: [
                          RoundCheckBox(
                            onTap: (p0) {},
                            size: 25,
                          ),
                          0.01.width.vSpace,
                          Text(
                            "Snacks",
                            style: theme.textTheme.titleMedium,
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              0.01.height.hSpace,
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  CustomElevatedButton(
                    text:
                        activeStep != economies.length - 1 ? "Next" : "Finish",
                    textSize: 15,
                    borderRadius: 10,
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        if (activeStep == economies.length - 1) {
                          EasyLoading.showSuccess("Done");
                          Navigator.pop(context);
                        } else {
                          activeStep++;
                          setState(() {});
                        }
                      }
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ).hPadding(
        0.03.width,
      ),
    );
  }
}
