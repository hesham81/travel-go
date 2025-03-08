import 'package:flutter/material.dart';
import 'package:travel_go/models/trip_data_model.dart';
import 'package:travel_go/modules/layout/pages/user/widget/app_bar.dart';

class Reservation extends StatelessWidget {
  final TripDataModel model;

  const Reservation({
    super.key,
    required this.model,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SafeArea(
              child: AppBarWidget(),
            ),

          ],
        ),
      ),
    );
  }
}
