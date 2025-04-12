import 'package:travel_go/models/hotel_accomdations_data_model.dart';


class Hotel {
  String id ;
  final int availableRooms;
  final String hotelLocation;
  final String hotelName;
  final double hotelRating;
  final int totalRooms;
  final String imageUrl;
  final List<HotelAccomdationsDataModel> accomdations;
  final double lat ;
  final double long ;
  Hotel({
    required this.lat,
    required this.long,
    this.id = "",
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
      'lat': lat,
      'long': long,
      'id': id,
      'AvailableRooms ': availableRooms,
      'HotelLocation ': hotelLocation,
      'HotelName ': hotelName,
      'HotelRating ': hotelRating,
      'TotalRooms ': totalRooms,
      'imageUrl': imageUrl,
      'accomdations':
          accomdations.map((accomdation) => accomdation.toJson()).toList(),
    };
  }

  factory Hotel.fromMap(Map<String, dynamic> map) {
    return Hotel(
      lat: map['lat'],
      long: map['long'],
      id: map['id'],
      availableRooms: map['AvailableRooms '],
      hotelLocation: map['HotelLocation '],
      hotelName: map['HotelName '],
      hotelRating: map['HotelRating '],
      totalRooms: map['TotalRooms '],
      imageUrl: map['imageUrl'],
      accomdations: List<HotelAccomdationsDataModel>.from(
        map['accomdations'].map(
          (accomdation) => HotelAccomdationsDataModel.fromJson(
            accomdation,
          ),
        ),
      ),
    );
  }
}
