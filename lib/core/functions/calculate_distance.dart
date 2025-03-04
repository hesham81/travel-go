//
//
// import 'package:latlong2/latlong.dart';
//
// abstract class Distance
// {
//   void clacDistance(LatLng currentPosition , LatLng destination)
//   {
//     double distance = Geolocator.distanceBetween(
//       currentPosition.latitude,
//       currentPosition.longitude,
//       destination.latitude,
//       destination.longitude,
//     ) / 1000;
//   }
//
// }
import 'dart:math';

int calculateDistance({
  required double lat1,
  required double lon1,
  required double lat2,
  required double lon2,
}) {
  const double earthRadius = 6371;

  double lat1Rad = _toRadians(lat1);
  double lon1Rad = _toRadians(lon1);
  double lat2Rad = _toRadians(lat2);
  double lon2Rad = _toRadians(lon2);

  double dLat = lat2Rad - lat1Rad;
  double dLon = lon2Rad - lon1Rad;

  double a = pow(sin(dLat / 2), 2) +
      cos(lat1Rad) * cos(lat2Rad) * pow(sin(dLon / 2), 2);
  double c = 2 * atan2(sqrt(a), sqrt(1 - a));

  double distance = earthRadius * c;
  return distance.round();
}

double _toRadians(double degrees) {
  return degrees * (pi / 180);
}
