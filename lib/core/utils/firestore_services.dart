import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import '/models/trip.dart';

abstract class FirestoreServices {
  static final _fireStore = FirebaseFirestore.instance;

  static RoleBasedSignUp({
    required String email,
    required String uid,
    required String nationalId,
    bool isAdmin = false,
  }) async {
    try {
      await _fireStore.collection('users').doc(uid).set({
        'email': email,
        'uid': uid,
        'role': (isAdmin) ? 'admin' : 'user',
        'nationalId': nationalId,
      });
      return null;
    } catch (error) {
      return error;
    }
  }

  static RoleBasedSignIn({
    required id,
  }) async {
    try {
      var data = await _fireStore.collection("users").doc(id).get();
      var role = data['role'];
      return role;
    } catch (error) {
      print(error);
    }
    return null;
  }

  static getAllTripData() async {
    log("Start to get all trip data");
    QuerySnapshot<Map<String, dynamic>> colRef =
        await _fireStore.collection("test_trip").get();
    List<Trip> tripList = [];
    var testList =
        colRef.docs.map((QueryDocumentSnapshot<Map<String, dynamic>> value) {
      return (Trip.fromMap(value.data()));
    }).toList();
    log("Numbers Of Data Fetched ${testList.length}");

    for (var tripp in tripList) {
      log(tripp.title);
    }
    log("end of get all trip data");
    return tripList;
  }

  static Future<String?> insertTripData({required Trip data}) async {
    try {
      _fireStore.collection("test_trip").doc(data.id).set(data.toMap());
    } catch (e) {
      return Future.value(e.toString());
    }
    return null;
  }

  static Future<dynamic> getTripData({required String id}) async {
    Map<String, dynamic>? data;
    try {
      await _fireStore
          .collection("test_trip")
          .doc(id)
          .get()
          .then((DocumentSnapshot element) {
        data = element.data() as Map<String, dynamic>?;
      });
      return data;
    } catch (error) {
      return false;
    }
  }
}
