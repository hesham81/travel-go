import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';
import 'package:travel_go/core/extensions/align.dart';
import 'package:travel_go/core/extensions/dimensions.dart';
import 'package:travel_go/core/extensions/extensions.dart';

import '../../../../../../../../../../../core/providers/reservation_provider.dart';
import '../../../../../../../../../../../core/theme/app_colors.dart';

class GuestsNumberSelector extends StatefulWidget {
  const GuestsNumberSelector({super.key});

  @override
  State<GuestsNumberSelector> createState() => _GuestsNumberSelectorState();
}

class _GuestsNumberSelectorState extends State<GuestsNumberSelector> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<ReservationProvider>(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          onPressed: (provider.getTotalHotelGuests == 1)
              ? () {}
              : () => setState(() {
                    provider.removeGuestsOnHotelReservation();
                  }),
          style: IconButton.styleFrom(
            backgroundColor: AppColors.newBlueColor.withOpacity(0.25),
          ),
          icon: Icon(
            Ionicons.remove,
            color: AppColors.whiteColor,
          ).center,
        ),
        0.01.width.vSpace,
        Text(
          provider.getTotalHotelGuests.toString(),
          style: Theme.of(context).textTheme.labelLarge!.copyWith(
                color: AppColors.blackColor,
              ),
        ),
        0.01.width.vSpace,
        IconButton(
          onPressed: () => setState(() {
            int guests = provider.getTotalHotelGuests;
            provider.addGuestsOnHotelReservation();
          }),
          style: IconButton.styleFrom(
            backgroundColor: AppColors.newBlueColor,
          ),
          icon: Icon(
            Ionicons.add_sharp,
            color: AppColors.whiteColor,
          ).center,
        ),
      ],
    );
  }
}
