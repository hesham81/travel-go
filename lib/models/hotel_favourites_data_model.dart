class HotelFavouritesDataModel {
  final String userId;

  List<String> hotels;

  HotelFavouritesDataModel({
    required this.userId,
    required this.hotels,
  });

  factory HotelFavouritesDataModel.fromJson(Map<String, dynamic> json) =>
      HotelFavouritesDataModel(
        userId: json["userId"],
        hotels: List<String>.from(json["hotels"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "hotels": List<dynamic>.from(hotels.map((x) => x)),
      };

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HotelFavouritesDataModel &&
          runtimeType == other.runtimeType &&
          userId == other.userId &&
          hotels == other.hotels;

  @override
  int get hashCode => userId.hashCode ^ hotels.hashCode;
}
