import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:travel_go/core/extensions/extensions.dart';
import 'package:travel_go/core/utils/hotels_db.dart';
import 'package:travel_go/core/widget/custom_container.dart';
import 'package:travel_go/models/hotel_model.dart';

import '../../../../../../../../core/theme/app_colors.dart';
import '../../../../../../../../core/widget/custom_elevated_button.dart';
import '../../../../../../../../core/widget/dividers_word.dart';
import '../../../../../../../../core/widget/loading_image_network_widget.dart';
import '../../../../../../widget/text_labels_widget.dart';

class AdminDeleteHotel extends StatefulWidget {
  final Hotel hotel;

  const AdminDeleteHotel({
    super.key,
    required this.hotel,
  });

  @override
  State<AdminDeleteHotel> createState() => _AdminDeleteHotelState();
}

class _AdminDeleteHotelState extends State<AdminDeleteHotel> {
  _delete()async{
    EasyLoading.show();
    await HotelsDB.delete(widget.hotel.id);
    EasyLoading.dismiss();
    Navigator.pop(context);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            Icons.arrow_back_ios,
          ),
        ),
        title: Text(
          "Tour And Travel",
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: AppColors.whiteColor,
              ),
        ),
        centerTitle: true,
      ),
      bottomNavigationBar: CustomContainer(
        child: Row(
          children: [
            Expanded(
              child: CustomElevatedButton(
                text: "Delete",
                onPressed: _delete,
                btnColor: AppColors.errorColor,
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            LoadingImageNetworkWidget(
              imageUrl: widget.hotel.imageUrl,
            ),
            0.01.height.hSpace,
            Column(
              children: [
                TextLabelsWidget(
                  label: "Hotel Id ",
                  value: widget.hotel.id,
                ),
                0.01.height.hSpace,
                TextLabelsWidget(
                  label: "Hotel Name ",
                  value: widget.hotel.hotelName,
                ),
                0.01.height.hSpace,
                TextLabelsWidget(
                  label: "Hotel Location ",
                  value: widget.hotel.hotelLocation,
                ),
                0.01.height.hSpace,
                TextLabelsWidget(
                  label: "Hotel Rating ",
                  value: widget.hotel.hotelRating.toString(),
                ),
                0.01.height.hSpace,
                DividersWord(
                  text: "Room Details ",
                ),
                0.01.height.hSpace,
                TextLabelsWidget(
                  label: "Room Type ",
                  value: widget.hotel.accomdations.first.roomType,
                ),
                0.01.height.hSpace,
                TextLabelsWidget(
                  label: "Room Price ",
                  value: widget.hotel.accomdations.first.roomPrice.toString(),
                ),
                0.01.height.hSpace,
                TextLabelsWidget(
                  label: "Room Available ",
                  value:
                      widget.hotel.accomdations.first.roomAvailable.toString(),
                ),
                0.01.height.hSpace,
                CarouselSlider(
                  items: widget.hotel.accomdations.first.imagesUrls
                      .map((e) => LoadingImageNetworkWidget(imageUrl: e))
                      .toList(),
                  options: CarouselOptions(
                    height: 400,
                    aspectRatio: 16 / 9,
                    viewportFraction: 0.8,
                    initialPage: 0,
                    enableInfiniteScroll: true,
                    reverse: false,
                    autoPlay: true,
                    autoPlayInterval: Duration(seconds: 3),
                    autoPlayAnimationDuration: Duration(milliseconds: 800),
                    autoPlayCurve: Curves.fastOutSlowIn,
                    enlargeCenterPage: true,
                    enlargeFactor: 0.3,
                    scrollDirection: Axis.horizontal,
                  ),
                ),
                0.01.height.hSpace,
                Divider(
                  color: AppColors.newBlueColor,
                ).hPadding(0.15.width),
                0.01.height.hSpace,
                TextLabelsWidget(
                  label: "Room Type ",
                  value: widget.hotel.accomdations[1].roomType,
                ),
                0.01.height.hSpace,
                TextLabelsWidget(
                  label: "Room Price ",
                  value: widget.hotel.accomdations[1].roomPrice.toString(),
                ),
                0.01.height.hSpace,
                TextLabelsWidget(
                  label: "Room Available ",
                  value: widget.hotel.accomdations[1].roomAvailable.toString(),
                ),
                0.01.height.hSpace,
                CarouselSlider(
                  items: widget.hotel.accomdations[1].imagesUrls
                      .map((e) => LoadingImageNetworkWidget(imageUrl: e))
                      .toList(),
                  options: CarouselOptions(
                    height: 400,
                    aspectRatio: 16 / 9,
                    viewportFraction: 0.8,
                    initialPage: 0,
                    enableInfiniteScroll: true,
                    reverse: false,
                    autoPlay: true,
                    autoPlayInterval: Duration(seconds: 3),
                    autoPlayAnimationDuration: Duration(milliseconds: 800),
                    autoPlayCurve: Curves.fastOutSlowIn,
                    enlargeCenterPage: true,
                    enlargeFactor: 0.3,
                    scrollDirection: Axis.horizontal,
                  ),
                ),
                0.01.height.hSpace,
                Divider(
                  color: AppColors.newBlueColor,
                ).hPadding(0.15.width),
                0.01.height.hSpace,
                TextLabelsWidget(
                  label: "Room Type ",
                  value: widget.hotel.accomdations.last.roomType,
                ),
                0.01.height.hSpace,
                TextLabelsWidget(
                  label: "Room Price ",
                  value: widget.hotel.accomdations.last.roomPrice.toString(),
                ),
                0.01.height.hSpace,
                TextLabelsWidget(
                  label: "Room Available ",
                  value:
                      widget.hotel.accomdations.last.roomAvailable.toString(),
                ),
                0.01.height.hSpace,
                CarouselSlider(
                  items: widget.hotel.accomdations.last.imagesUrls
                      .map((e) => LoadingImageNetworkWidget(imageUrl: e))
                      .toList(),
                  options: CarouselOptions(
                    height: 400,
                    aspectRatio: 16 / 9,
                    viewportFraction: 0.8,
                    initialPage: 0,
                    enableInfiniteScroll: true,
                    reverse: false,
                    autoPlay: true,
                    autoPlayInterval: Duration(seconds: 3),
                    autoPlayAnimationDuration: Duration(milliseconds: 800),
                    autoPlayCurve: Curves.fastOutSlowIn,
                    enlargeCenterPage: true,
                    enlargeFactor: 0.3,
                    scrollDirection: Axis.horizontal,
                  ),
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
