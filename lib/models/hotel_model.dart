import '/models/hotel_accomdations.dart';

class Hotel {
  final int availableRooms;
  final String hotelLocation;
  final String hotelName;
  final double hotelRating;
  final int totalRooms;
  final String imageUrl;
  final List<HotelAccomdations> accomdations;

  Hotel({
    required this.imageUrl,
    required this.availableRooms,
    required this.hotelLocation,
    required this.hotelName,
    required this.hotelRating,
    required this.totalRooms,
    required this.accomdations,
  });

  Map<String, dynamic> toMap() {
    return {
      'AvailableRooms ': availableRooms,
      'HotelLocation ': hotelLocation,
      'HotelName ': hotelName,
      'HotelRating ': hotelRating,
      'TotalRooms ': totalRooms,
      'imageUrl': imageUrl,
      'accomdations':
          accomdations.map((accomdation) => accomdation.toMap()).toList(),
    };
  }

  factory Hotel.fromMap(Map<String, dynamic> map) {
    return Hotel(
      availableRooms: map['AvailableRooms '],
      hotelLocation: map['HotelLocation '],
      hotelName: map['HotelName '],
      hotelRating: map['HotelRating '],
      totalRooms: map['TotalRooms '],
      imageUrl: map['imageUrl'],
      accomdations: List<HotelAccomdations>.from(
        map['accomdations']
            .map((accomdation) => HotelAccomdations.fromMap(accomdation)),
      ),
    );
  }
}
