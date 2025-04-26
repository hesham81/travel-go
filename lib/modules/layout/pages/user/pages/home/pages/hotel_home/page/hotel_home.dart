import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:route_transitions/route_transitions.dart';
import 'package:travel_go/modules/layout/pages/user/pages/home/pages/hotel_home/widget/find_hotels_locations.dart';
import 'package:travel_go/modules/layout/pages/user/pages/home/pages/reservation/pages/hotel_reservation/widget/hotel_item_widget.dart';
import '/core/extensions/extensions.dart';
import '/core/utils/hotels_db.dart';
import '/core/widget/loading_image_network_widget.dart';
import '/models/hotel_model.dart';
import '/modules/layout/pages/user/widget/app_bar.dart';
import '../../../../../../../../../core/theme/app_colors.dart';
import '../../../../../../../../../core/widget/custom_container.dart';
import 'hotel_home_details.dart';

class HotelHome extends StatefulWidget {
  const HotelHome({super.key});

  @override
  State<HotelHome> createState() => _HotelHomeState();
}

class _HotelHomeState extends State<HotelHome> {
  List<Hotel> hotels = [];
  List<Hotel> searchHotels = [];

  _search(String query) {
    searchHotels.clear();
    if (query.isEmpty) {
      setState(() {});
      return;
    }
    for (var hotel in hotels) {
      if (hotel.hotelName.toLowerCase().contains(query.toLowerCase()) ||
          hotel.hotelLocation.toLowerCase().contains(query.toLowerCase())) {
        searchHotels.add(hotel);
      }
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              0.01.height.hSpace,
              AppBarWidget(),
              0.01.height.hSpace,
              FindHotelsLocations(),
              0.01.height.hSpace,
              CupertinoSearchTextField(
                onChanged: _search,
              ),
              0.01.height.hSpace,
              StreamBuilder(
                stream: HotelsDB.getStreamHotelsData(),
                builder: (context, snapshot) {
                  hotels =
                      snapshot.data?.docs.map((e) => e.data()).toList() ?? [];
                  if (searchHotels.isEmpty) {
                    searchHotels = hotels;
                  }
                  return ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.zero,
                    itemCount: searchHotels.length,
                    itemBuilder: (context, index) {
                      final hotel = searchHotels[index];
                      return HotelItemWidget(hotel: hotel);
                    },
                    separatorBuilder: (BuildContext context, int index) =>
                        0.01.height.hSpace,
                  );
                },
              ),
              0.01.height.hSpace,
            ],
          ).hPadding(0.03.width),
        ),
      ),
    );
  }
}
