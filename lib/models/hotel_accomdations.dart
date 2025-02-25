class HotelAccomdations {

  final String accomdationType;

  double price;

  int totalRooms;


  HotelAccomdations({
    required this.accomdationType,
    required this.price,
    required this.totalRooms,
  });

  Map<String, dynamic> toMap() {
    return {
      'accomdationType': accomdationType,
      'price': price,
      'totalRooms': totalRooms,
    };
  }

  factory HotelAccomdations.fromMap(Map<String, dynamic> map) {
    return HotelAccomdations(
      accomdationType: map['accomdationType'],
      price: map['price'],
      totalRooms: map['totalRooms'],
    );
  }
}
