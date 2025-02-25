import 'package:cloud_firestore/cloud_firestore.dart';

import '../../modules/layout/pages/admin/menna/trippp/model/trip_departures.dart';
import 'id_generator.dart';

abstract class TripDeparturesCollection {
  static final _firestore =
      FirebaseFirestore.instance.collection("Trip_Departures");

  static CollectionReference<TripDepartures> _colRef() {
    return _firestore.withConverter(
      fromFirestore: (snapshot, options) =>
          TripDepartures.fromJson(snapshot.data()!),
      toFirestore: (value, _) => value.toJson(),
    );
  }

  static Future<bool> addTripDepartures(TripDepartures model) async {
    try {
      await _colRef().doc().set(model);
      return true;
    } catch (error) {
      return false;
    }
  }

  static Future<List<TripDepartures>> getAllTripDepartures() {
    return _colRef().get().then(
          (value) => value.docs
              .map(
                (e) => e.data(),
              )
              .toList(),
        );
  }
}
