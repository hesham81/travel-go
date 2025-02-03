import 'package:travel_go/core/utils/firestore_services.dart';
import 'package:travel_go/core/utils/hotels_db.dart';

class Hotel {
  final int availableRooms;
  final String hotelLocation;
  final String hotelName;
  final double hotelRating;
  final int totalRooms;

  Hotel({
    required this.availableRooms,
    required this.hotelLocation,
    required this.hotelName,
    required this.hotelRating,
    required this.totalRooms,
  });

  // Convert the Hotel object to a Map
  Map<String, dynamic> toMap() {
    return {
      'availableRooms': availableRooms,
      'hotelLocation': hotelLocation,
      'hotelName': hotelName,
      'hotelRating': hotelRating,
      'totalRooms': totalRooms,
    };
  }

  // Create a Hotel object from a Map
  factory Hotel.fromMap(Map<String, dynamic> map) {
    return Hotel(
      availableRooms: map['availableRooms'],
      hotelLocation: map['hotelLocation'],
      hotelName: map['hotelName'],
      hotelRating: map['hotelRating'],
      totalRooms: map['totalRooms'],
    );
  }
  static allHotels(){
    Future<List<Hotel>> hotels = HotelsDB.getAllHotels();
    hotels.then((hotel){
      print(hotel.length);
    });
  }
}