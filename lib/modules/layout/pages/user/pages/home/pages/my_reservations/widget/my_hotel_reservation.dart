import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:travel_go/core/extensions/dimensions.dart';
import 'package:travel_go/core/extensions/extensions.dart';
import 'package:travel_go/core/widget/labels_widget.dart';
import 'package:travel_go/core/widget/loading_image_network_widget.dart';
import 'package:travel_go/models/hotel_model.dart';

class MyHotelReservation extends StatelessWidget {
  final Hotel hotel;

  const MyHotelReservation({
    super.key,
    required this.hotel,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        LoadingImageNetworkWidget(
          imageUrl: hotel.imageUrl,
        ),
        LabelsWidget(
          label: "Hotel : ",
          value: hotel.hotelName,
        ),
        0.01.height.hSpace,
        LabelsWidget(
          label: "Rating : ",
          value: hotel.hotelRating.toString(),
        ),
        0.01.height.hSpace,
        CarouselSlider(
          items: hotel.accomdations.first.imagesUrls
              .map(
                (e) => LoadingImageNetworkWidget(imageUrl: e),
              )
              .toList(),
          options: CarouselOptions(),
        ),
        0.03.height.hSpace,
      ],
    );
  }
}
