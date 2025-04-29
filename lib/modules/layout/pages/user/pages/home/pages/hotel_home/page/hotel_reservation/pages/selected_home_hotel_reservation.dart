import 'dart:developer';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:imageview360/imageview360.dart';

import 'package:ionicons/ionicons.dart';
import 'package:panorama/panorama.dart';
import 'package:provider/provider.dart';
import 'package:route_transitions/route_transitions.dart';
import 'package:travel_go/core/widget/custom_container.dart';
import 'package:travel_go/modules/layout/pages/user/pages/home/pages/hotel_home/page/hotel_reservation/pages/hotel_credit_card_payment.dart';
import '/core/extensions/extensions.dart';
import '/core/providers/reservation_provider.dart';
import '/core/theme/app_colors.dart';
import '/core/widget/custom_elevated_button.dart';
import '/models/hotel_model.dart';
import '/modules/layout/pages/user/pages/home/pages/hotel_home/page/hotel_reservation/widget/date_time_widget.dart';
import '/modules/layout/pages/user/pages/home/pages/hotel_home/page/hotel_reservation/widget/guests_number_selector.dart';
import '/modules/layout/pages/user/widget/app_bar.dart';
import 'cofirm_hotel_reservations.dart';

class SelectedHomeHotelReservation extends StatefulWidget {
  final Hotel? hotel;

  const SelectedHomeHotelReservation({
    super.key,
    required this.hotel,
  });

  @override
  State<SelectedHomeHotelReservation> createState() =>
      _SelectedHomeHotelReservationState();
}

