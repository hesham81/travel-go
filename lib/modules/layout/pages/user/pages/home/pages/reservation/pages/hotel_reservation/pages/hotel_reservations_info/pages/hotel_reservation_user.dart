import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';
import 'package:route_transitions/route_transitions.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:travel_go/core/utils/hotel_favourites_collections.dart';
import '/modules/layout/pages/user/pages/home/pages/reservation/pages/confirm_reservations/pages/confirm_user_reservations.dart';
import '/modules/layout/pages/user/pages/home/pages/reservation/pages/hotel_reservation/pages/confirm_hotel_reservation/pages/confirm_hotel_reservations.dart';
import '/core/utils/hotels_db.dart';
import '/models/hotel_model.dart';
import '/models/trip_data_model.dart';
import '../../../../../../../../../../admin/menna/trippp/utils/trips_collections.dart';
import '../../../../../../../../../../admin/pages/trip_departures/data/model/trip_departure_data_model.dart';
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
  Hotel? hotel;

  bool isLoading = true;
  TripDataModel? trip;

  Future<void> _getCurrentTrip() async {}

  Future<void> initData() async {
    TripDepartureDataModel tripDepartureDataModel =
        Provider.of<ReservationProvider>(context, listen: false)
            .getSelectedDeparture!;
    trip = await TripCollections.getTrip(tripDepartureDataModel.tripId);
    var provider = Provider.of<ReservationProvider>(context, listen: false);
    hotel = await HotelsDB.getHotelById(
      hotelId: trip!.hotelId,
    );
    roomImages.clear();
    for (var image in hotel!.accomdations) {
      for (var im in image.imagesUrls) {
        roomImages.add(im);
      }
    }
    isLiked = await HotelFavouritesCollections.checkIfFound(hotelId: hotel!.id);

    isLoading = false;
    setState(() {});
  }

  @override
  void initState() {
    Future.wait([
      _getCurrentTrip(),
      initData(),
    ]);
    super.initState();
  }

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
  bool isLiked = false;

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
  List<String> roomImages = [];

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
      body: Skeletonizer(
        enabled: isLoading,
        child: SingleChildScrollView(
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
                      imageUrl: hotel?.imageUrl ?? "",
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
                          onPressed: () async {
                            await HotelFavouritesCollections.addHotel(
                                hotel?.id ?? "");
                            setState(() {
                              isLiked = !isLiked;
                            });
                          },
                          style: IconButton.styleFrom(
                            backgroundColor: AppColors.whiteColor,
                          ),
                          icon: Icon(
                            (isLiked) ? Icons.bookmark : Icons.bookmark_outline,
                            color: AppColors.newBlueColor,
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
                                hotel?.hotelRating.toString() ?? "",
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
                    hotel?.hotelName ?? "",
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
                        hotel?.hotelLocation ?? "",
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
                        "${provider.calculateDistanceFromLocation(
                              LatLng(
                                hotel?.lat ?? 0,
                                hotel?.long ?? 0,
                              ),
                            ) ?? 100} KM",
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
                          "Experience ultimate comfort at ${hotel?.hotelName}, a ${hotel?.hotelRating.round()}-star retreat with elegant suites, fine dining, and a rooftop pool. Enjoy world-class service and breathtaking views. Perfect for business and leisure travelers.",
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
                      child: CarouselSlider(
                        items: roomImages
                            .map(
                              (item) => Builder(
                                builder: (context) => LoadingImageNetworkWidget(
                                  imageUrl: item,
                                  height: 0.7.height,
                                ),
                              ),
                            )
                            .toList(),
                        options: CarouselOptions(
                          height: 0.7.height,
                          aspectRatio: 16 / 9,
                          viewportFraction: 0.8,
                          initialPage: 0,
                          enableInfiniteScroll: true,
                          reverse: false,
                          autoPlay: true,
                          autoPlayInterval: Duration(seconds: 3),
                          autoPlayAnimationDuration:
                              Duration(milliseconds: 800),
                          autoPlayCurve: Curves.fastOutSlowIn,
                          enlargeCenterPage: true,
                          enlargeFactor: 0.3,
                          scrollDirection: Axis.horizontal,
                        ),
                      ),
                    ),
                  ),
                  0.05.height.hSpace,
                  Row(
                    children: [
                      Expanded(
                        child: CustomElevatedButton(
                          text: "Confirm",
                          onPressed: () {
                            provider.setReserveHotel(true);
                            slideLeftWidget(
                              newPage: ConfirmHotelReservations(
                                hotel: hotel!,
                              ),
                              context: context,
                            );
                          },
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
      ),
    );
  }
}
