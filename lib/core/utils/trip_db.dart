import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import '/core/utils/id_generator.dart';
import '/models/trip.dart';

abstract class TripDB {
  static final _firestore = FirebaseFirestore.instance;

  static CollectionReference<Trip> collectionRef() {
    return _firestore.collection("test_trip").withConverter(
          fromFirestore: (snapshot, _) => Trip.fromMap(snapshot.data()!),
          toFirestore: (trip, _) => trip.toMap(),
        );
  }

  static addNewTrip(
    BuildContext context, {
    required Trip trip,
  }) {
    EasyLoading.show();
    CollectionReference<Trip> colRef = collectionRef();
    var id = IdGenerator.generateId(
      value1: trip.source,
      value2: trip.title,
    );
    colRef.doc(id).set(trip);
    EasyLoading.dismiss();
  }

  static Stream<QuerySnapshot<Trip>>? getStreamTripData()  {
    try {
      var colRef = collectionRef();
      log("Data Returned");
      return colRef.snapshots();
    } catch (error) {
      print(error.toString());
    }
    return null ;
  }
}
