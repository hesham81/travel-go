import 'package:flutter/material.dart';
import '/models/flight.dart';
import '/core/utils/company_collections.dart';
import '/core/utils/flight_collections.dart';
import '/core/utils/hotels_db.dart';
import '/core/utils/programs_collections.dart';
import '/core/utils/trip_departures_collections.dart';
import '/modules/layout/pages/admin/menna/trippp/model/company_model.dart';
import '/modules/layout/pages/admin/menna/trippp/model/programs.dart';
import '/models/hotel_model.dart';
import '/core/extensions/extensions.dart';
import '/core/theme/app_colors.dart';
import '/modules/layout/pages/admin/widget/trip_admin_browse_widget.dart';
import 'model/trip_departures.dart';
import 'model/trip_model.dart';

class TripAdminScreen extends StatefulWidget {
  const TripAdminScreen({super.key});

  @override
  State<TripAdminScreen> createState() => _TripAdminScreenState();
}

class _TripAdminScreenState extends State<TripAdminScreen> {
  List<TripDataProgramModel> trips = [];
  List<Company> companies = [];

  List<Hotel> hotels = [];

  List<TripDepartures> departures = [];

  List<Program> programs = [];

  List<Flight> flights = [];

  _loadHotels() {}

  @override
  void initState() {
    super.initState();
    HotelsDB.getAllHotels().then(
      (value) {
        hotels = value;
      },
    );
    FlightCollections.getAllFlight().then(
      (value) {
        flights = value;
        print(flights.first);
      },
    );
    CompanyCollections.getAllCompany().then(
      (value) {
        companies = value;
      },
    );
    TripDeparturesCollection.getAllTripDepartures().then(
      (value) {
        departures = value;
      },
    );
    ProgramsCollections.getAllPrograms().then(
      (value) {
        programs = value;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).textTheme;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text(
          "Travel Go",
          style: theme.titleLarge!.copyWith(
            color: AppColors.whiteColor,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            0.01.height.hSpace,
            ListView.separated(
              itemBuilder: (context, index) => TripAdminBrowseWidget(
                model: trips[index],
              ),
              separatorBuilder: (context, index) => 0.01.height.hSpace,
              itemCount: trips.length,
            ),
          ],
        ).hPadding(0.03.width),
      ),
    );
  }
}
