import 'package:flutter/material.dart';
import 'package:travel_go/models/flight.dart';
import 'package:travel_go/models/hotel_model.dart';

class TripAdminProvider extends ChangeNotifier {
  int _totalDays = 0;
  Flight? _selectionFlight;
  Hotel? _selectionHotel ;
  int get getTotalDays => _totalDays;

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

}
