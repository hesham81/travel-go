import 'package:latlong2/latlong.dart';
import 'package:travel_go/models/flight.dart';
import 'package:travel_go/models/hotel_model.dart';
import 'package:travel_go/modules/layout/pages/admin/menna/trippp/model/company_model.dart';
import 'package:travel_go/modules/layout/pages/admin/menna/trippp/model/program_day_model.dart';

class TripDataModel {
  final String tripId;

  final String tripName;

  final String tripVideoUrl;

  final LatLng from;

  final LatLng to;

  final int totalGuests;

  final double price;

  final String currency;

  final Company organizedBy;

  final List<ProgramDayModel> programDetails;

  final Hotel hotel;

  final Flight flight;

  TripDataModel({
    required this.tripId,
    required this.tripName,
    required this.tripVideoUrl,
    required this.from,
    required this.to,
    required this.totalGuests,
    required this.price,
    required this.currency,
    required this.organizedBy,
    required this.programDetails,
    required this.hotel,
    required this.flight,
  });

  Map<String, dynamic> toMap() {
    return {
      'tripId': tripId,
      'tripName': tripName,
      'tripVideoUrl': tripVideoUrl,
      'from': from,
      'to': to,
      'totalGuests': totalGuests,
      'price': price,
      'currency': currency,
      'organizedBy': organizedBy.toJson(),
      'programDetails': programDetails.map((x) => x.toJson()).toList(),
      'hotel': hotel.toMap(),
      'flight': flight.toMap(),
    };
  }

  factory TripDataModel.fromMap(Map<String, dynamic> map) {
    return TripDataModel(
      tripId: map['tripId'],
      tripName: map['tripName'],
      tripVideoUrl: map['tripVideoUrl'],
      from: map['from'],
      to: map['to'],
      totalGuests: map['totalGuests'],
      price: map['price'],
      currency: map['currency'],
      organizedBy: Company.fromJson(map['organizedBy']),
      programDetails: List<ProgramDayModel>.from(
        map['programDetails']?.map(
          (x) => ProgramDayModel.fromJson(x),
        ),
      ),
      hotel: Hotel.fromMap(map['hotel']),
      flight: Flight.fromMap(map['flight']),
    );
  }
}
