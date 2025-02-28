import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:travel_go/models/flight.dart';
import 'package:travel_go/models/hotel_model.dart';
import 'package:travel_go/modules/layout/pages/admin/menna/trippp/model/programs.dart';

class TripAdminProvider extends ChangeNotifier {
  int _totalDays = 0;
  Flight? _selectionFlight;
  Hotel? _selectionHotel;

  int get getTotalDays => _totalDays;
  LatLng? _fromLocation;
  LatLng? _toLocation;
  List<Marker> _markersFromTo = [];
  List<Program> daySpecificProgram = [];


  Flight? get getSelectionFlight => _selectionFlight;

  Hotel? get getSelectionHotel => _selectionHotel;

  void setTotalDays(int totalDays) {
    _totalDays = totalDays;
    notifyListeners();
  }

  void setSelectionFlight(Flight selectedFlight) {
    _selectionFlight = selectedFlight;
    notifyListeners();
  }

  void setSelectionHotel(Hotel selectedHotel) {
    _selectionHotel = selectedHotel;
    notifyListeners();
  }

  void addMarker(Marker marker) {
    if (_markersFromTo.length == 2)
      _markersFromTo.clear(); // No need for ?. operator
    _markersFromTo.add(marker); // No need for ?. operator
    print(_markersFromTo.length); // Debugging
    notifyListeners();
  }

  List<Marker> get getMarkers => _markersFromTo;
  void addSpecificProgramDay(Program program)
  {

  }
}
