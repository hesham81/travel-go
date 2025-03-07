import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel_go/core/extensions/extensions.dart';
import 'package:travel_go/core/providers/collections_provider.dart';
import 'package:travel_go/core/providers/departure_provider.dart';
import 'package:travel_go/core/theme/app_colors.dart';
import 'package:travel_go/core/widget/custom_elevated_button.dart';
import 'package:travel_go/core/widget/dividers_word.dart';
import 'package:travel_go/core/widget/labels_widget.dart';
import 'package:travel_go/models/trip_data_model.dart';
import 'package:travel_go/modules/layout/pages/admin/menna/trippp/utils/trips_collections.dart';

class NewTripDepartures extends StatefulWidget {
  const NewTripDepartures({super.key});

  @override
  State<NewTripDepartures> createState() => _NewTripDeparturesState();
}

class _NewTripDeparturesState extends State<NewTripDepartures> {
  List<TripDataModel> trips = [];

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<CollectionsProvider>(context);
    var departure = Provider.of<DepartureProvider>(context);
    var theme = Theme.of(context).textTheme;
    log("Length Of Provider is ${provider.getAllTripsData.length}");
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            departure.setSelectedTrip(null);
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
          ),
        ),
        title: Text(
          "Trip Departures",
          style: theme.titleLarge!.copyWith(
            color: AppColors.whiteColor,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Select Trip",
              style: theme.labelLarge!.copyWith(
                color: AppColors.blackColor,
              ),
            ),
            0.01.height.hSpace,
            DropdownMenu(
              width: double.maxFinite,
              onSelected: (value) {
                departure.setSelectedTrip(value);
              },
              dropdownMenuEntries: [
                for (var trip in provider.getAllTripsData)
                  DropdownMenuEntry(
                    value: trip,
                    label: trip.tripName,
                  ),
              ],
            ),
            Visibility(
              visible: departure.getSelectedTrip != null,
              child: Column(
                children: [
                  0.01.height.hSpace,
                  DividersWord(text: departure.getSelectedTrip?.tripName ?? ""),
                  0.01.height.hSpace,
                  LabelsWidget(
                    label: "Trip Id : ",
                    value: departure.getSelectedTrip?.tripId ?? "",
                  ),
                  0.01.height.hSpace,
                  LabelsWidget(
                    label: "Trip Name : ",
                    value: departure.getSelectedTrip?.tripName ?? "",
                  ),
                  0.01.height.hSpace,
                  LabelsWidget(
                    label: "Source : ",
                    value: departure.getSelectedTrip?.source ?? '',
                  ),
                  0.01.height.hSpace,
                  LabelsWidget(
                    label: "Destination : ",
                    value: departure.getSelectedTrip?.destination ?? '',
                  ),
                  0.01.height.hSpace,
                  LabelsWidget(
                    label: "Organized By : ",
                    value: departure.getSelectedTrip?.organizedBy.companyName ??
                        '',
                  ),
                  0.01.height.hSpace,
                  LabelsWidget(
                    label: "Price : ",
                    value:
                        "${departure.getSelectedTrip?.price} ${departure.getSelectedTrip?.currency}",
                  ),
                  0.01.height.hSpace,
                  LabelsWidget(
                      label: "Total Guests : ",
                      value: "${departure.getSelectedTrip?.totalGuests} Guest"),
                ],
              ),
            ),
            0.01.height.hSpace,
            Visibility(
              visible: departure.getSelectedTrip != null,
              child: Column(
                children: [
                  0.01.height.hSpace,
                  DividersWord(
                    text: "Departure",
                  ),
                ],
              ),
            ),
          ],
        ).allPadding(15),
      ),
    );
  }
}
