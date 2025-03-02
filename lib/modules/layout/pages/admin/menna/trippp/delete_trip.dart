import 'package:flutter/material.dart';
import 'package:travel_go/core/constant/app_assets.dart';
import 'package:travel_go/core/theme/app_colors.dart';
import 'package:travel_go/modules/layout/pages/admin/menna/trippp/trip_admin_bug.dart';

class DeleteTrip extends StatelessWidget {
  const DeleteTrip({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Delete Trip",
          style: theme.titleLarge!.copyWith(
            color: AppColors.whiteColor,
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => NewTripScreen(),
                ),
              );
            },
            child: Image.asset(
              AppAssets.noAvailableImages,
            ),
          )
        ],
      ),
    );
  }
}
