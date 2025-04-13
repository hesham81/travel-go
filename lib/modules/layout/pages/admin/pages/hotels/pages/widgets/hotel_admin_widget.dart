import 'package:flutter/material.dart';
import 'package:travel_go/core/extensions/dimensions.dart';
import 'package:travel_go/core/extensions/extensions.dart';
import 'package:travel_go/core/widget/custom_container.dart';
import 'package:travel_go/core/widget/custom_rating_widget.dart';
import 'package:travel_go/core/widget/loading_image_network_widget.dart';
import 'package:travel_go/models/hotel_model.dart';

class HotelAdminWidget extends StatelessWidget {
  final Hotel model;

  const HotelAdminWidget({
    super.key,
    required this.model,
  });

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      padding: EdgeInsets.zero,
      height: 0.15.height,
      child: Row(
        children: [
          Expanded(
            flex: 5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  model.hotelName,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                Spacer(),
                SizedBox(
                  width: double.maxFinite,
                  child: CustomRatingWidget(
                    itemSize: 30,
                    minRating: model.hotelRating,
                  ),
                ),
                0.01.height.hSpace,
              ],
            ).allPadding(10),
          ),
          0.02.width.vSpace,
          Expanded(
            flex: 3,
            child: LoadingImageNetworkWidget(
              imageUrl: model.imageUrl,
            ),
          ),
        ],
      ),
    );
  }
}
