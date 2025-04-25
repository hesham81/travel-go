
class TripDepartureDataModel {
  final String tripId;
  final String id;

   DateTime from;

   DateTime to;

   int availableSeats;



  TripDepartureDataModel({
    required this.tripId,
    required this.from,
    required this.to,
    required this.availableSeats,
    required this.id,
  });

  Map<String, dynamic> toMap() {
    return {
      'tripId': tripId,
      'from': from.millisecondsSinceEpoch,
      'to': to.millisecondsSinceEpoch,
      'availableSeats': availableSeats,
      'id': id,
    };
  }

  factory TripDepartureDataModel.fromMap(Map<String, dynamic> map) {
    return TripDepartureDataModel(
      tripId: map['tripId'],
      from: DateTime.fromMillisecondsSinceEpoch(map['from']),
      to: DateTime.fromMillisecondsSinceEpoch(map['to']),
      availableSeats: map['availableSeats'],
      id: map['id'],
    );
  }
}
