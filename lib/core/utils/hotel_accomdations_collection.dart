import 'package:cloud_firestore/cloud_firestore.dart';
import '/models/hotel_accomdations.dart';

import '../../models/hotel_model.dart';

abstract class HotelAccomdationsCollections {
  static final _firestore =
      FirebaseFirestore.instance.collection("Hotel_Accomdations");

  static CollectionReference<HotelAccomdations> _colRef() {
    return _firestore.withConverter(
      fromFirestore: (snapshot, options) =>
          HotelAccomdations.fromMap(snapshot.data()!),
      toFirestore: (value, _) => value.toMap(),
    );
  }

  static addHotelAccomdations(HotelAccomdations model) async {
    try {
      await _colRef().add(model);
      print("object");
    } catch (error) {
      print("Error");
    }
  }

}
