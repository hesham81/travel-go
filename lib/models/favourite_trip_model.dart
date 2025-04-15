import 'package:travel_go/models/flight.dart';
import 'package:travel_go/models/hotel_model.dart';
import 'package:travel_go/models/trip_data_model.dart';

class FavouriteTripDataModel {
   List<TripDataModel>? trips;
  final String uid;

  FavouriteTripDataModel({
    required this.uid,
    this.trips,
  });

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'trips': trips?.map((trip) => trip.toMap()).toList() ?? [],
    };
  }

  factory FavouriteTripDataModel.fromMap(Map<String, dynamic> map) {
    return FavouriteTripDataModel(
      uid: map['uid'] ?? '',
      trips: map['trips'] != null
          ? List<TripDataModel>.from(
              map['trips']?.map((trip) => TripDataModel.fromMap(trip)) ?? [])
          : [],
    );
  }
}
