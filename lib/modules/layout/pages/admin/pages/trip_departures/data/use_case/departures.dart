import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:travel_go/models/trip_data_model.dart';
import '/modules/layout/pages/admin/pages/trip_departures/data/model/trip_departure_data_model.dart';

abstract class TripDeparturesCollection {
  static final _firestore =
      FirebaseFirestore.instance.collection("TripDepartures");

  static CollectionReference<TripDepartureDataModel> _colRef() {
    return _firestore.withConverter(
      fromFirestore: (snapshot, options) =>
          TripDepartureDataModel.fromMap(snapshot.data()!),
      toFirestore: (departures, options) => departures.toMap(),
    );
  }

  static Future<bool> addDeparture(TripDepartureDataModel model) async {
    try {
      await _colRef().doc(model.id).set(model);
      return true;
    } catch (e) {
      return false;
    }
  }

  static Future<List<TripDepartureDataModel>> getTripDeparture(
    TripDataModel trip,
  ) async {
    return await _colRef().where("tripId", isEqualTo: trip.tripId).get().then(
      (value) {
        return value.docs
            .map(
              (e) => e.data(),
            )
            .toList();
      },
    );
  }

  static Stream<QuerySnapshot<TripDepartureDataModel>> getStreamDepartures() {
    return _colRef().snapshots();
  }
}
