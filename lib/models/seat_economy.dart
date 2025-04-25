class SeatEconomyDataModel {
  final String economy;
  double price;

  int totalSeats;

  SeatEconomyDataModel({
    required this.economy,
    required this.price,
    required this.totalSeats,
  });

  Map<String, dynamic> toMap() {
    return {
      'Economy': economy,
      'price': price,
      'totalSeats': totalSeats,
    };
  }
  factory SeatEconomyDataModel.fromJson(Map<String, dynamic> json) {
    return SeatEconomyDataModel(
      economy: json['Economy'],
      price: json['price'].toDouble(),
      totalSeats: json['totalSeats'],
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SeatEconomyDataModel &&
          runtimeType == other.runtimeType &&
          economy == other.economy &&
          price == other.price &&
          totalSeats == other.totalSeats;

  @override
  int get hashCode => economy.hashCode ^ price.hashCode ^ totalSeats.hashCode;
}
