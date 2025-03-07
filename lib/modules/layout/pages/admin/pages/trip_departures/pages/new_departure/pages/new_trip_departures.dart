import 'dart:developer';
import 'package:cupertino_calendar_picker/cupertino_calendar_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:travel_go/core/services/bot_toast.dart';
import 'package:travel_go/core/utils/id_generator.dart';
import 'package:travel_go/core/widget/custom_elevated_button.dart';
import 'package:travel_go/modules/layout/pages/admin/pages/trip_departures/data/use_case/departures.dart';
import '/modules/layout/pages/admin/pages/trip_departures/data/model/trip_departure_data_model.dart';
import '/core/extensions/extensions.dart';
import '/core/providers/collections_provider.dart';
import '/core/providers/departure_provider.dart';
import '/core/theme/app_colors.dart';
import '/core/widget/dividers_word.dart';
import '/core/widget/labels_widget.dart';
import '/models/trip_data_model.dart';

class NewTripDepartures extends StatefulWidget {
  const NewTripDepartures({super.key});

  @override
  State<NewTripDepartures> createState() => _NewTripDeparturesState();
}

class _NewTripDeparturesState extends State<NewTripDepartures> {
  List<TripDataModel> trips = [];
  List<TripDepartureDataModel> departures = [];
  DateTime? fromDate;
  DateTime? toDate;

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
                  0.01.height.hSpace,
                  LabelsWidget(
                      label: "Total Days : ",
                      value: "${departure.getSelectedTrip?.totalDays} Day"),
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
                  0.01.height.hSpace,
                ],
              ),
            ),
            0.01.height.hSpace,
            Visibility(
              visible: departure.getSelectedTrip != null,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "From : ",
                    style: theme.labelLarge!.copyWith(
                      color: AppColors.blackColor,
                    ),
                  ),
                  0.01.height.hSpace,
                  CupertinoCalendar(
                    onDateSelected: (value) {
                      fromDate = value;
                      toDate = value.add(
                        Duration(
                          days: departure.getSelectedTrip!.totalDays,
                        ),
                      );
                      setState(() {});
                    },
                    mainColor: AppColors.newBlueColor,
                    type: CupertinoCalendarType.compact,
                    minimumDateTime: DateTime.now(),
                    maximumDateTime: DateTime.now().add(
                      Duration(days: 365),
                    ),
                    initialDateTime: fromDate ?? DateTime.now(),
                    currentDateTime: fromDate ?? DateTime.now(),
                    timeLabel: 'Ends',
                    mode: CupertinoCalendarMode.date,
                  ),
                  0.01.height.hSpace,
                  Text(
                    "To : ",
                    style: theme.labelLarge!.copyWith(
                      color: AppColors.blackColor,
                    ),
                  ),
                  0.01.height.hSpace,
                  CupertinoCalendar(
                    onDateSelected: (value) {
                      setState(() {});
                    },
                    mainColor: AppColors.newBlueColor,
                    type: CupertinoCalendarType.compact,
                    minimumDateTime: fromDate ?? DateTime.now(),
                    maximumDateTime: fromDate?.add(
                          Duration(
                            days: departure.getSelectedTrip!.totalDays,
                          ),
                        ) ??
                        DateTime.now().add(
                          Duration(days: 365),
                        ),
                    initialDateTime: toDate ?? DateTime.now(),
                    currentDateTime: toDate ?? DateTime.now(),
                    timeLabel: 'Ends',
                    mode: CupertinoCalendarMode.date,
                  ),
                  0.01.height.hSpace,
                  Row(
                    children: [
                      Expanded(
                        child: CustomElevatedButton(
                          text: "OK",
                          onPressed: (fromDate != null && toDate != null)
                              ? () async {
                                  EasyLoading.show();
                                  await DeparturesCollection.addDeparture(
                                    TripDepartureDataModel(
                                      trip: departure.getSelectedTrip!,
                                      from: fromDate!,
                                      to: toDate!,
                                      availableSeats: departure
                                          .getSelectedTrip!.totalGuests,
                                      id: IdGenerator.generateDepartureId(
                                        tripName:
                                            departure.getSelectedTrip!.tripName,
                                        from:
                                            "${fromDate!.year}:${fromDate!.month}:${fromDate!.day}",
                                        to: "${toDate!.year}:${toDate!.month}:${toDate!.day}",
                                      ),
                                    ),
                                  ).then(
                                    (value) {
                                      if (value) {
                                        BotToastServices.showSuccessMessage(
                                          "Departure Added Successfully.",
                                        );
                                        departure.setSelectedTrip(null);
                                        Navigator.pop(context);
                                        EasyLoading.dismiss();
                                      } else {
                                        BotToastServices.showErrorMessage(
                                          "Failed to add departure.",
                                        );
                                        EasyLoading.dismiss();
                                      }
                                    },
                                  );
                                }
                              : null,
                        ),
                      ),
                      0.01.width.vSpace,
                      Expanded(
                        child: CustomElevatedButton(
                          text: "Cancel",
                          onPressed: () {
                            Navigator.pop(context);
                            departure.setSelectedTrip(null);
                          },
                          btnColor: AppColors.errorColor,
                        ),
                      ),
                    ],
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
