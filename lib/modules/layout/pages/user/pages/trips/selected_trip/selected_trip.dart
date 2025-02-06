import 'package:flutter/material.dart';
import '/core/utils/firestore_services.dart';
import '/models/hotel_model.dart';
import '../../../../../../../models/trip.dart';
import '/models/trip_model.dart';

class SelectedTrip extends StatefulWidget {
  static const routeName = '/selected-trip';

  SelectedTrip({super.key});

  @override
  State<SelectedTrip> createState() => _SelectedTripState();
}

class _SelectedTripState extends State<SelectedTrip> {

  @override
  Widget build(BuildContext context) {
    TripModel data = ModalRoute.of(context)!.settings.arguments as TripModel;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          data.title
        ),
      ),

    );
  }
}
