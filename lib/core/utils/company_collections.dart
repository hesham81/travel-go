import 'package:cloud_firestore/cloud_firestore.dart';

import '/modules/layout/pages/admin/menna/trippp/model/company_model.dart';
import 'id_generator.dart';

abstract class CompanyCollections {
  static final _firestore = FirebaseFirestore.instance.collection("Company");

  static CollectionReference<Company> _colRef() {
    return _firestore.withConverter(
      fromFirestore: (snapshot, options) => Company.fromJson(
        snapshot.data()!,
      ),
      toFirestore: (value, _) => value.toJson(),
    );
  }

  static addCompany(Company model) async {
    try {
      var id = IdGenerator.generateId(
          value1: model.companyName, value2: model.companyWebsite);
      await _colRef().doc(id).set(model);
      print("Done");
    } catch (error) {
      print("Error ${error}");
    }
  }

  static Future<List<Company>> getAllCompany() {
    return _colRef().get().then(
          (value) => value.docs
              .map(
                (e) => e.data(),
              )
              .toList(),
        );
  }
}
