import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import '/core/utils/firebase_auth_services.dart';
import '/core/functions/city_locations.dart';
import '/modules/layout/pages/admin/pages/trip_departures/data/model/trip_departure_data_model.dart';

class ReservationProvider extends ChangeNotifier {
  TripDepartureDataModel? selectedDeparture;
  late User? user;
  var _valid = true ;
  Location _location = Location();
  LocationData? _locationData;
  int totalUsers = 0;
  String? _address;


  ReservationProvider() {
    _getCurrentLocationData();
    user = FirebaseAuthServices.getCurrentUserData();
    print("Address From Provider : $_address");

  }

  void setValid(bool value) {
    _valid = value;
    notifyListeners();
  }

  void setSelectedDeparture(TripDepartureDataModel? value) {
    selectedDeparture = value;
    notifyListeners();
  }
  void setTotalUsers(int value) {
    totalUsers = value;
    notifyListeners();
  }


  int get getTotalUsers => totalUsers;
  String? get getAddress => _address;
  bool get getValid => _valid;
  TripDepartureDataModel? get getSelectedDeparture => selectedDeparture;

  _getCurrentLocationData() async {
    if (_location.hasPermission() == PermissionStatus.denied) {
      await _location.requestPermission();
    } else {
      _locationData = await _location.getLocation();
      await LocationsServices.getCurrentCityLocations(_locationData!).then(
        (value) => _address = value,
      );
      notifyListeners();
    }
  }
}
