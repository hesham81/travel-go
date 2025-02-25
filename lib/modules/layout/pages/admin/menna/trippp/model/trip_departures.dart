class TripDepartures {
  final DateTime departureDay;

  final DateTime arrivalDay;

  final int departureTime;

  final int arrivalTime;

  final int availableSeats;

  TripDepartures({
    required this.departureDay,
    required this.arrivalDay,
    required this.departureTime,
    required this.arrivalTime,
    required this.availableSeats,
  });

  factory TripDepartures.fromJson(Map<String, dynamic> json) {
    return TripDepartures(
      departureDay: DateTime.parse(json['departureDay']),
      arrivalDay: DateTime.parse(json['arrivalDay']),
      departureTime: json['departureTime'],
      arrivalTime: json['arrivalTime'],
      availableSeats: json['availableSeats'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'departureDay': departureDay.toIso8601String(),
      'arrivalDay': arrivalDay.toIso8601String(),
      'departureTime': departureTime,
      'arrivalTime': arrivalTime,
      'availableSeats': availableSeats,
    };
  }
}
