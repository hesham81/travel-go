import 'package:cloud_firestore/cloud_firestore.dart';
import '/models/favourite_trip_model.dart';

abstract class FavouriteCollections {
  static final _firestore = FirebaseFirestore.instance.collection("Favourite");

  static CollectionReference<FavouriteTripDataModel> _colRef() {
    return _firestore.withConverter(
      fromFirestore: (snapshot, _) =>
          FavouriteTripDataModel.fromMap(snapshot.data()!),
      toFirestore: (value, _) => value.toMap(),
    );
  }

  static Future<bool> addFavourite(FavouriteTripDataModel model) async {
    try {
      _checkIfExist(model.uid);

      await _colRef().doc(model.uid).set(model);
      return true;
    } catch (error) {
      return false;
    }
  }

  static Future<bool> deleteFavourite(FavouriteTripDataModel model) async {
    try {
      _checkIfExist(model.uid);

      await _colRef().doc(model.uid).set(model);
      return true;
    } catch (error) {
      return false;
    }
  }

  static Stream<QuerySnapshot<FavouriteTripDataModel>>? getStreamFavouriteData(
      String uid) {
    try {
      _checkIfExist(uid);

      var colRef = _colRef().where("uid", isEqualTo: uid);
      return colRef.snapshots();
    } catch (error) {
      print(error.toString());
    }
    return null;
  }

  static Future<List<FavouriteTripDataModel>> getAllFavourite(
      String uid) async {
    try {
      _checkIfExist(uid);
      var colRef = _colRef();
      var snapshot = await colRef.get();
      var list = snapshot.docs.map((e) => e.data()).toList();
      return list;
    } catch (error) {
      print(error.toString());
      return [];
    }
  }

  static _checkIfExist(String uid) async {
    var colRef = _colRef().doc(uid).get().then(
      (value) {
        if (value.exists == false) {
          FavouriteTripDataModel model = FavouriteTripDataModel(
            uid: uid,
            trips: [],
          );
          addFavourite(model);
        }
      },
    );
  }
}
