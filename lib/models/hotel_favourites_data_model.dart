class HotelFavouritesDataModel {
  final String hotelId;

  List<String> users;

  HotelFavouritesDataModel({
    required this.hotelId,
    required this.users,
  });

  factory HotelFavouritesDataModel.fromJson(Map<String, dynamic> json) =>
      HotelFavouritesDataModel(
        hotelId: json["hotelId"],
        users: List<String>.from(json["users"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "hotelId": hotelId,
        "users": List<dynamic>.from(users.map((x) => x)),
      };

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HotelFavouritesDataModel &&
          runtimeType == other.runtimeType &&
          hotelId == other.hotelId &&
          users == other.users;

  @override
  int get hashCode => hotelId.hashCode ^ users.hashCode;
}
