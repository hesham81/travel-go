import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:travel_go/core/utils/id_generator.dart';
import 'package:travel_go/models/flight_departures.dart';

abstract class FlightDeparturesCollections {
  static final _firestore =
      FirebaseFirestore.instance.collection("Flight_Departures");

  static CollectionReference<FlightDeparture> _collectionReference() =>
      _firestore.withConverter(
        fromFirestore: (snapshot, options) =>
            FlightDeparture.fromMap(snapshot.data()!),
        toFirestore: (value, options) => value.toMap(),
      );

  static Future<String?> submitFlight({
    required FlightDeparture departure,
  }) async {
    try {
      departure.id = IdGenerator.generateFlightDepartureId(
        flightId: departure.flightId,
        departureDay: departure.arrDay.toString(),
        from: departure.depAirport,
        to: departure.arrAirport,
      );
      await _collectionReference().doc(departure.id).set(departure);
      return null;
    } catch (error) {
      return Future.value(error.toString());
    }
  }
  static Stream<QuerySnapshot<FlightDeparture>> getStreamDepartures(){
    return _collectionReference().snapshots();
  }
}
