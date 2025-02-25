import 'package:cloud_firestore/cloud_firestore.dart';
import '/core/utils/id_generator.dart';

import '../../modules/layout/pages/admin/menna/trippp/model/programs.dart';

abstract class ProgramsCollections {
  static final _firestore = FirebaseFirestore.instance.collection("Programs");

  static CollectionReference<Program> _colRef() {
    return _firestore.withConverter(
      fromFirestore: (snapshot, options) => Program.fromMap(snapshot.data()!),
      toFirestore: (value, _) => value.toMap(),
    );
  }

  static addProgram(Program model) async {
    try {
      var id = IdGenerator.generateId(
          value1: model.programTitle, value2: model.programDetails);
      await _colRef().doc(id).set(model);
      print("Done");
    } catch (error) {
      print("Error ${error}");
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
}
