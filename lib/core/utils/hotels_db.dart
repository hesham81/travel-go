import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:travel_go/models/hotel_model.dart';

abstract class HotelsDB {
  static final _firestore = FirebaseFirestore.instance;

  static CollectionReference<Hotel> collectionRef() {
    return _firestore.collection("Hotel").withConverter(
          fromFirestore: (snapshot, _) => Hotel.fromMap(snapshot.data()!),
          toFirestore: (hotel, _) => hotel.toMap(),
        );
  }

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

  static Stream<QuerySnapshot<Hotel>>? getStreamHotelsData()  {
    try {
      var colRef = collectionRef();
      return colRef.snapshots();
    } catch (error) {
      print(error.toString());
    }
    return null ;
  }

  static addHotel({required Hotel hotel}) {
    try {
      _firestore.collection("Hotel").add(hotel.toMap());
    } catch (error) {
      return null;
    }
  }
}
