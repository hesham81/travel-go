import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';
import 'package:travel_go/core/extensions/align.dart';
import 'package:travel_go/core/extensions/extensions.dart';
import 'package:travel_go/core/providers/reservation_provider.dart';
import 'package:travel_go/core/theme/app_colors.dart';
import 'package:travel_go/core/widget/custom_elevated_button.dart';
import 'package:travel_go/core/widget/loading_image_network_widget.dart';
import 'package:travel_go/models/hotel_model.dart';
import 'package:travel_go/modules/layout/pages/user/pages/home/pages/hotel_home/page/hotel_reservation/widget/icon_row.dart';
import 'package:travel_go/modules/layout/pages/user/widget/app_bar.dart';

class ConfirmHotelReservations extends StatefulWidget {
  final Hotel hotel;
  final int indexOfAccomdation;

  final List<DateTime?> range;
  final double totalPrice;

  const ConfirmHotelReservations({
    super.key,
    required this.hotel,
    required this.indexOfAccomdation,
    required this.range,
    required this.totalPrice,
  });

  @override
  State<ConfirmHotelReservations> createState() =>
      _ConfirmHotelReservationsState();
}

class _ConfirmHotelReservationsState extends State<ConfirmHotelReservations> {
  final List<String> _months = [
    "Jan",
    "Feb",
    "Mar",
    "Apr",
    "May",
    "Jun",
    "Jul",
    "Aug",
    "Sep",
    "Oct",
    "Nov",
    "Dec"
  ];

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<ReservationProvider>(context);
    String month = _months[widget.range.last!.month - 1];
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SafeArea(child: AppBarWidget()),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: Icon(
                    Icons.arrow_back_ios,
                    color: AppColors.blackColor,
                  ),
                ),
                0.01.height.hSpace,
                Text(
                  "Checkout",
                  style: Theme.of(context).textTheme.labelLarge!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                0.01.height.hSpace,
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.more_vert,
                  ),
                ),
              ],
            ),
            0.03.height.hSpace,
            Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 0.13.height,
                      width: 0.3.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        image: DecorationImage(
                          image: NetworkImage(
                            widget.hotel.imageUrl,
                          ),
                        ),
                      ),
                    ),
                    0.03.width.vSpace,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          widget.hotel.hotelName,
                          style:
                              Theme.of(context).textTheme.labelLarge!.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                        0.01.height.hSpace,
                        IconRow(
                          icon: Icon(
                            Icons.location_on_rounded,
                            color: AppColors.blackColor.withOpacity(0.4),
                          ),
                          text: Text(
                            widget.hotel.hotelLocation,
                            style: Theme.of(context)
                                .textTheme
                                .labelMedium!
                                .copyWith(
                                  color: AppColors.blackColor.withOpacity(0.4),
                                ),
                          ),
                        ),
                        0.02.height.hSpace,
                        IconRow(
                          icon: Icon(
                            Icons.monetization_on_outlined,
                          ),
                          text: Text(
                            "${widget.totalPrice} EGP",
                            style: Theme.of(context)
                                .textTheme
                                .labelMedium!
                                .copyWith(
                                  color: AppColors.blackColor,
                                ),
                          ),
                        )
                      ],
                    )
                  ],
                ).hPadding(0.02.width),
                0.02.height.hSpace,
                0.01.height.hSpace,
                Container(
                  width: double.maxFinite,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(
                      color: AppColors.greyColor,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Your Booking",
                        style: Theme.of(context).textTheme.labelLarge!.copyWith(
                              color: AppColors.newBlueColor,
                            ),
                      ),
                      0.02.height.hSpace,
                      Row(
                        children: [
                          IconRow(
                            icon: Icon(
                              Icons.calendar_today_outlined,
                            ),
                            text: Text(
                              "Dates",
                              style: Theme.of(context).textTheme.labelMedium!,
                            ),
                          ),
                          Spacer(),
                          Text(
                            "${widget.range.first?.day ?? 0}-${widget.range.last?.day ?? 0} $month ${widget.range.first?.year ?? 0}",
                            style: Theme.of(context).textTheme.labelMedium,
                          ),
                        ],
                      ),
                      0.02.height.hSpace,
                      Row(
                        children: [
                          IconRow(
                            icon: Icon(
                              Ionicons.person_outline,
                            ),
                            text: Text(
                              "Guests",
                              style: Theme.of(context).textTheme.labelMedium!,
                            ),
                          ),
                          Spacer(),
                          Text(
                            "${provider.getTotalHotelGuests} Guests",
                            style: Theme.of(context).textTheme.labelMedium,
                          ),
                        ],
                      ),
                      0.02.height.hSpace,
                      Row(
                        children: [
                          IconRow(
                            icon: Icon(Icons.hotel_outlined),
                            text: Text(
                              "Room Type",
                              style: Theme.of(context).textTheme.labelMedium!,
                            ),
                          ),
                          Spacer(),
                          Text(
                            widget.hotel.accomdations[widget.indexOfAccomdation]
                                .roomType,
                            style: Theme.of(context).textTheme.labelMedium,
                          ),
                        ],
                      ),
                      0.05.height.hSpace,
                      SvgPicture.asset(
                        'assets/images/dot_line.svg',
                      ).center,
                      0.01.height.hSpace,
                      Text(
                        "Price ",
                        style: Theme.of(context).textTheme.labelLarge!.copyWith(
                              color: AppColors.newBlueColor,
                            ),
                      ),
                      0.02.height.hSpace,
                      Row(
                        children: [
                          IconRow(
                            icon: Icon(
                              Icons.monetization_on_outlined,
                            ),
                            text: Text(
                              "Total Price",
                              style: Theme.of(context).textTheme.labelMedium!,
                            ),
                          ),
                          Spacer(),
                          Text(
                            "${widget.totalPrice} EGP",
                            style: Theme.of(context).textTheme.labelMedium,
                          ),
                        ],
                      ),
                    ],
                  ).allPadding(15),
                ),
                0.02.height.hSpace,
                CustomElevatedButton(
                  text: "Confirm",
                  onPressed: () {},
                ),
              ],
            ).hPadding(0.03.width),
          ],
        ),
      ),
    );
  }
}
