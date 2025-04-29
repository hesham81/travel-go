class CreditCardModel {
  final String creditNumber;

  final String cvv;

  final String expiryDate;
  final String holderName;
  final String userId ;
  final double? balance;

  CreditCardModel({
    required this.creditNumber,
    required this.cvv,
    required this.expiryDate,
    required this.holderName,
    required this.userId,
    this.balance,
  });

  Map<String, dynamic> toMap() {
    return {
      'creditNumber': creditNumber,
      'cvv': cvv,
      'expiryDate': expiryDate,
      'holderName': holderName,
      'userId': userId,
      'balance': balance ?? 0,
    };
  }

  factory CreditCardModel.fromMap(Map<String, dynamic> map) {
    return CreditCardModel(
      creditNumber: map['creditNumber'] ?? '',
      cvv: map['cvv'] ?? '',
      expiryDate: map['expiryDate'] ?? '',
      holderName: map['holderName'] ?? '',
      userId: map['userId'] ?? '',
      balance: map['balance']?.toDouble() ?? 0.0,
    );
  }
}
