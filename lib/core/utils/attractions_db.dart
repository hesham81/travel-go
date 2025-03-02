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
      await colRef.doc(model.id).set(model);
      return true;
    } catch (error) {
      print(error.toString());
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

  static Future<bool> editAttraction(
      AttractionsModel lastModel, AttractionsModel newModel) async {
    try {
      QuerySnapshot querySnapshot = await _firestore
          .where(
            "title",
            isEqualTo: lastModel.title,
          )
          .get();

      String docId = querySnapshot.docs.first.id;
      await _firestore.doc(docId).update(
            newModel.toJson(),
          );
      print("Attraction updated successfully!");
      return true;
    } catch (error) {
      print(
          "Error editing attraction: ${error.toString()}"); // Proper error logging
      return false;
    }
  }

  static Future<List<AttractionsModel>> getAttractionsList() {
   return  _collectionRef().get().then(
          (value) => value.docs
              .map(
                (e) => e.data(),
              )
              .toList(),
        );
  }
}
