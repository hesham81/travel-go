import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel_go/core/providers/reservation_provider.dart';
import 'package:travel_go/core/theme/app_colors.dart';

class MySelectedReservation extends StatelessWidget {
  const MySelectedReservation({super.key});

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<ReservationProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Reservations Details",
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: AppColors.whiteColor,
              ),
        ),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            Icons.arrow_back_ios,
            color: AppColors.whiteColor,
          ),
        ),
      ),
    );
  }
}
