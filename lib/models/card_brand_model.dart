class CardBrand {
  final String brand;
  final String cardNumber;

  CardBrand({
    required this.brand,
    required this.cardNumber,
  });

  factory CardBrand.fromJson(Map<String, dynamic> json) {
    return CardBrand(
      brand: json['brand'],
      cardNumber: json['cardNumber'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'brand': brand,
      'cardNumber': cardNumber,
    };
  }
}