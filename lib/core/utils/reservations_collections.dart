import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:travel_go/models/reservation_model.dart';

class ReservationCollections {
  static final _firestore =
      FirebaseFirestore.instance.collection("Reservations");

  static CollectionReference<ReservationModel> _colRef() {
    return _firestore.withConverter(
      fromFirestore: (snapshot, options) => ReservationModel.fromJson(
        snapshot.data()!,
      ),
      toFirestore: (value, options) => value.toMap(),
    );
  }

  static Future<void> addReservation(ReservationModel reservation) async {
    await _colRef().add(reservation);
  }

  static Future<void> deleteReservation(String id) async {
    await _colRef().doc(id).delete();
  }

  static Future<void> updateReservation(ReservationModel reservation) async {
    await _colRef().doc(reservation.id).update(reservation.toMap());
  }

  static Stream<QuerySnapshot<ReservationModel>> getReservations() {
    return _colRef().snapshots();
  }

  static Future<ReservationModel?> getReservation(String id) async {
    var res = await _colRef().doc(id).get();
    return res.data();
  }

  static Future<List<ReservationModel>> getReservationsByUid(String uid) async {
    var res = await _colRef().where("uid", isEqualTo: uid).get();
    return res.docs.map((e) => e.data()).toList();
  }
}
