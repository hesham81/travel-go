import 'package:cloud_firestore/cloud_firestore.dart';
import '/models/trip_data_model.dart';

abstract class TripCollections {
  static final _firestore = FirebaseFirestore.instance.collection("Trip");

  static CollectionReference<TripDataModel> _colRef() {
    return _firestore.withConverter(
      fromFirestore: (snapshot, options) =>
          TripDataModel.fromMap(snapshot.data()!),
      toFirestore: (value, _) => value.toMap(),
    );
  }

  static Stream<QuerySnapshot<TripDataModel>> getAllTrips() {
    return _colRef().snapshots();
  }

  static Future<bool> addTrip(TripDataModel model) async {
    try {
      await _colRef().doc(model.tripId).set(model);
      return true;
    } catch (error) {
      print(error);
      return false;
    }
  }

  static Future<List<TripDataModel>> getListOfTrips() async {
    return await _colRef().get().then(
          (value) => value.docs
              .map(
                (e) => e.data(),
              )
              .toList(),
        );
  }

  static Future<bool> deleteTrip(TripDataModel model) async {
    try {
      await _colRef().doc(model.tripId).delete();
      return true;
    } catch (error) {
      return false;
    }
  }
}
