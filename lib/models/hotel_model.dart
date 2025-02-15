import 'dart:developer';
class Hotel {
  final int availableRooms;
  final String hotelLocation;
  final String hotelName;
  final double hotelRating;
  final int totalRooms;
  final String imageUrl;
  static List<Hotel> hotels = [];

  Hotel({
    required this.imageUrl,
    required this.availableRooms,
    required this.hotelLocation,
    required this.hotelName,
    required this.hotelRating,
    required this.totalRooms,
  });

  Map<String, dynamic> toMap() {
    return {
      'AvailableRooms ': availableRooms,
      'HotelLocation ': hotelLocation,
      'HotelName ': hotelName,
      'HotelRating ': hotelRating,
      'TotalRooms ': totalRooms,
      'imageUrl': imageUrl,
    };
  }

  static truncateHotelsList() {
    hotels.clear();
  }

  static addNewHotel(Hotel hotel) {
    log("Hotel Added Successfully");
    hotels.add(hotel);
  }

  static List<Hotel> getAllHotels() {
    return hotels;
  }

  factory Hotel.fromMap(Map<String, dynamic> map) {
    return Hotel(
      availableRooms: map['AvailableRooms '],
      hotelLocation: map['HotelLocation '],
      hotelName: map['HotelName '],
      hotelRating: map['HotelRating '],
      totalRooms: map['TotalRooms '],
      imageUrl: map['imageUrl'],
    );
  }
}
