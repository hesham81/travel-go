import 'dart:developer';

import 'package:country_state_city_picker/country_state_city_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:travel_go/core/services/bot_toast.dart';
import 'package:travel_go/core/widget/numbers_text_form_field.dart';
import 'package:travel_go/modules/layout/pages/admin/pages/admin_home.dart';
import '/core/widget/loading_image_network_widget.dart';
import '/models/hotel_model.dart';
import '/core/extensions/align.dart';
import '/core/widget/custom_elevated_button.dart';
import '/core/widget/custom_rating_widget.dart';
import '/core/extensions/alignment.dart';
import '/core/extensions/extensions.dart';
import '/core/utils/hotels_db.dart';
import '/core/widget/custom_text_form_field.dart';
import '/core/widget/label.dart';
import '/core/theme/app_colors.dart';

class BottomNavSheet extends StatefulWidget {
  final Hotel hotel;

  const BottomNavSheet({
    super.key,
    required this.hotel,
  });

  @override
  State<BottomNavSheet> createState() => _BottomNavSheetState();
}

class _BottomNavSheetState extends State<BottomNavSheet> {
  String countryValue = "";
  String stateValue = "";
  String cityValue = "";
  final hotelNameController = TextEditingController();
  final hotelLocationController = TextEditingController();
  final totalRoomsController = TextEditingController();
  double hotelRating = 0;

  final formKey = GlobalKey<FormState>();
  bool response = false;

  _updateHotelData(
    String hotelName,
    String hotelLocation,
    int totalRooms,
    double hotelRating,
    BuildContext context,
  ) async {
    EasyLoading.show();
    Hotel newHotel = Hotel(
      hotelName: hotelName,
      hotelLocation: hotelLocation,
      totalRooms: totalRooms,
      hotelRating: hotelRating,
      imageUrl: widget.hotel.imageUrl,
      availableRooms: widget.hotel.availableRooms,
      accomdations: [],
    );

    await HotelsDB.updateHotel(newHotel).then(
      (value) {
        if (value) {
          BotToastServices.showSuccessMessage("Hotel Updated");
          Navigator.pushNamedAndRemoveUntil(
            context,
            AdminHome.routeName,
            (route) => false,
          );
        } else {
          BotToastServices.showErrorMessage("Hotel Not Updated");
          response = value;
          setState(() {});
        }
      },
    );
    EasyLoading.dismiss();
  }

  @override
  Widget build(BuildContext context) {
    return BottomSheet(
      onClosing: () {},
      builder: (context) {
        return Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    Container(
                      height: 150,
                      width: 150,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: AppColors.blackColor.withAlpha(180),
                          width: 1.2,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: LoadingImageNetworkWidget(
                          imageUrl: widget.hotel.imageUrl,
                        ),
                      ),
                    ),
                    0.01.width.vSpace,

                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.hotel.hotelName,
                            overflow: TextOverflow.ellipsis,
                            // nameController.text ?? "User name",
                            style: TextStyle(
                              color: AppColors.blackColor,
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                          ).center,
                          Divider(
                            color: AppColors.blackColor,
                            thickness: 0.6,
                            // indent: 18,
                          ),
                          Text(
                            overflow: TextOverflow.ellipsis,
                            widget.hotel.hotelLocation,
                            style: TextStyle(
                              color: AppColors.blackColor,
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                          ).center,
                          Divider(
                            color: AppColors.blackColor,
                            thickness: 0.6,
                            // indent: 18,
                          ),
                          Text(
                            "${widget.hotel.totalRooms} Room ",
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: AppColors.blackColor,
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                          ).center,
                        ],
                      ).hPadding(0.02.width),
                    ),
                    // Spacer(),
                    0.02.vSpace,
                  ],
                ),
                0.01.height.hSpace,
                CustomTextFormField(
                  hintText: widget.hotel.hotelName,
                  controller: hotelNameController,
                ),
                0.01.height.hSpace,
                // CustomTextFormField(
                //   hintText: widget.hotel.hotelLocation,
                //   controller: hotelLocationController,
                // ),

                NumbersTextFormField(
                  hintText: "${widget.hotel.totalRooms}",
                  controller: totalRoomsController,
                ),

                0.01.height.hSpace,
                SelectState(
                  onCountryChanged: (value) {
                    setState(() {
                      countryValue = value;
                    });
                  },
                  onStateChanged: (value) {
                    setState(() {
                      stateValue = value;
                    });
                  },
                  onCityChanged: (value) {
                    setState(() {
                      cityValue = value;
                    });
                  },
                ),
                0.01.height.hSpace,
                RatingBar.builder(
                  initialRating: widget.hotel.hotelRating,
                  minRating: 2,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                  itemBuilder: (context, _) => Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (rating) {
                    hotelRating = rating;
                  },
                ).center,
                0.01.height.hSpace,
                CustomElevatedButton(
                    text: "Update",
                    textSize: 18,
                    borderRadius: 10,
                    onPressed: () {
                      countryValue = countryValue.split(" ").skip(1).join(" ");
                      _updateHotelData(
                        (hotelNameController.text.isEmpty)
                            ? widget.hotel.hotelName
                            : hotelNameController.text,
                        "$countryValue, $cityValue",
                        (totalRoomsController.text.isEmpty)
                            ? widget.hotel.totalRooms
                            : int.parse(totalRoomsController.text),
                        hotelRating,
                        context,
                      );
                    })
              ],
            ).allPadding(10),
          ),
        );
      },
    );
  }
}
