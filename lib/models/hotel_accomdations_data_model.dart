class HotelAccomdationsDataModel {
  final String roomType;
  final double roomPrice;

  final int roomAvailable;

  List<String> imagesUrls = [];

  HotelAccomdationsDataModel({
    required this.roomType,
    required this.roomPrice,
    required this.roomAvailable,
    required this.imagesUrls,
  });

  factory HotelAccomdationsDataModel.fromJson(Map<String, dynamic> json) {
    return HotelAccomdationsDataModel(
      roomType: json['roomType'],
      roomPrice: json['roomPrice'],
      roomAvailable: json['roomAvailable'],
      imagesUrls: List<String>.from(json['imagesUrls']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'roomType': roomType,
      'roomPrice': roomPrice,
      'roomAvailable': roomAvailable,
      'imagesUrls': imagesUrls,
    };
  }
}
