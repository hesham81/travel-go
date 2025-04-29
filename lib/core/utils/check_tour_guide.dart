import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:travel_go/models/tour_guide_data_model.dart';

abstract class TourGuideServices {
  static final _firestore =
      FirebaseFirestore.instance.collection("tour_guides");

  static CollectionReference<TourGuideDataModel> _collectionReference() =>
      _firestore.withConverter(
        fromFirestore: (snapshot, options) => TourGuideDataModel.fromJson(
          snapshot.data()!,
        ),
        toFirestore: (value, options) => value.toJson(),
      );

  static Future<bool> checkIfTourGuideExists(String id) async {
    try {
      await _collectionReference().doc(id).get();
      return true;
    } catch (error) {
      return false;
    }
  }

  static Stream<QuerySnapshot<TourGuideDataModel>> getTourGuide(String id)  {
    return _collectionReference().snapshots();
  }
}
