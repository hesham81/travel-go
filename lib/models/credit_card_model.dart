class CreditCardModel {
  final String creditNumber;

  final String cardHolder;

  final String cvv;

  final String expiryDate;
  final String userId;

  CreditCardModel({
    required this.creditNumber,
    required this.cardHolder,
    required this.cvv,
    required this.expiryDate,
    required this.userId,
  });

  factory CreditCardModel.fromMap(Map<String, dynamic> map) {
    return CreditCardModel(
      creditNumber: map['creditNumber'],
      cardHolder: map['cardHolder'],
      cvv: map['cvv'],
      expiryDate: map['expiryDate'],
      userId: map['userId'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'creditNumber': creditNumber,
      'cardHolder': cardHolder,
      'cvv': cvv,
      'expiryDate': expiryDate,
      'userId': userId,
    };
  }
}
