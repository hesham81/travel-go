import 'package:geocoding/geocoding.dart';
import 'package:location/location.dart';

abstract class LocationsServices {
  static Future<String?> getCurrentCityLocations(LocationData locationData) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        locationData.latitude!,
        locationData.longitude!,
      );

      if (placemarks.isNotEmpty) {
        Placemark placeMark = placemarks[0];
        String city = placeMark.administrativeArea ?? placeMark.subAdministrativeArea ?? "Unknown City";
        String country = placeMark.country ?? placeMark.country ?? "Unknown Country";
        String street = placeMark.street ?? placeMark.street ?? "Unknown Country";
        print("Current City Location: $city");
        return "$street, $city, $country";
      } else {
        print("No location data found for the given coordinates.");
        return null;
      }
    } catch (e) {
      print("Error fetching city name: $e");
      return null;
    }
  }
}