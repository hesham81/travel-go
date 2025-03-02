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
      return false;
    }
  }
}
