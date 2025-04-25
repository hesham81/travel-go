import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:travel_go/models/hotel_favourites_data_model.dart';

abstract class HotelFavouritesCollections {
  static final _firestore =
      FirebaseFirestore.instance.collection("Favourite_Hotels");

  static final String userId = FirebaseAuth.instance.currentUser!.uid;

  static CollectionReference<HotelFavouritesDataModel> _collectionReference() =>
      _firestore.withConverter(
        fromFirestore: (snapshot, options) => HotelFavouritesDataModel.fromJson(
          snapshot.data()!,
        ),
        toFirestore: (value, options) => value.toJson(),
      );

  static Future<void> updateHotelStatus({
    required HotelFavouritesDataModel favourite,
  }) async {
    await _collectionReference().doc(favourite.hotelId).set(favourite);
  }

  static Future<bool> _checkIfExist({
    required String hotelId,
  }) async {
    try {
      var response = await _collectionReference().doc(hotelId).get().then(
            (value) => value.data(),
          );
      if (response == null) {
        await updateHotelStatus(
          favourite: HotelFavouritesDataModel(
            hotelId: hotelId,
            users: [],
          ),
        );
        return Future.value(false);
      }
      return Future.value(true);
    } catch (error) {
      throw Exception(error);
    }
  }

  static Future<HotelFavouritesDataModel> getHotelStatus({
    required String hotelId,
  }) async {
    await _checkIfExist(hotelId: hotelId);
    return await _collectionReference().doc(hotelId).get().then(
          (value) => value.data()!,
        );
  }

  static Future<bool> checkIfFavouriteOrNot({
    required String hotelId,
  }) async {
    try {
      await _checkIfExist(hotelId: hotelId);
      var model = await getHotelStatus(hotelId: hotelId);
      if (model.users.contains(userId)) {
        return Future.value(true);
      } else {
        return Future.value(false);
      }
    } catch (error) {
      throw Exception(error);
    }
  }
}
