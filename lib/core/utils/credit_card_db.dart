import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:travel_go/core/utils/firebase_auth_services.dart';
import '/models/credit_card_model.dart';

abstract class CreditCardDB {
  static final _firestore = FirebaseFirestore.instance;

  static CollectionReference<CreditCardModel> collectionRef() {
    return _firestore.collection("CreditCard").withConverter(
          fromFirestore: (snapshot, _) =>
              CreditCardModel.fromMap(snapshot.data()!),
          toFirestore: (value, _) => value.toMap(),
        );
  }

  static Future<List<CreditCardModel>?> getAllCreditsData() async {
    try {
      List<CreditCardModel> cards = [];
      var colRef = collectionRef();
      await colRef.get().then(
        (value) {
          value.docs.map(
            (e) {
              cards.add(e.data());
            },
          );
        },
      );
      return cards;
    } catch (error) {
      return null;
    }
  }

  static Future<bool> checkIfDataValidOrNot(CreditCardModel model) async {
    try {
      await collectionRef().doc(model.cardHolder).get().then(
            (value) => value.data(),
          );
      return true;
    } catch (error) {
      return false;
    }
  }

  static addCredit(CreditCardModel model) async {
    try {
      var colRef = collectionRef();
      await colRef.doc(model.cardHolder).set(model);
    } catch (error) {
      return null;
    }
  }
}
