import 'package:easy_stepper/easy_stepper.dart';
import 'package:flutter/material.dart';
import 'package:travel_go/core/extensions/align.dart';

import '../../../../../../../core/theme/app_colors.dart';

class TitleEconomyWidget extends StatefulWidget {
  const TitleEconomyWidget({super.key});

  @override
  State<TitleEconomyWidget> createState() => _TitleEconomyWidgetState();
}

class _TitleEconomyWidgetState extends State<TitleEconomyWidget> {
  int activeStep = 0;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return EasyStepper(
      lineStyle: LineStyle(
        activeLineColor: AppColors.greyColor,
        finishedLineColor: AppColors.trueColor,
      ),
      activeStepBackgroundColor: AppColors.dodgurBlueColor.withOpacity(0.5),
      borderThickness: 1.1,
      activeStepBorderType: BorderType.dotted,
      disableScroll: true,
      padding: EdgeInsets.zero,
      stepRadius: 20,
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
    );
  }
}
