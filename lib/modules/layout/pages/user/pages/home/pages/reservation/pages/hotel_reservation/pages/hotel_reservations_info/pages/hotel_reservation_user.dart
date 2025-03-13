import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:route_transitions/route_transitions.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:travel_go/modules/layout/pages/user/pages/home/pages/reservation/pages/confirm_reservations/pages/confirm_user_reservations.dart';
import '/core/widget/custom_elevated_button.dart';
import '/modules/layout/pages/user/pages/home/pages/reservation/pages/hotel_reservation/widget/hotel_accomdations_widget.dart';
import '/core/extensions/align.dart';
import '/core/extensions/extensions.dart';
import '/core/theme/app_colors.dart';
import '/core/providers/reservation_provider.dart';
import '/core/widget/loading_image_network_widget.dart';

class HotelReservationUser extends StatefulWidget {
  const HotelReservationUser({super.key});

  @override
  State<HotelReservationUser> createState() => _HotelReservationUserState();
}

class _HotelReservationUserState extends State<HotelReservationUser> {
  List<IconData> icons = [
    Icons.wifi,
    Icons.pool,
    Icons.restaurant,
    Icons.local_bar,
    Icons.local_parking,
    Icons.local_cafe,
    Icons.spa,
    Icons.sports_gymnastics,
  ];

  List<String> titles = [
    "Wifi",
    "Pool",
    "Restaurant",
    "Bar",
    "Parking",
    "Cafe",
    "Spa",
    "Gym",
  ];
  List<String> roomImages = [
    "https://i.pinimg.com/736x/c3/4c/46/c34c464c7e68026d9ed9d219dd45b14f.jpg",
    "https://i.pinimg.com/736x/8e/b1/be/8eb1be5d9cdec424e2bdcbf0c6ab22a7.jpg",
    "https://i.pinimg.com/474x/23/ea/3b/23ea3be03555947e77560a9976be0502.jpg",
    "https://i.pinimg.com/736x/88/2a/da/882adad9d9935f53fc2d4f5448ddad93.jpg",
    "https://i.pinimg.com/474x/53/2d/f7/532df7cee694f03868af1cec05fabd0c.jpg",
    "https://i.pinimg.com/474x/09/22/3b/09223bade133549d8869878b9d8a1807.jpg",
    "https://i.pinimg.com/474x/b3/a5/7e/b3a57e79c57ba36dfa73856b116e19d1.jpg",
    "https://i.pinimg.com/474x/75/ab/e4/75abe4cf88463917085fa6654084e029.jpg",
    "https://i.pinimg.com/474x/95/7e/12/957e12164563f3a887e7b5bb9f370d06.jpg",
    "https://i.pinimg.com/474x/c1/02/77/c102772f2deb7e41c9b8252c077773f7.jpg",
    "https://i.pinimg.com/474x/c9/30/27/c9302794f138bbd7fabc6066fce54331.jpg",
  ];

