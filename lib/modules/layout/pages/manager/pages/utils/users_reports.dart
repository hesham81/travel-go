import 'package:cloud_firestore/cloud_firestore.dart';

abstract class UsersReports {
  static final _firestore = FirebaseFirestore.instance.collection("users");

  static Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>>
      getTotalUsersData() async {
    return await _firestore.where("role", isEqualTo: "user").get().then(
          (value) => value.docs,
        );
  }

  static Future<int> getAllAppUsers() async {
    var size = await _firestore.get().then(
          (value) => value.docs.length,
        );
    return size ;
  }
}
