import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:route_transitions/route_transitions.dart';
import 'package:travel_go/core/extensions/align.dart';
import 'package:travel_go/core/extensions/extensions.dart';
import 'package:travel_go/core/theme/app_colors.dart';
import 'package:travel_go/core/widget/custom_container.dart';
import 'package:travel_go/core/widget/custom_rating_widget.dart';
import 'package:travel_go/core/widget/labels_widget.dart';
import 'package:travel_go/core/widget/loading_image_network_widget.dart';
import 'package:travel_go/models/trip_data_model.dart';
import 'package:travel_go/modules/layout/pages/user/pages/home/pages/trip/pages/selected_trip/pages/user_trip_hotel/pages/room_prices.dart';

import '../../../../../../../../../../../../../core/providers/collections_provider.dart';
import '../../../../../../../../../../../../../core/utils/flight_collections.dart';
import '../../../../../../../../../../../../../core/utils/hotels_db.dart';
import '../../../../../../../../../../../../../models/flight.dart';
import '../../../../../../../../../../../../../models/hotel_model.dart';

class UserTripHotel extends StatefulWidget {
  final TripDataModel model;

  const UserTripHotel({
    super.key,
    required this.model,
  });

  @override
  State<UserTripHotel> createState() => _UserTripHotelState();
}

class _UserTripHotelState extends State<UserTripHotel> {
  late Hotel hotel;

  late Flight flight;

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

  @override
  void initState() {
    Future.wait([
      initData(),
    ]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).textTheme;
    return (isLoading)
        ? CircularProgressIndicator(
            color: AppColors.newBlueColor,
          ).center
        : Column(
            children: [
              LoadingImageNetworkWidget(
                imageUrl: hotel.imageUrl,
              ),
              0.02.height.hSpace,
              Container(
                width: double.maxFinite,
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.4),
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    LabelsWidget(
                      label: "Hotel Name : ",
                      value: hotel.hotelName,
                    ),
                    0.01.height.hSpace,
                    LabelsWidget(
                      label: "Location : ",
                      value: hotel.hotelLocation,
                    ),
                    0.01.height.hSpace,
                    LabelsWidget(
                      label: "Available Rooms : ",
                      value: "${hotel.availableRooms} Room",
                    ),
                    0.01.height.hSpace,
                    CustomRatingWidget(
                      minRating: hotel.hotelRating,
                    )
                  ],
                ),
              ),
              0.02.height.hSpace,
              GestureDetector(
                onTap: ()
                {
                  Provider.of<CollectionsProvider>(context, listen: false).setHotel(hotel);
                  slideLeftWidget(
                    newPage: RoomPrices(),
                    context: context,
                  );
                },
                child: CustomContainer(
                  child: Row(
                    children: [
                      Text(
                        "Room Prices",
                        style: theme.titleMedium!.copyWith(
                          color: AppColors.blackColor,
                        ),
                      ).alignTopLeft(),
                      Spacer(),
                      Icon(
                        Icons.arrow_forward_ios,
                        color: AppColors.newBlueColor,
                      )
                    ],
                  ),
                ),
              ),
              0.02.height.hSpace,
              Container(
                width: double.maxFinite,
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.4),
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Text(
                      "Amenities Included",
                      style: theme.titleMedium!.copyWith(
                        color: AppColors.blackColor,
                      ),
                    ).alignTopLeft(),
                    0.01.height.hSpace,
                    Row(
                      children: [
                        Icon(
                          Icons.check,
                          color: Colors.green,
                        ),
                        0.03.width.vSpace,
                        Text(
                          "Free Wifi",
                          style: theme.labelLarge!.copyWith(
                            color: AppColors.blackColor,
                          ),
                        ),
                      ],
                    ),
                    0.01.height.hSpace,
                    Row(
                      children: [
                        Icon(
                          Icons.check,
                          color: Colors.green,
                        ),
                        0.03.width.vSpace,
                        Text(
                          "Pool",
                          style: theme.labelLarge!.copyWith(
                            color: AppColors.blackColor,
                          ),
                        ),
                      ],
                    ),
                    0.01.height.hSpace,
                    Row(
                      children: [
                        Icon(
                          Icons.check,
                          color: Colors.green,
                        ),
                        0.03.width.vSpace,
                        Text(
                          "Free Cancellation",
                          style: theme.labelLarge!.copyWith(
                            color: AppColors.blackColor,
                          ),
                        ),
                      ],
                    ),
                    0.01.height.hSpace,
                    Row(
                      children: [
                        Icon(
                          Icons.check,
                          color: Colors.green,
                        ),
                        0.03.width.vSpace,
                        Text(
                          "BreakFast",
                          style: theme.labelLarge!.copyWith(
                            color: AppColors.blackColor,
                          ),
                        ),
                      ],
                    ),
                    0.01.height.hSpace,
                    Row(
                      children: [
                        Icon(
                          Icons.check,
                          color: Colors.green,
                        ),
                        0.03.width.vSpace,
                        Text(
                          "Restaurant",
                          style: theme.labelLarge!.copyWith(
                            color: AppColors.blackColor,
                          ),
                        ),
                      ],
                    ),
                    0.01.height.hSpace,
                    Row(
                      children: [
                        Icon(
                          Icons.check,
                          color: Colors.green,
                        ),
                        0.03.width.vSpace,
                        Text(
                          "Public Parking",
                          style: theme.labelLarge!.copyWith(
                            color: AppColors.blackColor,
                          ),
                        ),
                      ],
                    ),
                    0.01.height.hSpace,
                    Row(
                      children: [
                        Icon(
                          Icons.check,
                          color: Colors.green,
                        ),
                        0.03.width.vSpace,
                        Text(
                          "Air Conditioning",
                          style: theme.labelLarge!.copyWith(
                            color: AppColors.blackColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              0.02.height.hSpace,
            ],
          );
  }
}
