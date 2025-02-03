import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:travel_go/core/utils/firestore_services.dart';
import 'package:travel_go/models/trip.dart';
import 'package:travel_go/models/trip_model.dart';

class SelectedTrip extends StatelessWidget {
  static const routeName = '/selected-trip';


  const SelectedTrip({super.key});

  @override
  Widget build(BuildContext context) {
    TripModel data = ModalRoute.of(context)!.settings.arguments as TripModel;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "${data.title}",
        ),
      ),
    );
  }
}
