import 'package:flutter/material.dart';
import 'package:travel_go/core/utils/company_collections.dart';
import 'package:travel_go/models/trip_data_model.dart';
import 'package:travel_go/modules/layout/pages/admin/menna/trippp/model/company_model.dart';
import 'package:travel_go/modules/layout/pages/admin/menna/trippp/utils/trips_collections.dart';

class CollectionsProvider extends ChangeNotifier {
  List<Company> _companies = [];
  List<TripDataModel> _trips = [];

  _getAllCompanies() async {
    await CompanyCollections.getAllCompany().then(
          (value) {
        _companies = value;
      },
    );
    notifyListeners();
  }

  getAllTrips() async {
    _trips = await TripCollections.getListOfTrips().then(
          (value) => value,
    );
    notifyListeners();
  }

  List<TripDataModel> get getAllTripsData => _trips;
}
