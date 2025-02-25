import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:travel_go/modules/layout/pages/admin/menna/trippp/model/trip_model.dart';
import '/core/utils/id_generator.dart';
import '/models/trip.dart';

abstract class TripDB {
  static final _firestore = FirebaseFirestore.instance;

  static CollectionReference<TripDataProgramModel> collectionRef() {
    return _firestore.collection("Trip").withConverter(
          fromFirestore: (snapshot, _) =>
              TripDataProgramModel.fromMap(snapshot.data()!),
          toFirestore: (trip, _) => trip.toMap(),
        );
  }

  static addNewTrip(
    BuildContext context, {
    required TripDataProgramModel trip,
  }) {
    EasyLoading.show();
    CollectionReference<TripDataProgramModel> colRef = collectionRef();
    var id = trip.tripId;
    colRef.doc(id).set(trip);
    EasyLoading.dismiss();
  }

  static Stream<QuerySnapshot<TripDataProgramModel>>? getStreamTripData() {
    try {
      var colRef = collectionRef();
      log("Data Returned");
      return colRef.snapshots();
    } catch (error) {
      print(error.toString());
    }
    return null;
  }
}
