import 'package:flutter/material.dart';
import 'package:travel_go/core/utils/favourite_trip_collections.dart';
import 'package:travel_go/core/utils/hotel_favourites_collections.dart';
import 'package:travel_go/core/utils/hotels_db.dart';
import 'package:travel_go/models/hotel_model.dart';

class FavouriteHotels extends StatefulWidget {
  const FavouriteHotels({super.key});

  @override
  State<FavouriteHotels> createState() => _FavouriteHotelsState();
}

class _FavouriteHotelsState extends State<FavouriteHotels> {
  List<Hotel> _hotels = [];


  Future<void> _initData() async {
    List<Hotel> allHotels = await HotelsDB.getAllHotels();
    for (var hotel in allHotels) {
      if (await HotelFavouritesCollections.checkIfFavouriteOrNot(
          hotelId: hotel.id)) {
        _hotels.add(hotel);
      }
    }
    setState(() {});
  }


  @override
  void initState() {

    Future.wait([_initData()]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox();
  }
}
