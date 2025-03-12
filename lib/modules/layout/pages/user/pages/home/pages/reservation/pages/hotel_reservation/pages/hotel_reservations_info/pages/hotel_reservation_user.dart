import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/core/extensions/align.dart';
import '/core/extensions/extensions.dart';
import '/core/theme/app_colors.dart';
import '/core/providers/reservation_provider.dart';
import '/core/widget/loading_image_network_widget.dart';

class HotelReservationUser extends StatelessWidget {
  const HotelReservationUser({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).textTheme;
    var provider = Provider.of<ReservationProvider>(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                LoadingImageNetworkWidget(
                  imageUrl:
                      "https://i.pinimg.com/474x/4d/69/0c/4d690cffa41358ec253ccfb5b5ab4b02.jpg",
                ),
                SafeArea(
                  child: BackButton(
                    style: ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(
                        AppColors.whiteColor,
                      ),
                    ),
                  ).allPadding(5),
                ),
                SafeArea(
                  child: IconButton(
                    onPressed: () {},
                    style: IconButton.styleFrom(
                      backgroundColor: AppColors.whiteColor,
                    ),
                    icon: Icon(
                      Icons.favorite_outline,
                    ),
                  ).alignTopRight(),
                ).allPadding(5),
              ],
            ),
            0.01.height.hSpace,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  provider.getSelectedDeparture!.trip.hotel.hotelName,
                  style: theme.titleMedium!.copyWith(
                    color: AppColors.blackColor,
                  ),
                ),
                Row(
                  children: [
                    Icon(
                      Icons.location_on_outlined,
                      color: AppColors.blackColor.withAlpha(110),
                    ),
                    0.01.width.vSpace,
                    Text(
                      "2 Rue Scribe, 75009 Paris, France",
                      style: theme.titleSmall!.copyWith(
                        color: AppColors.blackColor.withAlpha(110),
                      ),
                    ),
                  ],
                ),
              ],
            ).hPadding(0.03.width),
            0.01.height.hSpace,
          ],
        ),
      ),
    );
  }
}
