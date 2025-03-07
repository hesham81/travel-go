import 'package:flutter/material.dart';
import 'package:travel_go/core/utils/company_collections.dart';
import 'package:travel_go/models/trip_data_model.dart';
import 'package:travel_go/modules/layout/pages/admin/menna/trippp/model/company_model.dart';
import 'package:travel_go/modules/layout/pages/admin/menna/trippp/utils/trips_collections.dart';

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

  getAllTrips() async {
    await TripCollections.getListOfTrips().then((value) {
      _trips = value;
    });
    notifyListeners();
  }

  List<TripDataModel> get getAllTripsData => _trips;
}
