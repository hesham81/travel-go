import 'package:cloud_firestore/cloud_firestore.dart';

import '../../models/flight.dart';
import '../../models/flight_airlines.dart';

abstract class FlightCollections {
  static final _firestore = FirebaseFirestore.instance.collection("Flight");

  static CollectionReference<Flight> _colRef() {
    return _firestore.withConverter(
      fromFirestore: (snapshot, _) => Flight.fromMap(snapshot.data()!),
      toFirestore: (flight, _) => flight.toMap(),
    );
  }

  static Future<void> addFlight({required Flight flight}) async {
    try {
      await _colRef().doc(flight.flightId).set(flight);
    } catch (error) {
      print(error.toString());
    }
  }

  static Future<List<Flight>> getAllFlight() {
    return _colRef().get().then(
          (value) => value.docs
              .map(
                (e) => e.data(),
              )
              .toList(),
        );
  }

  static Stream<QuerySnapshot<Flight>> StreamFlight() {
    return _colRef().snapshots();
  }
}
