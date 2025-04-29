import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:travel_go/core/utils/firebase_auth_services.dart';
import 'package:travel_go/models/flight_airlines.dart';
import 'package:travel_go/modules/layout/pages/admin/menna/trippp/utils/trips_collections.dart';
import 'package:travel_go/modules/layout/pages/user/pages/home/pages/trip/pages/selected_trip/pages/trip_info/pages/trip_info.dart';
import 'package:travel_go/modules/layout/pages/user/pages/home/pages/trip/pages/selected_trip/pages/user_trip_flight/pages/user_trip_flight.dart';
import 'package:travel_go/modules/layout/pages/user/pages/home/pages/trip/pages/selected_trip/pages/user_trip_hotel/pages/user_trip_hotel.dart';
import 'package:travel_go/modules/layout/pages/user/pages/home/pages/trip/pages/selected_trip/pages/user_trip_reviews/pages/user_trip_reviews.dart';
import '../../../../../../../../../../../core/utils/flight_collections.dart';
import '../../../../../../../../../../../core/utils/hotels_db.dart';
import '../../../../../../../../../../../models/flight.dart';
import '../../../../../../../../../../../models/hotel_model.dart';
import '/modules/layout/pages/user/pages/home/pages/trip/pages/selected_trip/pages/trip_program/pages/trip_program_home.dart';
import '/core/extensions/align.dart';
import '/core/extensions/extensions.dart';
import '/core/providers/collections_provider.dart';
import '/core/theme/app_colors.dart';
import '/core/widget/custom_text_button.dart';
import '/core/widget/loading_image_network_widget.dart';
import '/models/trip_data_model.dart';
import '/modules/layout/pages/user/pages/home/pages/trip/pages/selected_trip/pages/utilities_trip.dart';
import '/modules/layout/pages/user/widget/app_bar.dart';

class SelectedHomeScreenTrip extends StatefulWidget {
  final TripDataModel model;

  const SelectedHomeScreenTrip({
    super.key,
    required this.model,
  });

  @override
  State<SelectedHomeScreenTrip> createState() => _SelectedHomeScreenTripState();
}

class _SelectedHomeScreenTripState extends State<SelectedHomeScreenTrip> {
  Hotel? hotel;

  Flight? flight;

  bool isLoading = true;

  Future<void> initData() async {
    hotel = await HotelsDB.getHotelById(
      hotelId: widget.model.hotelId,
    );

    flight = (await FlightCollections.getFlightById(
      flightId: widget.model.flightId,
    ))!;

    isLoading = false;
    setState(() {});
  }

  List<String> buttonsItems = [
    "Utilities",
    "Program",
    "Hotel",
    "Flight",
    "Reviews",
    "Info",
  ];

  int selectedIndex = 0;
  int totalPlaces = 0;

  _calcTotalPlaces() {
    widget.model.programDetails.forEach((e) {
      totalPlaces += e.attractions.length;
    });
    setState(() {});
  }

  List<TripDataModel> favouriteTrips = [];
  bool isFavourite = false;

  _getAllFavouriteTrips() {
    User? user = FirebaseAuthServices.getCurrentUserData();
    if (widget.model.favourites!.isNotEmpty) {
      for (String id in widget.model.favourites!) {
        if (id == user!.uid) {
          isFavourite = true;
          setState(() {});
        }
      }
    }
  }

  @override
  void initState() {
    _getAllFavouriteTrips();
    _calcTotalPlaces();
    Future.wait([
      initData(),
    ]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> body = [
      UtilitiesTrip(
        model: widget.model,
        totalPlaces: totalPlaces,
      ),
      TripProgramHome(
        model: widget.model,
      ),
      UserTripHotel(
        model: widget.model,
      ),
      UserTripFlight(
        model: flight ??
            Flight(
              flightId: "flightId",
              flightName: "flightName",
              airline: FlightAirlines(
                flighAirLineName: "flighAirLineName",
                flightAirLineImageUrl: "flightAirLineImageUrl",
              ),
              seats: [],
            ),
        trip: widget.model,
      ),
      UserTripReviews(),
      TripInfo(
        model: widget.model,
      ),
    ];
    var theme = Theme.of(context).textTheme;
    return Scaffold(
      body: SingleChildScrollView(
        child: Skeletonizer(
          enabled: isLoading,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SafeArea(
                child: AppBarWidget(),
              ),
              SizedBox(
                height: 0.4.height,
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(25),
                      child: LoadingImageNetworkWidget(
                        imageUrl: widget.model.imageUrl!,
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          widget.model.destination,
                          style: theme.titleMedium!.copyWith(
                            color: AppColors.whiteColor,
                          ),
                        ),
                        Spacer(),
                        IconButton(
                          onPressed: () async {
                            EasyLoading.show();
                            if (isFavourite) {
                              int index = widget.model.favourites!.indexOf(
                                  FirebaseAuthServices.getCurrentUserData()!
                                      .uid);
                              widget.model.favourites!.removeAt(index);

                              await TripCollections.updateTrip(
                                  widget.model);
                              isFavourite = false;
                            } else {
                              widget.model.favourites!.add(
                                  FirebaseAuthServices.getCurrentUserData()!
                                      .uid);
                              await TripCollections.updateTrip(
                                  widget.model);
                              isFavourite = true;
                            }
                            EasyLoading.dismiss();
                            setState(() {});
                          },
                          style: IconButton.styleFrom(
                            backgroundColor: AppColors.whiteColor,
                            padding: EdgeInsets.zero,
                          ),
                          icon: (isFavourite)
                              ? Icon(
                                  Icons.bookmark,
                                  color: AppColors.newBlueColor,
                                )
                              : Icon(
                                  Icons.bookmark_border,
                                  color: AppColors.newBlueColor,
                                ),
                        ),
                        0.01.height.hSpace,
                      ],
                    ).alignBottom().hPadding(0.02.width).vPadding(0.01.height),
                    BackButton(
                      style: ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(
                          AppColors.whiteColor,
                        ),
                      ),
                    ).allPadding(5)
                  ],
                ),
              ),
              0.015.height.hSpace,
              SizedBox(
                height: 0.04.height,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) => CustomTextButton(
                    onPressed: () {
                      selectedIndex = index;
                      setState(() {});
                    },
                    text: buttonsItems[index],
                    textSize: 13,
                    textColor: (selectedIndex == index)
                        ? AppColors.blackColor
                        : AppColors.newBlueColor,
                  ),
                  separatorBuilder: (context, index) => 0.08.width.vSpace,
                  itemCount: buttonsItems.length,
                ),
              ),
              body[selectedIndex],
            ],
          ).hPadding(0.03.width),
        ),
      ),
    );
  }
}
