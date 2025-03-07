import 'package:flutter/material.dart';
import 'package:travel_go/models/trip_data_model.dart';

class DepartureProvider extends ChangeNotifier {
  TripDataModel? _selectedTrip;

  TripDataModel? get getSelectedTrip => _selectedTrip;

  void  setSelectedTrip(TripDataModel? trip) {
    _selectedTrip = trip;
    notifyListeners();
  }
}
