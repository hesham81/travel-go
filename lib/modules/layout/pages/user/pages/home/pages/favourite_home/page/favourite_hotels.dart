import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:travel_go/core/extensions/extensions.dart';
import 'package:travel_go/core/utils/hotel_favourites_collections.dart';
import 'package:travel_go/core/utils/hotels_db.dart';
import 'package:travel_go/core/widget/custom_container.dart';
import 'package:travel_go/models/hotel_model.dart';
import 'package:travel_go/modules/layout/pages/user/pages/home/pages/reservation/pages/hotel_reservation/widget/hotel_item_widget.dart';

import '../../../../../../../../../core/theme/app_colors.dart';
import '../../../../../../../../../models/hotel_favourites_data_model.dart';

class FavouriteHotels extends StatefulWidget {
  const FavouriteHotels({super.key});

  @override
  State<FavouriteHotels> createState() => _FavouriteHotelsState();
}

class _FavouriteHotelsState extends State<FavouriteHotels> {
  HotelFavouritesDataModel? _favourites;
  List<String> _hotelsIds = [];
  final List<Hotel> _hotels = [];

  Future<void> _handleHotels() async {
    _hotels.clear();
    _hotelsIds.map((e) => e).forEach(
          (element) async => _hotels.add(
            await HotelsDB.getHotelById(
              hotelId: element,
            ),
          ),
        );
    setState(() {});
  }

  @override
  void initState() {
    Future.wait([_handleHotels()]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: HotelFavouritesCollections.getHotelsId(),
      builder: (context, snapshot) {
        _hotelsIds = snapshot.data?.docs.first.data().hotels ?? [];
        _handleHotels();
        return ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) =>
              HotelItemWidget(hotel: _hotels[index]),
          separatorBuilder: (context, index) => 0.01.height.hSpace,
          itemCount: _hotels.length,
        );
      },
    );
  }
}
