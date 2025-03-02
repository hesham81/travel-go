import 'dart:convert';
import 'package:http/http.dart' as http;

abstract class MapsServices {
  static Future<String?> getCityName(double latitude, double longitude) async {
    final String url =
        'https://nominatim.openstreetmap.org/reverse?format=json&lat=$latitude&lon=$longitude';

    try {
      String? city = "";
      String? country = "";

      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        city = data['address']['city'] ??
            data['address']['town'] ??
            data['address']['village'];
        country = data['address']['country'] ?? "Unknown Country";
      }
      print(" $city and country is ${country.toString()}");
      return "$city , $country";
    } catch (e) {
      print(e.toString());
      return "Can't Be Located ";
    }
  }
}
