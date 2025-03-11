import 'package:cloud_firestore/cloud_firestore.dart';
import '/models/favourite_data_model.dart';

abstract class FavouriteCollections {
  static final _firestore = FirebaseFirestore.instance.collection("Favourite");

  static CollectionReference<FavouriteDataModel> _colRef() {
    return _firestore.withConverter(
      fromFirestore: (snapshot, _) =>
          FavouriteDataModel.fromMap(snapshot.data()!),
      toFirestore: (value, _) => value.toMap(),
    );
  }

  static Future<bool> addFavourite(FavouriteDataModel model) async {
    try {
      await _colRef().doc().set(model);
      return true;
    } catch (error) {
      return false;
    }
  }

  static Future<bool> deleteFavourite(String id) async {
    try {
      await _colRef().doc(id).delete();
      return true;
    } catch (error) {
      return false;
    }
  }

  static Stream<QuerySnapshot<FavouriteDataModel>>? getStreamFavouriteData() {
    try {
      var colRef = _colRef();
      return colRef.snapshots();
    } catch (error) {
      print(error.toString());
    }
  }
}
