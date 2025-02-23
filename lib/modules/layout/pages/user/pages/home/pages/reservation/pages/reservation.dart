import 'package:flutter/material.dart';
import 'package:travel_go/core/extensions/dimensions.dart';
import 'package:travel_go/core/extensions/extensions.dart';
import 'package:travel_go/models/trip_model.dart';
import '/core/theme/app_colors.dart';
import '/modules/layout/pages/user/widget/app_bar.dart';

class ReservationScreen extends StatelessWidget {
  static const String routeName = '/reservation';

  const ReservationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var model = ModalRoute.of(context)!.settings.arguments as TripModel;
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              AppBarWidget(),
              0.02.height.hSpace,
            ],
          ),
        ),
      ),
    );
  }
}
