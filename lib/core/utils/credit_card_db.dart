import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:travel_go/models/credit_card_model.dart';

abstract class CreditCardDB {
  static final _colRef =
      FirebaseFirestore.instance.collection("CreditCard").withConverter(
            fromFirestore: (snapshot, options) =>
                CreditCardModel.fromMap(snapshot.data()!),
            toFirestore: (value, _) => value.toMap(),
          );

  static Future<CreditCardModel?> getCreditData(String creditNumber) async {
    CreditCardModel? creditCredintial =
        await _colRef.doc(creditNumber).get().then(
              (value) => value.data(),
            );
    return creditCredintial;
  }

  static Future<void> addCreditData(CreditCardModel card)
  {
    return _colRef.doc(card.creditNumber).set(card);
  }
  static Future<bool> withDraw(String creditNumber, double amount) async {
    CreditCardModel? card = await getCreditData(creditNumber).then(
      (value) => value,
    );
    if (card != null && card.balance! >= amount) {
      await _colRef
          .doc(creditNumber)
          .update({"balance": card.balance! - amount});
      return true;
    } else {
      return false;
    }
  }
}
