import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';

abstract class FirestoreServices {
  static final _fireStore = FirebaseFirestore.instance;

  static RoleBasedSignUp({
    required String email,
    required String password,
    required String uid,
    required DateTime createdAt,
    required String? phoneNumber,
    required String? address,
    required String? name,
    bool isAdmin = false,
  }) async {
    try {
      await _fireStore.collection('users').doc(uid).set({
        'email': email,
        'password': password,
        'uid': uid,
        'createdAt': createdAt.millisecondsSinceEpoch,
        'role': (isAdmin) ? 'admin' : 'user',
        'phoneNumber': phoneNumber,
        'address': address,
        'name': name,
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
      return role ;
    } catch (error) {
       print(error);
    }
    return null ;
  }
}
