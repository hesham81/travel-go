import 'package:travel_go/models/flight.dart';
import 'package:travel_go/models/flight_departures.dart';
import 'package:travel_go/models/trip_data_model.dart';
import 'package:travel_go/modules/layout/pages/admin/pages/trip_departures/data/model/trip_departure_data_model.dart';

import 'hotel_model.dart';

class ReservationModel {
  String id;

  final String uid;

  final String? tripId;

  final String? hotelId;

  final String? flightId;

  ReservationModel({
    required this.uid,
    required this.id,
    required this.tripId,
    required this.hotelId,
    required this.flightId,
  });

  factory ReservationModel.fromJson(Map<String, dynamic> json) {
    return ReservationModel(
      uid: json['uid'],
      id: json['id'],
      tripId: json['trip'],
      hotelId: json['hotel'] ,
      flightId: json['flight'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'uid': uid,
      'trip': tripId,
      'hotel': hotelId,
      'flight': flightId,
    };
  }
}
