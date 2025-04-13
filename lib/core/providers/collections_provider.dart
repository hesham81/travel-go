import 'package:flutter/material.dart';
import 'package:travel_go/models/reservation_model.dart';
import 'package:travel_go/modules/layout/pages/admin/pages/trip_departures/data/model/trip_departure_data_model.dart';
import '/core/utils/company_collections.dart';
import '/models/trip_data_model.dart';
import '/modules/layout/pages/admin/menna/trippp/model/company_model.dart';
import '/modules/layout/pages/admin/menna/trippp/utils/trips_collections.dart';

class CollectionsProvider extends ChangeNotifier {
  List<Company> _companies = [];
  List<TripDataModel> _trips = [];
  List<TripDepartureDataModel> _departures = [];
  ReservationModel? reservation;

  void setReservation(ReservationModel? value) {
    reservation = value;
    notifyListeners();
  }

  ReservationModel? get getReservation => reservation;

  CollectionsProvider() {
    getAllCompanies();
    getAllTrips();
  }

  getAllCompanies() async {
    await CompanyCollections.getAllCompany().then(
      (value) {
        _companies = value;
      },
    );
    notifyListeners();
  }

  // getAllDepartures(TripDataModel trip) async {
  //   await TripDeparturesCollection.getTripDeparture(trip).then(
  //     (value) {
  //       _departures = value;
  //       print(value.first.from);
  //     },
  //   );
  //   notifyListeners();
  // }

  getAllTrips() async {
    await TripCollections.getListOfTrips().then((value) {
      _trips = value;
    });
    notifyListeners();
  }

  List<TripDepartureDataModel> get getAllDeparturesData => _departures;

  List<Company> get getAllCompaniesData => _companies;

  List<TripDataModel> get getAllTripsData => _trips;
}
