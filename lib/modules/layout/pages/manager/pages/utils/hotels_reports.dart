import 'package:cloud_firestore/cloud_firestore.dart';

abstract class UsersReports {
  static final _firestore = FirebaseFirestore.instance.collection("Hotel");

  static Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>>
      getTotalHotelsData() async {
    return await _firestore.get().then(
          (value) => value.docs,
        );
  }

  static Future<int> getAllHotels() async {
    var size = await _firestore.get().then(
          (value) => value.docs.length,
        );
    return size ;
  }
}
