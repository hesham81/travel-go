import 'package:flutter/cupertino.dart';
import 'package:flutter_map/flutter_map.dart';

class HotelAdminProvider extends ChangeNotifier {
  List<Marker> _marker = [];

  List<Marker> get getMarker => _marker;

  void setMarker(Marker val) {
    _marker.clear();
    _marker.add(val);
    notifyListeners();
  }
}
