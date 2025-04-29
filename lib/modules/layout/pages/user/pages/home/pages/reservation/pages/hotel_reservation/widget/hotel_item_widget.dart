import 'package:flutter/material.dart';
import 'package:route_transitions/route_transitions.dart';
import 'package:travel_go/core/extensions/extensions.dart';
import 'package:travel_go/core/theme/app_colors.dart';
import 'package:travel_go/models/hotel_model.dart';import '../../../../../../../../../../../core/widget/custom_container.dart';


import '../../../../../../../../../../../core/widget/loading_image_network_widget.dart';
import '../../../../hotel_home/page/hotel_home_details.dart';

class HotelItemWidget extends StatelessWidget {
  final Hotel hotel;

  const HotelItemWidget({
    super.key,
    required this.hotel,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => slideLeftWidget(
        newPage: HotelDetailsScreen(
          hotelId: hotel.id,
        ),
        context: context,
      ),
      child: CustomContainer(
        padding: EdgeInsets.zero,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(12),
                  ),
                  child: LoadingImageNetworkWidget(
                    imageUrl: hotel.imageUrl,
                    height: 180,
                    width: double.infinity,
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        hotel.hotelName,
                        style: Theme.of(context).textTheme.titleSmall!.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      Spacer(),
                      Text(
                        "${hotel.accomdations.first.roomPrice}\$",
                        style:
                            Theme.of(context).textTheme.labelMedium!.copyWith(
                                  color: Colors.green,
                                ),
                      )
                    ],
                  ),
                  0.01.height.hSpace,
                  Row(
                    children: [
                      Icon(
                        Icons.location_on_outlined,
                        color: AppColors.blackColor.withOpacity(0.3),
                      ),
                      Text(
                        hotel.hotelLocation,
                        style:
                            Theme.of(context).textTheme.labelMedium!.copyWith(
                                  color: AppColors.blackColor.withOpacity(0.3),
                                ),
                      ),
                      Spacer(),
                      Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      Text(
                        hotel.hotelRating.toString(),
                        style:
                            Theme.of(context).textTheme.labelMedium!.copyWith(
                                  color: Colors.amber,
                                ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
