import 'package:flutter/material.dart';
import 'package:route_transitions/route_transitions.dart';
import 'package:travel_go/core/extensions/dimensions.dart';
import 'package:travel_go/core/extensions/extensions.dart';
import 'package:travel_go/core/widget/custom_container.dart';
import 'package:travel_go/core/widget/custom_rating_widget.dart';
import 'package:travel_go/core/widget/loading_image_network_widget.dart';
import 'package:travel_go/models/hotel_model.dart';
import 'package:travel_go/modules/layout/pages/admin/pages/hotels/pages/browse_hotels/selected_admin_hotel_room.dart';
import 'package:travel_go/modules/layout/pages/admin/pages/hotels/pages/delete_hotel/admin_delete_hotel.dart';
import 'package:travel_go/modules/layout/pages/admin/pages/hotels/pages/update_hotel/admin_update_hotel.dart';

import '../../../../../../../../core/theme/app_colors.dart';

class HotelAdminWidget extends StatelessWidget {
  final Hotel model;
  final bool isDeleted;

  final bool isUpdated;

  const HotelAdminWidget({
    super.key,
    required this.model,
    this.isDeleted = false,
    this.isUpdated = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => slideLeftWidget(
          newPage: SelectedAdminHotelRoom(hotel: model), context: context),
      child: CustomContainer(
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
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        (isUpdated)
                            ? Expanded(
                                child: IconButton(
                                  onPressed: () => slideLeftWidget(
                                      newPage: AdminUpdateHotel(
                                        hotel: model,
                                      ),
                                      context: context),
                                  style: IconButton.styleFrom(
                                    backgroundColor: AppColors.newBlueColor,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(3),
                                    ),
                                  ),
                                  icon: Icon(
                                    Icons.edit,
                                    color: AppColors.greyColor,
                                  ),
                                ),
                              )
                            : SizedBox(),
                        0.01.width.vSpace,
                        (isDeleted)
                            ? Expanded(
                                child: IconButton(
                                  onPressed: () => slideLeftWidget(
                                      newPage: AdminDeleteHotel(hotel: model),
                                      context: context),
                                  style: IconButton.styleFrom(
                                    backgroundColor: AppColors.errorColor,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(3),
                                    ),
                                  ),
                                  icon: Icon(
                                    Icons.delete,
                                    color: AppColors.greyColor,
                                  ),
                                ),
                              )
                            : SizedBox(),
                      ],
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
      ),
    );
  }
}
