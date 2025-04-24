import 'package:flutter/material.dart';
import 'package:travel_go/core/extensions/align.dart';
import 'package:travel_go/core/extensions/extensions.dart';
import 'package:travel_go/core/theme/app_colors.dart';
import 'package:travel_go/core/utils/hotels_db.dart';
import 'package:travel_go/modules/layout/pages/admin/pages/hotels/pages/update_hotel/admin_update_hotel.dart';
import 'package:travel_go/modules/layout/pages/admin/pages/hotels/pages/widgets/hotel_admin_widget.dart';

import '../../../../../../../models/hotel_model.dart';

class EditSelectedHotels extends StatefulWidget {
  final String hotelId;

  const EditSelectedHotels({
    super.key,
    required this.hotelId,
  });

  @override
  State<EditSelectedHotels> createState() => _EditSelectedHotelsState();
}

class _EditSelectedHotelsState extends State<EditSelectedHotels> {
  bool isLoading = true;
  Hotel? hotel;

  Future<void> _getHotel() async {
    hotel = await HotelsDB.getHotelById(hotelId: widget.hotelId);
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    Future.wait([
      _getHotel(),
    ]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return (isLoading)
        ? CircularProgressIndicator(
            color: AppColors.newBlueColor,
          ).center
        : Scaffold(
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
            body: Column(
              children: [
                0.02.height.hSpace,
                HotelAdminWidget(
                  model: hotel!,
                  isDeleted: true,
                  isUpdated: true,
                ),
              ],
            ).hPadding(0.03.width),
          );
  }
}
