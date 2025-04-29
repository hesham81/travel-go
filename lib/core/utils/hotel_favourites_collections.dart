import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:travel_go/models/hotel_favourites_data_model.dart';
import 'package:travel_go/models/hotel_favourites_data_model.dart';
import 'package:travel_go/models/hotel_favourites_data_model.dart';
import 'package:travel_go/modules/layout/pages/user/pages/home/pages/favourite_home/page/favourite_hotels.dart';

abstract class HotelFavouritesCollections {
  static final _firestore =
      FirebaseFirestore.instance.collection("Hotel_Favourites");
  static final String userId = FirebaseAuth.instance.currentUser!.uid;

  static CollectionReference<HotelFavouritesDataModel> _colRef() {
    return _firestore.withConverter<HotelFavouritesDataModel>(
      fromFirestore: (snapshot, options) =>
          HotelFavouritesDataModel.fromJson(snapshot.data()!),
      toFirestore: (value, options) => value.toJson(),
    );
  }

  static Future<void> _checkIfExist() async {
    HotelFavouritesDataModel? response = await _colRef().doc(userId).get().then(
          (value) => value.data(),
        );
    if (response == null) {
      log("Not Available");
      HotelFavouritesDataModel model = HotelFavouritesDataModel(
        userId: userId,
        hotels: [],
      );
      await _colRef().doc(userId).set(model);
    }
  }

  static Future<void> addHotel(String hotelId) async {
    HotelFavouritesDataModel hotel = await getHotelsIds();
    log(hotel.userId);
    if (hotel.hotels.contains(hotelId)) {
      hotel.hotels.remove(hotelId);
      log("Removed");
    } else {
      hotel.hotels.add(hotelId);
      log("Added");
    }
    await _colRef().doc(userId).set(hotel);
  }

  static Future<bool> checkIfFound({
    required String hotelId,
  }) async {
    try {
      HotelFavouritesDataModel hotel = await getHotelsIds();
      return hotel.hotels.contains(hotelId);
    } catch (error) {
      throw Exception(error);
    }
  }

  static Stream<QuerySnapshot<HotelFavouritesDataModel>> getHotelsId() {
    _checkIfExist().then(
      (value) => value,
    );
    return _colRef().snapshots();
  }

  static Future<HotelFavouritesDataModel> getHotelsIds() async {
    await _checkIfExist();
    return await _colRef().doc(userId).get().then(
          (value) => value.data()!,
        );
  }
}
