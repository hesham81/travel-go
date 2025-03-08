import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:travel_go/modules/layout/pages/user/pages/home/pages/favourite_home/data/model/favourite_data_model.dart';
import 'package:travel_go/modules/layout/pages/user/pages/home/pages/favourite_home/data/model/favourite_data_model.dart';

abstract class FavouriteCollections {
  static final _firestore = FirebaseFirestore.instance.collection("Favourite");

  static CollectionReference<FavouriteTripDataModel> _colRef() {
    return _firestore.withConverter(
      fromFirestore: (snapshot, options) =>
          FavouriteTripDataModel.fromMap(snapshot.data()!),
      toFirestore: (value, _) => value.toMap(),
    );
  }

  static addTrip(FavouriteTripDataModel model) async {
    try {
      await _colRef().doc().set(model);
      return true;
    } catch (error) {
      return false;
    }
  }

  static Future<FavouriteTripDataModel> getTrip(String uid) async {
    var doc = await _colRef().doc(uid).get();
    return doc.data()!;
  }

  static Future<bool> deleteTrip(String uid) async {
    try {
      await _colRef().doc(uid).delete();
      return true;
    } catch (error) {
      return false;
    }
  }

  static Stream<FavouriteTripDataModel> getTripStream(String uid) {
    return _colRef().doc(uid).snapshots().map((event) => event.data()!);
  }
}
