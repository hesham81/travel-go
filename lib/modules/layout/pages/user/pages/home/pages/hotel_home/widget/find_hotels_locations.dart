import 'package:flutter/material.dart';
import 'package:route_transitions/route_transitions.dart';
import 'package:travel_go/core/extensions/dimensions.dart';
import 'package:travel_go/core/extensions/extensions.dart';
import 'package:travel_go/core/theme/app_colors.dart';
import 'package:travel_go/modules/layout/pages/admin/pages/hotels/pages/widgets/hotel_map.dart';
import 'package:travel_go/modules/layout/pages/user/pages/home/pages/hotel_home/widget/hotel_maps_locations.dart';

class FindHotelsLocations extends StatelessWidget {
  const FindHotelsLocations({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => slideLeftWidget(
        newPage: HotelMapsLocations(),
        context: context,
      ),
      child: Container(
        width: double.maxFinite,
        height: 0.08.height,
        decoration: BoxDecoration(
          color: AppColors.newBlueColor.withOpacity(0.15),
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: AppColors.whiteColor,
              child: Icon(
                Icons.location_on,
                color: AppColors.newBlueColor,
              ),
            ).allPadding(5),
            0.01.width.vSpace,
            Expanded(
              child: Text(
                "You Can Explore Hotels Location to show nearby Hotel",
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                      color: AppColors.blackColor,
                    ),
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
            )
          ],
        ).hPadding(0.02.width),
      ),
    );
  }
}
