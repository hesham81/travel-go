class Hotels {
  final String HotelName;
  final String HotelLocation;

  final int TotalRooms;
  final int? AvailableRooms;

  Hotels({
    required this.HotelName,
    required this.HotelLocation,
    required this.TotalRooms,
    this.AvailableRooms,
  });

  factory Hotels.fromMap(Map<String, dynamic> map) {
    return Hotels(
      HotelName: map['HotelName'],
      HotelLocation: map['HotelLocation'],
      TotalRooms: map['TotalRooms'],
      AvailableRooms: map['AvailableRooms'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'hotel_name': HotelName,
      'hotel_location': HotelLocation,
      'total_rooms': TotalRooms,
      'AvailableRooms': AvailableRooms,
    };
  }
}
