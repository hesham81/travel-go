import 'package:cloud_firestore/cloud_firestore.dart';
import '/core/utils/id_generator.dart';

import '/modules/layout/pages/admin/menna/trippp/model/programs.dart';

abstract class ProgramsCollections {
  static final _firestore = FirebaseFirestore.instance.collection("Programs");

  static CollectionReference<Program> _colRef() {
    return _firestore.withConverter(
      fromFirestore: (snapshot, options) => Program.fromMap(snapshot.data()!),
      toFirestore: (value, _) => value.toMap(),
    );
  }

  static Future<bool> addProgram(Program model) async {
    try {
      var id = IdGenerator.generateId(
          value1: model.programTitle, value2: model.programDetails);
      await _colRef().doc(id).set(model);
      return Future.value(true);
    } catch (error) {
      return Future.value(false);
    }
  }

  static Future<List<Program>> getAllPrograms() {
    return _colRef().get().then(
          (value) => value.docs
              .map(
                (e) => e.data(),
              )
              .toList(),
        );
  }

  static Stream<QuerySnapshot<Program>> getStreamPrograms() {
    return _colRef().snapshots();
  }

  static Future<String?> searchUsingProgramTitle(String programTitle) async {
    try {
      final querySnapshot =
          await _colRef().where("programTitle", isEqualTo: programTitle).get();

      if (querySnapshot.docs.isEmpty) {
        print("No documents found with the program title: $programTitle");
        return null;
      }

      return querySnapshot.docs.first.id;
    } catch (e) {
      print("Error searching using program title: $e");
      return null;
    }
  }

  static Future<bool> updateProgram(Program oldModel, Program newModel) async {
    try {
      var id;
      await searchUsingProgramTitle(oldModel.programTitle).then((value) {
        id = value;
      });
      if (id == null) return Future.value(false);
      await _colRef().doc(id).update(newModel.toMap());

      return Future.value(true);
    } catch (error) {
      print("Error ${error.toString()}");
      return Future.value(false);
    }
  }

  static Future<bool> deleteProgram(Program model) async {
    try {
      var id;
      await searchUsingProgramTitle(model.programTitle).then((value) {
        id = value;
      });
      if (id == null) return Future.value(false);
      await _colRef().doc(id).delete();
      return Future.value(true);
    } catch (error) {
      print("Error ${error.toString()}");
      return Future.value(false);
    }
  }
}
