class HotelReservationsDataModel {
  String id;

  final String hotelId;

  final int totalGuests;

  final double roomType;
  final DateTime checkInDate;
  final DateTime checkOutDate;
  final String uid;

  HotelReservationsDataModel({
    required this.uid,
    this.id = "",
    required this.hotelId,
    required this.totalGuests,
    required this.roomType,
    required this.checkInDate,
    required this.checkOutDate,
  }) {
    _generateHotelReservationsId();
  }

  _generateHotelReservationsId() {
    id = "${hotelId}_${checkInDate}_$checkOutDate$uid";
  }
  factory HotelReservationsDataModel.fromJson(Map<String, dynamic> json) {
    return HotelReservationsDataModel(
      uid: json['uid'],
      id: json['id'],
      hotelId: json['hotelId'],
      totalGuests: json['totalGuests'],
      roomType: json['roomType'],
      checkInDate: DateTime.fromMillisecondsSinceEpoch(json['checkInDate']),
      checkOutDate: DateTime.fromMillisecondsSinceEpoch(json['checkOutDate']),
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'hotelId': hotelId,
      'totalGuests': totalGuests,
      'roomType': roomType,
      'checkInDate': checkInDate.millisecondsSinceEpoch,
      'checkOutDate': checkOutDate.millisecondsSinceEpoch,
    };
  }
}
