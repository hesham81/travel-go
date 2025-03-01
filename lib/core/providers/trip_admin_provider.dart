import 'package:currency_picker/currency_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geocoding/geocoding.dart';
import 'package:latlong2/latlong.dart';
import 'package:travel_go/core/utils/company_collections.dart';
import 'package:travel_go/modules/layout/pages/admin/menna/trippp/model/company_model.dart';
import '/models/attractions_model.dart';
import '/models/flight.dart';
import '/models/hotel_model.dart';
import '/modules/layout/pages/admin/menna/trippp/model/program_day_model.dart';
import '/modules/layout/pages/admin/menna/trippp/model/programs.dart';

class TripAdminProvider extends ChangeNotifier {
  int _totalDays = 0;
  Flight? _selectionFlight;
  Hotel? _selectionHotel;
  AttractionsModel? _selectedAttraction;
  Company? _selectedCompany;
  LatLng? attractionLocation;

  Currency? _currency;

  Company? get getSelectedCompany => _selectedCompany;

  void setAttractionLocation(LatLng location) {
    attractionLocation = location;
    notifyListeners();
  }

  LatLng? get getAttractionLocation => attractionLocation;

  void setSelectedCompany(Company selectedCompany) {
    _selectedCompany = selectedCompany;
    notifyListeners();
  }

  int get getTotalDays => _totalDays;
  List<Marker> _markersFromTo = [];
  List<ProgramDayModel> _daySpecificProgram = [];
  String? source;
  List<Company> _companies = [];

  TripAdminProvider() {
    _getAllCompanies();
  }

  _getAllCompanies() {
    CompanyCollections.getAllCompany().then(
      (value) {
        _companies = value;
        notifyListeners();
      },
    );
  }

  get getAllCompanies {
    (_companies.first.companyName);
    return _companies;
  }

  String? destination;

  Future<void> getSourceCity() async {
    if (_markersFromTo.isEmpty) {
      print('No markers available.');
      return;
    }

    var firstMarker = _markersFromTo[0];

    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        firstMarker.point.latitude, // Latitude first
        firstMarker.point.longitude, // Longitude second
      );

      if (placemarks.isNotEmpty) {
        Placemark sourcePlacemark = placemarks[0];
        source = sourcePlacemark.country ?? 'Unknown City';
        print('Source City: $source');
      } else {
        print('No placemark found for the given coordinates.');
      }
    } catch (e) {
      print('Error fetching source city: $e');
    }
  }

  void setSelectedAttraction(AttractionsModel? selectedAttraction) {
    _selectedAttraction = selectedAttraction;
  }

  AttractionsModel? get getSelectedAttraction => _selectedAttraction;

  Currency? get getCurrency => _currency;

  void setCurrency(Currency currency) {
    _currency = currency;
    notifyListeners();
  }

  List<Program> _programs = [];

  Flight? get getSelectionFlight => _selectionFlight;

  Hotel? get getSelectionHotel => _selectionHotel;

  List<ProgramDayModel> get getDaySpecificProgram => _daySpecificProgram;

  void setTotalDays(int totalDays) {
    _totalDays = totalDays;
    for (int i = 1; i <= _totalDays; i++) {
      {
        _daySpecificProgram.add(
          ProgramDayModel(
            dayNumber: (i),
            program: [],
          ),
        );
      }
    }
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
    if (_markersFromTo.length == 2) {
      _markersFromTo.clear();
    }
    _markersFromTo.add(marker);
    notifyListeners();
  }

  List<Marker> get getMarkers => _markersFromTo;

  void addSpecificProgramDay(
    Program program,
    int dayNumber,
    int programNumber,
  ) {
    _daySpecificProgram[dayNumber].program.insert(programNumber, program);
    notifyListeners();
  }

  List<Program> getProgramFromDay(int dayNumber) {
    return _daySpecificProgram[dayNumber].program;
  }
}
