class TripProgramLine {
  final String? attractionId;

  final String day;

  final String programLocation;

  final String tripId;

  TripProgramLine({
    this.attractionId,
    required this.day,
    required this.programLocation,
    required this.tripId,
  });

  Map<String, dynamic> toMap() {
    return {
      'attractionId': attractionId,
      'day': day,
      'programLocation': programLocation,
      'tripId': tripId,
    };
  }

  factory TripProgramLine.fromMap(Map<String, dynamic> map) {
    return TripProgramLine(
      attractionId: map['attractionId'],
      day: map['day'],
      programLocation: map['programLocation'],
      tripId: map['tripId'],
    );
  }
}
