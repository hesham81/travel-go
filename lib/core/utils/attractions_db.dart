import 'package:cloud_firestore/cloud_firestore.dart';
import '/core/utils/id_generator.dart';
import '/models/attractions_model.dart';

abstract class AttractionsDB {
  static final _firestore =
      FirebaseFirestore.instance.collection("Attractions");

  static CollectionReference<AttractionsModel> _collectionRef() {
    return _firestore.withConverter(
      fromFirestore: (snapshot, _) =>
          AttractionsModel.fromJson(snapshot.data()!),
      toFirestore: (attractions, _) => attractions.toJson(),
    );
  }

  static Future<bool> addAttractionsData(AttractionsModel model) async {
    try {
      var colRef = _collectionRef();
      String id = IdGenerator.generateId(
        value1: model.location,
        value2: model.description,
      );
      await colRef.doc(id).set(model);
      return true;
    } catch (error) {
      return false;
    }
  }

  static Stream<QuerySnapshot<AttractionsModel>> getAllAttractions() {
    return _collectionRef().snapshots();
  }

  static deleteAttraction(AttractionsModel model) {
    try {
      String id = IdGenerator.generateId(
        value1: model.location,
        value2: model.description,
      );
      _collectionRef().doc(id).delete();
      return true;
    } catch (error) {
      return false;
    }
  }

  static editAttraction(AttractionsModel model )
  {
    try {
      String id = IdGenerator.generateId(
        value1: model.location,
        value2: model.description,
      );
      _collectionRef().doc(id).set(model);
      return true;
    } catch (error) {
      return false;
    }
  }
}
