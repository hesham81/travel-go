import '/models/trip_data_model.dart';

class FavouriteTripDataModel {
  final String uid;

  final List<TripDataModel> trips;

  FavouriteTripDataModel({
    required this.uid,
    required this.trips,
  });

  Map<String, dynamic> toMap() {
    return {
      "uid": uid,
      "trips": trips.map((e) => e.toMap()).toList(),
    };
  }

  factory FavouriteTripDataModel.fromMap(Map<String, dynamic> map) {
    return FavouriteTripDataModel(
      uid: map["uid"],
      trips: map["trips"].map((e) => TripDataModel.fromMap(e)).toList(),
    );
  }
}
