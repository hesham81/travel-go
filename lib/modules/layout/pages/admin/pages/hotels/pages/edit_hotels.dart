import 'package:flutter/material.dart';
import 'package:travel_go/core/widget/custom_text_form_field.dart';
import 'package:travel_go/core/widget/search_widget.dart';
import 'package:travel_go/models/hotel_model.dart';
import 'package:travel_go/modules/layout/pages/admin/pages/hotels/pages/add_hotel.dart';
import '/core/extensions/center.dart';
import '/core/extensions/extensions.dart';
import '/core/utils/hotels_db.dart';
import '/modules/layout/pages/admin/widget/custom_view_widget.dart';
import '/core/theme/app_colors.dart';

class EditHotels extends StatefulWidget {
  static const routeName = '/edit_hotels';

  const EditHotels({super.key});

  @override
  State<EditHotels> createState() => _EditHotelsState();
}

class _EditHotelsState extends State<EditHotels> {
  var hotels = [];
  TextEditingController searchController = TextEditingController();
  String searchQuery = "";
  List<Hotel> searchList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, AddHotel.routeName);
        },
        backgroundColor: AppColors.primaryColor.withOpacity(0.8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(
          Icons.add,
          color: AppColors.blackColor,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SearchWidget(
              borderRadius: 10,
              controller: searchController,
              search: (value) {
                searchQuery = value;
                searchQueryFunc();
                setState(() {});
              },
            ),
            0.01.height.hSpace,
            StreamBuilder(
              stream: HotelsDB.getStreamHotelsData(),
              builder: (context, snapshot) {
                if (snapshot.hasData == false) {
                  return Icon(
                    Icons.error,
                    color: AppColors.errorColor,
                  ).centerWidget();
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                }
                if (snapshot.connectionState == ConnectionState.none) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.replay,
                        color: AppColors.errorColor,
                      ),
                      0.01.width.hSpace,
                      Text(
                        "No Internet Connection",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: AppColors.errorColor,
                        ),
                      ),
                    ],
                  );
                }

                hotels = snapshot.data!.docs.map(
                  (data) {
                    return data.data();
                  },
                ).toList();
                return Visibility(
                  visible: searchList.isEmpty,
                  replacement: ListView.separated(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) => CustomViewWidget(
                      model: searchList[index],
                    ),
                    separatorBuilder: (context, _) => 0.01.height.hSpace,
                    itemCount: searchList.length,
                  ),
                  child: ListView.separated(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) => CustomViewWidget(
                      model: hotels[index],
                    ),
                    separatorBuilder: (context, _) => 0.01.height.hSpace,
                    itemCount: hotels.length,
                  ),
                );
              },
            ),
          ],
        ).allPadding(0.01.height),
      ),
    );
  }

  void searchQueryFunc() {
    searchList.clear();

    for (Hotel hotel in hotels) {
      if (hotel.hotelName.toLowerCase().contains(searchQuery.toLowerCase())) {
        searchList.add(hotel);
      } else if (hotel.totalRooms.toString() == (searchQuery)) {
        searchList.add(hotel);
      } else if (hotel.hotelLocation
          .toLowerCase()
          .contains(searchQuery.toLowerCase())) {
        searchList.add(hotel);
      }
    }
    setState(() {});
  }
}
