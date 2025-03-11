import 'package:travel_go/models/flight.dart';
import 'package:travel_go/models/hotel_model.dart';
import 'package:travel_go/models/trip_data_model.dart';

class FavouriteDataModel {
  final String id;
  final List<TripDataModel>? trips;

  final List<Hotel>? hotels;
  final List<Flight>? flights;
  final String uid;

  FavouriteDataModel({
    required this.id,
    required this.uid,
    this.trips,
    this.hotels,
    this.flights,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'uid': uid,
      'trips': trips?.map((trip) => trip.toMap()).toList() ?? [],
      'hotels': hotels?.map((hotel) => hotel.toMap()).toList() ?? [],
      'flights': flights?.map((flight) => flight.toMap()).toList() ?? [],
    };
  }

  factory FavouriteDataModel.fromMap(Map<String, dynamic> map) {
    return FavouriteDataModel(
      id: map['id'] ?? '',
      uid: map['uid'] ?? '',
      trips: map['trips'] != null
          ? List<TripDataModel>.from(
              map['trips']?.map((trip) => TripDataModel.fromMap(trip)) ?? [])
          : [],
      hotels: map['hotels'] != null
          ? List<Hotel>.from(
              map['hotels']?.map((hotel) => Hotel.fromMap(hotel)) ?? [])
          : [],
      flights: map['flights'] != null
          ? List<Flight>.from(
              map['flights']?.map((flight) => Flight.fromMap(flight)) ?? [])
          : [],
    );
  }
}
