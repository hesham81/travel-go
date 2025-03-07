import 'package:flutter/material.dart';
import '/core/utils/company_collections.dart';
import '/models/trip_data_model.dart';
import '/modules/layout/pages/admin/menna/trippp/model/company_model.dart';
import '/modules/layout/pages/admin/menna/trippp/utils/trips_collections.dart';

class CollectionsProvider extends ChangeNotifier {
  List<Company> _companies = [];
  List<TripDataModel> _trips = [];

  getAllCompanies() async {
    await CompanyCollections.getAllCompany().then(
      (value) {
        _companies = value;
      },
    );
    notifyListeners();
  }

  CollectionsProvider() {
    getAllCompanies();
    getAllTrips();
  }
  List<Company> get getAllCompaniesData => _companies;

  getAllTrips() async {
    await TripCollections.getListOfTrips().then((value) {
      _trips = value;
    });
    notifyListeners();
  }

  List<TripDataModel> get getAllTripsData => _trips;
}
