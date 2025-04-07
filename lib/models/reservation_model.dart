import 'package:travel_go/models/flight.dart';
import 'package:travel_go/models/flight_departures.dart';
import 'package:travel_go/models/trip_data_model.dart';
import 'package:travel_go/modules/layout/pages/admin/pages/trip_departures/data/model/trip_departure_data_model.dart';

import 'hotel_model.dart';

class ReservationModel {
  String id;

  final String uid;

  final TripDepartureDataModel? trip;

  final Hotel? hotel;

  final Flight? flight;

  ReservationModel({
    required this.uid,
    required this.id,
    required this.trip,
    required this.hotel,
    required this.flight,
  });

  factory ReservationModel.fromJson(Map<String, dynamic> json) {
    return ReservationModel(
      uid: json['uid'],
      id: json['id'],
      trip: json['trip'] != null
          ? TripDepartureDataModel.fromMap(json['trip'])
          : null,
      hotel: json['hotel'] != null ? Hotel.fromMap(json['hotel']) : null,
      flight: json['flight'] != null ? Flight.fromMap(json['flight']) : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'uid': uid,
      'trip': trip?.toMap(),
      'hotel': hotel?.toMap(),
      'flight': flight?.toMap(),
    };
  }
}
