class TripProgramDay {
  String? id;
  DateTime startDate;
  DateTime endDate;

  TripProgramDay({
    required this.id,
    required this.startDate,
    required this.endDate,
  });
  int calcTotalDays()
  {
    return endDate.difference(startDate).inDays;
  }
}
