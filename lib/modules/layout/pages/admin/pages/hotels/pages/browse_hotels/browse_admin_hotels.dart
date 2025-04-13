import 'package:flutter/material.dart';
import 'package:travel_go/core/extensions/dimensions.dart';
import 'package:travel_go/core/extensions/extensions.dart';
import 'package:travel_go/core/theme/app_colors.dart';
import 'package:travel_go/core/utils/hotels_db.dart';
import 'package:travel_go/models/hotel_model.dart';
import 'package:travel_go/modules/layout/pages/admin/pages/hotels/pages/widgets/hotel_admin_widget.dart';

class BrowseAdminHotels extends StatelessWidget {
  const BrowseAdminHotels({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Browse Hotels",
          style: theme.titleLarge!.copyWith(
            color: AppColors.whiteColor,
          ),
        ),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            Icons.arrow_back_ios,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            0.01.height.hSpace,
            StreamBuilder(
              stream: HotelsDB.getStreamHotelsData(),
              builder: (context, snapshot) {
                List<Hotel> hotels =
                    snapshot.data?.docs.map((e) => e.data()).toList() ?? [];
                return ListView.separated(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) => HotelAdminWidget(
                    model: hotels[index],
                  ),
                  separatorBuilder: (context, index) => 0.01.height.hSpace,
                  itemCount: hotels.length,
                );
              },
            )
          ],
        ).hPadding(0.03.width),
      ),
    );
  }
}
