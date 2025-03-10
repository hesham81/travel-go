import 'package:flutter/material.dart';
import 'package:travel_go/modules/layout/pages/user/widget/app_bar.dart';

class FlightAccomdationsReservations extends StatelessWidget {
  const FlightAccomdationsReservations({super.key});

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