class _SelectedHomeHotelReservationState
    extends State<SelectedHomeHotelReservation> {
  int selectedIndex = 0;
  List<DateTime?>? range = [];
  int days = 1;
  List<ImageProvider> imageList = [];

  _calcTotalValue(int totalGuests) {
    days = (range != null && range!.isNotEmpty)
        ? range!.last!.difference(range?.first ?? DateTime.now()).inDays
        : 1;
    days++;
    double pricePerNight =
        widget.hotel?.accomdations[selectedIndex].roomPrice ?? 0;
    double totalPrice = days * pricePerNight * (pricePerNight * 0.02);
    setState(() {});
    totalPrice += totalGuests * 100;
    return totalPrice;
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<ReservationProvider>(context);
    return Scaffold(
      bottomNavigationBar: CustomContainer(
        child: CustomElevatedButton(
          text: "Checkout",
          onPressed: (range == null || provider.getHotelCard == null)
              ? null
              : () => slideLeftWidget(
                  newPage: ConfirmHotelReservations(
                    hotel: widget.hotel!,
                    indexOfAccomdation: selectedIndex,
                    range: range!,
                    totalPrice: _calcTotalValue(provider.getTotalHotelGuests),
                  ),
                  context: context),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SafeArea(
              child: AppBarWidget(),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                      "Room Booking",
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
                0.01.height.hSpace,
                Text(
                  "Date",
                  style: Theme.of(context).textTheme.labelLarge,
                ),
                0.01.height.hSpace,
                GestureDetector(
                  onTap: () async {
                    range = (await showCalendarDatePicker2Dialog(
                      context: context,
                      config: CalendarDatePicker2WithActionButtonsConfig(
                        calendarType: CalendarDatePicker2Type.range,
                        selectedDayHighlightColor: AppColors.newBlueColor,
                        daySplashColor: AppColors.newBlueColor,
                        cancelButtonTextStyle:
                            Theme.of(context).textTheme.labelMedium,
                        selectableDayPredicate: (day) =>
                            day.isAfter(DateTime.now()),
                      ),
                      dialogSize: Size(
                        double.maxFinite,
                        0.5.height,
                      ),
                      value: range ?? [],
                    ));
                    setState(() {});
                  },
                  child: DateTimeWidget(
                    isCheckIn: true,
                    date: (range?.isNotEmpty ?? false && range != null)
                        ? "${range!.first!.day}/${range!.first!.month}/${range!.first!.year} - ${range!.last!.day}/${range!.last!.month}/${range!.last!.year}"
                        : null,
                  ),
                ),
                0.01.height.hSpace,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomElevatedButton(
                      text: "Single",
                      onPressed: () => setState(() {
                        selectedIndex = 0;
                      }),
                      btnColor: (selectedIndex == 0)
                          ? AppColors.newBlueColor
                          : AppColors.whiteColor,
                      textColor: (selectedIndex == 0)
                          ? AppColors.whiteColor
                          : AppColors.newBlueColor,
                      borderColor: AppColors.newBlueColor,
                      borderWidth: 2,
                    ),
                    CustomElevatedButton(
                      text: "Double",
                      onPressed: () => setState(() {
                        selectedIndex = 1;
                      }),
                      btnColor: (selectedIndex == 1)
                          ? AppColors.newBlueColor
                          : AppColors.whiteColor,
                      textColor: (selectedIndex == 1)
                          ? AppColors.whiteColor
                          : AppColors.newBlueColor,
                      borderColor: AppColors.newBlueColor,
                      borderWidth: 2,
                    ),
                    CustomElevatedButton(
                      text: "Suite",
                      onPressed: () => setState(() {
                        selectedIndex = 2;
                      }),
                      btnColor: (selectedIndex == 2)
                          ? AppColors.newBlueColor
                          : AppColors.whiteColor,
                      textColor: (selectedIndex == 2)
                          ? AppColors.whiteColor
                          : AppColors.newBlueColor,
                      borderColor: AppColors.newBlueColor,
                      borderWidth: 2,
                    ),
                  ],
                ),
                0.01.height.hSpace,
                Row(
                  children: [
                    Text(
                      "Guest",
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                    Spacer(),
                    GuestsNumberSelector(),
                  ],
                ),
                0.01.height.hSpace,
                Text(
                  "Pay With",
                  style: Theme.of(context).textTheme.labelLarge,
                ),
                0.01.height.hSpace,
                Container(
                  width: double.maxFinite,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: AppColors.blackColor.withOpacity(0.2),
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: AppColors.blackColor.withOpacity(0.3),
                        child: Icon(
                          Ionicons.wallet_outline,
                          color: AppColors.blackColor,
                        ),
                      ),
                      0.02.width.vSpace,
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Credit Card",
                            style: Theme.of(context)
                                .textTheme
                                .labelMedium!
                                .copyWith(
                                  color: AppColors.blackColor,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          0.01.width.vSpace,
                          Text(
                            (provider.getHotelCard == null)
                                ? ""
                                : "**** **** **** ${provider.getHotelCard!.creditNumber.substring(11, 15)}",
                            style: Theme.of(context)
                                .textTheme
                                .labelSmall!
                                .copyWith(
                                  color: AppColors.blackColor.withOpacity(0.5),
                                ),
                          ),
                        ],
                      ),
                      Spacer(),
                      CustomElevatedButton(
                        text: (provider.getHotelCard == null) ? "Add" : "Edit",
                        borderRadius: 25,
                        textSize: 12,
                        textColor: AppColors.newBlueColor,
                        onPressed: () => slideLeftWidget(
                          newPage: HotelCreditCardPayment(
                            totalBalance:
                                _calcTotalValue(provider.getTotalHotelGuests),
                          ),
                          context: context,
                        ),
                        borderColor: AppColors.newBlueColor,
                        borderWidth: 2,
                        btnColor: AppColors.whiteColor,
                      ),
                    ],
                  ).allPadding(10),
                ),
                0.01.height.hSpace,
                Text(
                  "Payment Details",
                  style: Theme.of(context).textTheme.labelLarge,
                ),
                0.01.height.hSpace,
                0.01.height.hSpace,
                Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          "Total",
                          style: Theme.of(context).textTheme.labelLarge,
                        ),
                        Spacer(),
                        Text(
                          "${_calcTotalValue(provider.getTotalHotelGuests) ?? 0} \$",
                          style: Theme.of(context).textTheme.labelLarge,
                        ),
                      ],
                    ),
                    0.01.height.hSpace,
                    Row(
                      children: [
                        Text(
                          "Room Type",
                          style: Theme.of(context).textTheme.labelLarge,
                        ),
                        Spacer(),
                        Text(
                          "${widget.hotel?.accomdations[selectedIndex].roomType}",
                          style: Theme.of(context).textTheme.labelLarge,
                        ),
                      ],
                    ),
                    0.01.height.hSpace,
                    Row(
                      children: [
                        Text(
                          "From",
                          style: Theme.of(context).textTheme.labelLarge,
                        ),
                        Spacer(),
                        Text(
                          (range?.isEmpty ?? true)
                              ? "Not Selected"
                              : "${range!.first!.day}/${range!.first!.month}/${range!.first!.year}",
                          style: Theme.of(context).textTheme.labelLarge,
                        ),
                      ],
                    ),
                    0.01.height.hSpace,
                    Row(
                      children: [
                        Text(
                          "To",
                          style: Theme.of(context).textTheme.labelLarge,
                        ),
                        Spacer(),
                        Text(
                          (range?.isEmpty ?? true)
                              ? "Not Selected"
                              : "${range!.last!.day}/${range!.last!.month}/${range!.last!.year}",
                          style: Theme.of(context).textTheme.labelLarge,
                        ),
                      ],
                    ),
                    0.01.height.hSpace,
                    Row(
                      children: [
                        Text(
                          "Total Days",
                          style: Theme.of(context).textTheme.labelLarge,
                        ),
                        Spacer(),
                        Text(
                          (range?.isEmpty ?? true)
                              ? "Not Selected Days"
                              : "$days Days",
                          style: Theme.of(context).textTheme.labelLarge,
                        ),
                      ],
                    ),
                  ],
                ),
                0.01.height.hSpace,
              ],
            ).hPadding(0.03.width)
          ],
        ),
      ),
    );
  }
}
