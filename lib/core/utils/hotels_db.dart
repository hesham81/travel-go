import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:travel_go/core/services/storage.dart';
import 'package:travel_go/core/utils/id_generator.dart';
import 'package:travel_go/models/hotel_model.dart';

import '../services/bot_toast.dart';

abstract class HotelsDB {
  static final _firestore = FirebaseFirestore.instance;

  static Future<List?> getAllHotelsData(BuildContext context) async {
    try {
      EasyLoading.show();
      CollectionReference colRef = collectionRef();
      var hotels = [];
      await colRef.get().then(
        (QuerySnapshot<Object?> querySnapshot) {
          hotels = querySnapshot.docs.map(
            (element) {
              return element.data() as Hotel;
            },
          ).toList();
        },
        onError: (e) => print("Error completing: $e"),
      );
      log("Hotels ${hotels[0].imageUrl}");
      EasyLoading.dismiss();
      return hotels;
    } catch (error) {
      print(error.toString());
      EasyLoading.dismiss();
    }
    return null;
  }

  static Future<void> addHotel({
    required Hotel hotel,
  }) async {
    try {
      String id = IdGenerator.generateId(
        value1: hotel.hotelName,
        value2: hotel.hotelLocation,
      );
      hotel.id = id ;

      await _firestore.collection("Hotel").doc(hotel.id).set(hotel.toMap());
      BotToastServices.showSuccessMessage(
        "Hotel Added",
      );
    } catch (error, stackTrace) {
      log("Error adding hotel: $error", stackTrace: stackTrace);
      BotToastServices.showErrorMessage("error");
    }
  }

  static Stream<QuerySnapshot<Hotel>>? getStreamHotelsData() {
    try {
      var colRef = collectionRef();
      return colRef.snapshots();
    } catch (error) {
      print(error.toString());
    }
    return null;
  }

  static CollectionReference<Hotel> collectionRef() {
    return _firestore.collection("Hotel").withConverter(
          fromFirestore: (snapshot, _) => Hotel.fromMap(snapshot.data()!),
          toFirestore: (hotel, _) => hotel.toMap(),
        );
  }

  static Future<void> deleteHotelByName(String hotelName) async {
    try {
      var querySnapshot =
          await collectionRef().where("HotelName ", isEqualTo: hotelName).get();

      for (var doc in querySnapshot.docs) {
        await Storage.deleteImage(doc.data().hotelName);
        await doc.reference.delete();
      }

      if (querySnapshot.docs.isNotEmpty) {
        log("Hotel(s) with name '$hotelName' deleted successfully.");
      } else {
        log("No hotel found with the name '$hotelName'.");
      }
    } catch (e) {
      log("Error deleting hotel: $e");
    }
  }

  static Future<Hotel?> getHotelByName(String hotelName) async {
    try {
      var querySnapshot = await collectionRef()
          .where(
            "HotelName ",
            isEqualTo: hotelName,
          )
          .get();

      for (var doc in querySnapshot.docs) {
        return doc.data();
      }
    } catch (error) {
      log("Error ${error}");
    }
    return null;
  }

  static Future<bool> updateHotel(Hotel hotel) async {
    try {
      var querySnapshot = await collectionRef()
          .where(
            "HotelName ",
            isEqualTo: hotel.hotelName,
          )
          .get();
      for (var doc in querySnapshot.docs) {
        await doc.reference.update(
          hotel.toMap(),
        );
      }

      return Future.value(true);
    } catch (error) {
      log("Error ${error}");
      return Future.value(false);
    }
  }

  static Future<List<Hotel>> getAllHotels() {
    return collectionRef().get().then(
          (value) => value.docs
              .map(
                (e) => e.data(),
              )
              .toList(),
        );
  }
}
