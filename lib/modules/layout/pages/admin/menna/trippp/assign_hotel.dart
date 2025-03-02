import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:roundcheckbox/roundcheckbox.dart';
import '/core/providers/trip_admin_provider.dart';
import '/core/extensions/align.dart';
import '/core/extensions/extensions.dart';
import '/core/utils/hotels_db.dart';
import '/models/hotel_model.dart';
import '/core/theme/app_colors.dart';

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
    var provider = Provider.of<TripAdminProvider>(context);
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
                          provider.setSelectionHotel(hotels[index]);
                        },
                        uncheckedColor: AppColors.greyColor,
                        isChecked: (provider.getSelectionHotel != null &&
                                provider.getSelectionHotel!.hotelName == hotels[index].hotelName)
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
                        overflow: TextOverflow.ellipsis,
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
