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
}
