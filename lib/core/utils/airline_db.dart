import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import '/core/services/storage.dart'; // Adjust path
import '/core/utils/id_generator.dart'; // Adjust path
import '/models/flight_airlines.dart';
import '../services/bot_toast.dart'; // Adjust path

abstract class FlightAirlinesDB {
  static final _firestore = FirebaseFirestore.instance;

  static Future<List<FlightAirlines>?> getAllFlightAirlines(
      BuildContext context) async {
    try {
      EasyLoading.show();
      final colRef = collectionRef();
      final querySnapshot = await colRef.get();
      final flightAirlines =
      querySnapshot.docs.map((doc) => doc.data()).toList();
      EasyLoading.dismiss();
      return flightAirlines;
    } catch (error) {
      EasyLoading.dismiss();
      log("Error getting airlines: $error");
      BotToastServices.showErrorMessage("Failed to load airlines: $error");
      return null;
    }
  }

  static Future<void> addFlightAirline({
    required FlightAirlines flightAirline,
  }) async {
    try {
      String id = IdGenerator.generateId(
        value1: flightAirline.flighAirLineName,
        value2: 'AirLine',
      );
      var colRef = collectionRef();
      await colRef.doc(id).set(flightAirline);

      BotToastServices.showSuccessMessage("Airline added successfully.");
    } catch (error, stackTrace) {
      log(
        "Error adding airline: $error",
        stackTrace: stackTrace,
      );
      BotToastServices.showErrorMessage("Failed to add airline: $error");
    }
  }

  static Stream<QuerySnapshot<FlightAirlines>>? getStreamFlightAirlines() {
    try {
      return collectionRef().snapshots();
    } catch (error) {
      log("Error getting stream: $error");
      BotToastServices.showErrorMessage(
          "Failed to get airline updates: $error");
      return null;
    }
  }

  static CollectionReference<FlightAirlines> collectionRef() {
    return _firestore.collection("FlightAirLine").withConverter(
      fromFirestore: (snapshot, _) =>
          FlightAirlines.fromMap(snapshot.data()!),
      toFirestore: (flightAirline, _) => flightAirline.toMap(),
    );
  }

  static Future<void> deleteFlightAirlineByName(String airlineName) async {
    try {
      final querySnapshot = await collectionRef()
          .where("flightAirLineName", isEqualTo: airlineName)
          .get();

      for (var doc in querySnapshot.docs) {
        try {
          await Storage.deleteImage(
            doc.data().flighAirLineName,
          ); // Delete associated image
          await doc.reference.delete();
        } catch (e) {
          log("Error deleting airline or image: $e");
          BotToastServices.showErrorMessage(
              "Error deleting airline or image: $e");
        }
      }

      if (querySnapshot.docs.isNotEmpty) {
        log("Airline(s) with name '$airlineName' deleted successfully.");
        BotToastServices.showSuccessMessage("Airline(s) deleted successfully.");
      } else {
        log("No airline found with the name '$airlineName'.");
        BotToastServices.showErrorMessage("No airline found with that name.");
      }
    } catch (e) {
      log("Error deleting airline(s): $e");
      BotToastServices.showErrorMessage("Error deleting airline(s): $e");
    }
  }

  static Future<FlightAirlines?> getFlightAirlineByName(
      String airlineName) async {
    try {
      final querySnapshot = await collectionRef()
          .where("flightAirLineName", isEqualTo: airlineName)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        return querySnapshot.docs.first.data();
      }
      return null;
    } catch (error) {
      log("Error getting airline: $error");
      return null;
    }
  }

  static Future<bool> updateFlightAirline(FlightAirlines flightAirline) async {
    try {
      final querySnapshot = await collectionRef()
          .where("flightAirLineName", isEqualTo: flightAirline.flighAirLineName)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        await querySnapshot.docs.first.reference.update(flightAirline.toMap());
        return true;
      }
      return false;
    } catch (error) {
      log("Error updating airline: $error");
      return false;
    }
  }

  static Future<List<FlightAirlines>> getAllAirlines() {
    return collectionRef().get().then(
          (value) => value.docs
              .map(
                (e) => e.data(),
              )
              .toList(),
        );
  }
}
