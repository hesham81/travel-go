import 'package:flutter/material.dart';
import 'package:roundcheckbox/roundcheckbox.dart';
import 'package:travel_go/core/extensions/align.dart';
import 'package:travel_go/core/extensions/extensions.dart';
import 'package:travel_go/core/utils/hotels_db.dart';
import 'package:travel_go/models/hotel_model.dart';

import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/utils/flight_collections.dart';
import '../../../../../../models/hotel_model.dart';

class AssignHotel extends StatefulWidget {
  static const routeName = '/assign-hotel';

  const AssignHotel({super.key});

  @override
  State<AssignHotel> createState() => _AssignHotelState();
}

class _AssignHotelState extends State<AssignHotel> {
  List<Hotel> hotels = [];
  int? selectedIndex;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Assign Hotel",
          style: theme.titleLarge!.copyWith(
            color: AppColors.whiteColor,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            StreamBuilder(
              stream: HotelsDB.getStreamHotelsData(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator(
                    color: AppColors.newBlueColor,
                  ).center;
                }
                hotels = snapshot.data!.docs
                    .map(
                      (e) => e.data(),
                    )
                    .toList();
                return ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) => Row(
                    children: [
                      RoundCheckBox(
                        onTap: (_) {
                          selectedIndex = index;
                          setState(() {});
                        },
                        uncheckedColor: AppColors.greyColor,
                        isChecked:
                            (selectedIndex == index && selectedIndex != null)
                                ? true
                                : false,
                        borderColor: AppColors.newBlueColor,
                        checkedWidget: Icon(
                          Icons.business,
                          color: AppColors.whiteColor,
                        ),
                        checkedColor: AppColors.newBlueColor,
                      ),
                      0.02.width.vSpace,
                      Text(
                        hotels[index].hotelName,
                        style: theme.titleMedium,
                      ),
                      0.02.width.vSpace,
                      Text(
                        hotels[index].hotelLocation,
                        style: theme.titleMedium,
                      ),
                    ],
                  ),
                  separatorBuilder: (context, _) => 0.01.height.hSpace,
                  itemCount: hotels.length,
                );
              },
            ),
          ],
        ).allPadding(10),
      ),
    );
  }
}
