abstract class IdGenerator {
  static generateId({
    required String value1,
    required String value2,
  }) {
    var date = DateTime.now();
    String value3 = "${date.year}${date.month}${date.day}";
    return value1.substring(0, 3).trim() +
        value3 +
        value2.substring(0, 5).trim();
  }

  static generateProgramId({
    required int programNumber,
    required String programTitle,
  }) {
    return "Pro$programNumber-${programTitle.trim()}";
  }

  static generateTripId({
    required int dayNumber,
    required String tripOrganizedBy,
    required String tripTitle,
    required String from,
    required String to,
  }) {
    return "Trip-$tripOrganizedBy-${tripTitle.trim()}";
  }

  static generateAttractionId({
    required String attractionTitle,
  }) {
    return "Attraction-$attractionTitle";
  }

  static generateDepartureId({
    required String tripName,
    required String from,
    required String to,
  }) {
    return "Departure-$tripName-$from-$to";
  }
}
