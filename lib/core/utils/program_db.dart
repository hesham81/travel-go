import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:travel_go/models/trip_program_line.dart';

abstract class ProgramDB {
  static final _firestore = FirebaseFirestore.instance;

  static CollectionReference<TripProgramLine> collectionRef() {
    return _firestore.collection("TripProgramLine").withConverter(
          fromFirestore: (snapshot, _) =>
              TripProgramLine.fromMap(snapshot.data()!),
          toFirestore: (program, _) => program.toMap(),
        );
  }

  static getStreamProgramData() {
    try {
      var colRef = collectionRef();
      return colRef.snapshots();
    } catch (error) {
      print(error.toString());
    }
    return null;
  }
}
