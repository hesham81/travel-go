import 'package:flutter/material.dart';
import '../../../../../../../models/trip.dart';

class SelectedAdminTrip extends StatefulWidget {
  static const routeName = '/selected-admin-trip';

  const SelectedAdminTrip({super.key});

  @override
  State<SelectedAdminTrip> createState() => _SelectedAdminTripState();
}

class _SelectedAdminTripState extends State<SelectedAdminTrip> {
  @override
  Widget build(BuildContext context) {
    Trip data = ModalRoute.of(context)!.settings.arguments as Trip;
    return Scaffold(
      appBar: AppBar(
        title: Text("${data.title}"),
      ),
    );
  }
}
