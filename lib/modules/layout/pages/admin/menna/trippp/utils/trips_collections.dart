import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:travel_go/core/utils/id_generator.dart';
import '../model/trip_model.dart';

abstract class TripCollections {
  static final _firestore = FirebaseFirestore.instance.collection("Trips");

  static CollectionReference<TripDataProgramModel> _colRef() {
    return _firestore.withConverter(
      fromFirestore: (snapshot, options) => TripDataProgramModel.fromMap(snapshot.data()!),
      toFirestore: (value, _) => value.toMap(),
    );
  }

  static Stream<QuerySnapshot<TripDataProgramModel>> getAllTrips() {
    return _colRef().snapshots();
  }

  static Future<bool> addTrip(TripDataProgramModel model) async {
    try {
      var id = IdGenerator.generateId(
        value1: model.organizedBy.companyName,
        value2: model.tripTitle,
      );
      model.tripId = id ;
      await _colRef().doc(id).set(model);
      return true;
    } catch (error) {
      return false;
    }
  }
}
