import 'package:cloud_firestore/cloud_firestore.dart';
import '/modules/layout/pages/admin/pages/trip_departures/data/model/trip_departure_data_model.dart';

abstract class DeparturesCollection {
  static final _firestore =
      FirebaseFirestore.instance.collection("TripDepartures");

  static CollectionReference<TripDepartureDataModel> _colRef() {
    return _firestore.withConverter(
      fromFirestore: (snapshot, options) =>
          TripDepartureDataModel.fromMap(snapshot.data()!),
      toFirestore: (departures, options) => departures.toMap(),
    );
  }

  static addDeparture(TripDepartureDataModel model) async {
    try {
      await _colRef().doc(model.id).set(model);
      return true;
    } catch (e) {
      return false;
    }
  }
}