  PageController pageController = PageController();
  int index = 0;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).textTheme;
    var provider = Provider.of<ReservationProvider>(context);
    return Scaffold(
      bottomNavigationBar: Container(
        height: 0.1.height,
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(1),
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Row(
          children: [
            Text(
              "You Don't Need Hotel ? ",
              style: theme.labelLarge!.copyWith(
                color: AppColors.newBlueColor,
              ),
            ),
            0.01.width.vSpace,
            Expanded(
              child: CustomElevatedButton(
                text: "Skip Now",
                onPressed: () => slideLeftWidget(
                  newPage: ConfirmUserReservations(),
                  context: context,
                ),
              ),
            ),
          ],
        ).hPadding(0.03.width),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                  child: LoadingImageNetworkWidget(
                    imageUrl:
                        "https://i.pinimg.com/474x/4d/69/0c/4d690cffa41358ec253ccfb5b5ab4b02.jpg",
                  ),
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
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        onPressed: () {},
                        style: IconButton.styleFrom(
                          backgroundColor: AppColors.whiteColor,
                        ),
                        icon: Icon(
                          Icons.bookmark_outline,
                        ),
                      ),
                      0.01.width.vSpace,
                      CircleAvatar(
                        backgroundColor: AppColors.whiteColor,
                        child: Column(
                          children: [
                            Icon(
                              Icons.star,
                              color: Colors.yellow,
                            ),
                            Text(
                              provider
                                  .getSelectedDeparture!.trip.hotel.hotelRating
                                  .toString(),
                              style: theme.labelSmall!.copyWith(
                                color: AppColors.blackColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
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
                0.01.height.hSpace,
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
                0.01.height.hSpace,
                Row(
                  children: [
                    Icon(
                      Icons.location_history,
                      color: AppColors.blackColor.withAlpha(110),
                    ),
                    0.02.width.vSpace,
                    Text(
                      "${provider.calculateDistanceFromLocation()} KM",
                      style: theme.titleSmall!.copyWith(
                        color: AppColors.blackColor.withAlpha(110),
                      ),
                    )
                  ],
                ),
                0.01.height.hSpace,
                Divider().hPadding(0.1.width),
                Text(
                  "Facility Place",
                  style: theme.titleMedium!
                      .copyWith(color: AppColors.newBlueColor),
                ),
                0.01.height.hSpace,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    HotelAccomdationsWidget(
                      icon: icons.first,
                      title: titles.first,
                    ),
                    HotelAccomdationsWidget(
                      icon: icons[1],
                      title: titles[1],
                    ),
                    HotelAccomdationsWidget(
                      icon: icons[3],
                      title: titles[3],
                    ),
                    HotelAccomdationsWidget(
                      icon: icons[4],
                      title: titles[4],
                    ),
                  ],
                ),
                0.01.height.hSpace,
                Divider().hPadding(0.1.width),
                Text(
                  "Description",
                  style: theme.titleMedium!.copyWith(
                    color: AppColors.newBlueColor,
                  ),
                ),
                0.01.height.hSpace,
                RichText(
                  text: TextSpan(
                    text:
                        "Experience ultimate comfort at ${provider.getSelectedDeparture!.trip.hotel.hotelName}, a ${provider.getSelectedDeparture!.trip.hotel.hotelRating.round()}-star retreat with elegant suites, fine dining, and a rooftop pool. Enjoy world-class service and breathtaking views. Perfect for business and leisure travelers.",
                    style: theme.titleMedium!.copyWith(
                      color: AppColors.blackColor,
                    ),
                  ),
                ),
                0.01.height.hSpace,
                Divider().hPadding(0.1.width),
                Text(
                  "Gallery",
                  style: theme.titleMedium!.copyWith(
                    color: AppColors.newBlueColor,
                  ),
                ),
                0.01.height.hSpace,
                SizedBox(
                  height: 0.3.height,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: PageView(
                      controller: pageController,
                      onPageChanged: (value) {
                        index = value;
                        setState(() {});
                      },
                      children: [
                        for (int i = 0; i < roomImages.length; i++)
                          LoadingImageNetworkWidget(
                            imageUrl: roomImages[i],
                          ),
                      ],
                    ),
                  ),
                ),
                0.01.height.hSpace,
                SmoothPageIndicator(
                  controller: pageController,
                  count: roomImages.length,
                  axisDirection: Axis.horizontal,
                  effect: WormEffect(
                    activeDotColor: AppColors.newBlueColor,
                    dotWidth: 10,
                    dotHeight: 10,
                  ),
                ).center,
                0.02.height.hSpace,
                Row(
                  children: [
                    Expanded(
                      child: CustomElevatedButton(
                        text: "Confirm",
                        onPressed: () {},
                      ),
                    ),
                    0.01.width.vSpace,
                    Expanded(
                      child: CustomElevatedButton(
                        text: "Cancel",
                        onPressed: () => Navigator.pop(context),
                        btnColor: AppColors.errorColor,
                      ),
                    ),
                  ],
                ),
                0.03.height.hSpace,
              ],
            ).hPadding(0.03.width),
            0.01.height.hSpace,
          ],
        ),
      ),
    );
  }
}
