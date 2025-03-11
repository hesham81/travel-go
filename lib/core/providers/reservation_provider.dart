import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:location/location.dart';
import 'package:travel_go/models/credit_card_model.dart';
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
  CreditCardModel? card ;


  setCard(CreditCardModel value) {
    card = value;
    notifyListeners();
  }
  CreditCardModel? get getCard => card;

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
  String getMonthAbbreviation(int month) {
    const List<String> monthAbbreviations = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ];
    return monthAbbreviations[month - 1];
  }

  String getDayOfWeek(DateTime date) {
    return DateFormat('EEEE').format(date);
  }
}
