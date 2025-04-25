import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';
import 'package:travel_go/core/functions/calculate_distance.dart';
import 'package:travel_go/models/credit_card_model.dart';
import 'package:travel_go/models/flight_departures.dart';
import 'package:travel_go/models/hotel_accomdations_data_model.dart';
import 'package:travel_go/models/reservation_model.dart';
import '../../models/flight.dart';
import '../../models/hotel_model.dart';
import '../../models/seat_economy.dart';
import '../../models/trip_data_model.dart';
import '../../modules/layout/pages/admin/menna/trippp/utils/trips_collections.dart';
import '/core/utils/firebase_auth_services.dart';
import '/core/functions/city_locations.dart';
import '/modules/layout/pages/admin/pages/trip_departures/data/model/trip_departure_data_model.dart';

class ReservationProvider extends ChangeNotifier {
  TripDepartureDataModel? selectedDeparture;
  late User? user;
  var _valid = true;
  late bool _reserveHotel;
  ReservationModel? reservation;
  Hotel? _hotel;

  HotelAccomdationsDataModel? _accomdationsDataModel;

  HotelAccomdationsDataModel? get getAccomdationsDataModel =>
      _accomdationsDataModel;

  void setAccomdationsDataModel(HotelAccomdationsDataModel? value) {
    _accomdationsDataModel = value;
    notifyListeners();
  }

  Hotel? get getHotel => _hotel;

  void setHotel(Hotel value) {
    _hotel = value;
    notifyListeners();
  }

  late bool _reserveFlight;

  SeatEconomyDataModel? _seatEconomyDataModel;

  SeatEconomyDataModel? get getSeatEconomyDataModel => _seatEconomyDataModel;

  void setSeatEconomyDataModel(SeatEconomyDataModel value) {
    _seatEconomyDataModel = value;
    notifyListeners();
  }

  TripDataModel? _trip;

  TripDataModel? get getTrip => _trip;

  void setTrip(TripDataModel value) {
    _trip = value;
    notifyListeners();
  }

  Flight? _flight;

  Flight? get getFlight => _flight;

  void setFlight(Flight value) {
    _flight = value;
    notifyListeners();
  }

  bool get getReserveHotel => _reserveHotel;

  bool get getReserveFlight => _reserveFlight;

  void setReserveHotel(bool value) {
    _reserveHotel = value;
    notifyListeners();
  }

  void setReserveFlight(bool value) {
    _reserveFlight = value;
    notifyListeners();
  }

  Location _location = Location();
  LocationData? _locationData;
  int totalUsers = 0;
  String? _address;
  FlightDeparture? _flightDeparture;

  FlightDeparture? get getFlightDeparture => _flightDeparture;

  void setFlightDeparture(FlightDeparture value) {
    _flightDeparture = value;
    notifyListeners();
  }

  CreditCardModel? card;

  ReservationModel? get getReservation => reservation;

  void setReservation(ReservationModel? value) {
    reservation = value;
    notifyListeners();
  }

  Future<void> _getTrip() async {
    _trip = await TripCollections.getTrip(selectedDeparture!.tripId);
    notifyListeners();
  }

  int calculateDistanceFromLocation(LatLng point) {
    return calculateDistance(
      lat1: point.latitude,
      lon1: point.longitude,
      lat2: _locationData?.latitude ?? 0,
      lon2: _locationData?.longitude ?? 0,
    );
  }

  LatLng get location => LatLng(
        _locationData!.latitude!,
        _locationData!.longitude!,
      );

  void _getUsersData() {
    user = FirebaseAuthServices.getCurrentUserData();
    notifyListeners();
  }

  void resetToken() {
    _getUsersData();
  }

  setCard(CreditCardModel value) {
    card = value;
    notifyListeners();
  }

  CreditCardModel? get getCard => card;

  ReservationProvider() {
    _reserveHotel = false;
    _reserveFlight = false;
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
