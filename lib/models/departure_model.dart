class Departures {
  final DateTime startDate;
  final DateTime endDate;
  final String source;

  final String destination;

  final int hours;
  final int minutes;

  Departures({
    required this.startDate,
    required this.endDate,
    required this.hours,
    required this.minutes,
    required this.source,
    required this.destination,
  });
}
