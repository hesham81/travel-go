import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:travel_go/core/extensions/align.dart';
import 'package:travel_go/core/widget/custom_elevated_button.dart';
import '../../../data/use_case/departures.dart';
import '/core/extensions/extensions.dart';
import '/core/theme/app_colors.dart';
import '/core/widget/loading_image_network_widget.dart';
import '/modules/layout/pages/admin/pages/trip_departures/data/model/trip_departure_data_model.dart';
import '/models/trip_data_model.dart';
import '../../../../../menna/trippp/utils/trips_collections.dart';

class UpdateDeparture extends StatefulWidget {
  final TripDepartureDataModel departureDataModel;

  const UpdateDeparture({
    super.key,
    required this.departureDataModel,
  });

  @override
  State<UpdateDeparture> createState() => _UpdateDepartureState();
}

class _UpdateDepartureState extends State<UpdateDeparture> {
  bool isLoading = true;
  TripDataModel? trip;

  Future<void> _getCurrentTrip() async {
    trip = await TripCollections.getTrip(widget.departureDataModel.tripId);
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    Future.wait([_getCurrentTrip()]);
    super.initState();
  }

  DateTime? newDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            Icons.arrow_back_ios,
          ),
        ),
        title: Text(
          trip?.tripName ?? "Trip",
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: AppColors.whiteColor,
              ),
        ),
      ),
      body: (isLoading)
          ? CircularProgressIndicator(
              color: AppColors.newBlueColor,
            ).center
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  LoadingImageNetworkWidget(
                    imageUrl: trip?.imageUrl ?? "",
                  ),
                  0.01.height.hSpace,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      0.01.height.hSpace,
                      Text(
                        "From : ",
                        style:
                            Theme.of(context).textTheme.titleMedium!.copyWith(
                                  color: AppColors.newBlueColor,
                                ),
                      ),
                      0.01.height.hSpace,
                      CalendarDatePicker(
                        initialDate: widget.departureDataModel.from,
                        firstDate: DateTime.now(),
                        lastDate: widget.departureDataModel.from.add(
                          Duration(
                            days: 60,
                          ),
                        ),
                        onDateChanged: (value) {
                          widget.departureDataModel.from = value;
                          setState(() {});
                        },
                      ),
                      0.01.height.hSpace,
                      Text(
                        "To : ",
                        style:
                            Theme.of(context).textTheme.titleMedium!.copyWith(
                                  color: AppColors.newBlueColor,
                                ),
                      ),
                      CalendarDatePicker(
                        initialDate: widget.departureDataModel.from.add(
                          Duration(
                            days: trip?.totalDays ?? 0,
                          ),
                        ),
                        firstDate: widget.departureDataModel.from.add(
                          Duration(
                            days: trip?.totalDays ?? 0,
                          ),
                        ),
                        lastDate: widget.departureDataModel.from.add(
                          Duration(
                            days: 60,
                          ),
                        ),
                        onDateChanged: (value) {},
                      ),
                      0.02.height.hSpace,
                      Row(
                        children: [
                          Expanded(
                            child: CustomElevatedButton(
                                text: "Ok",
                                onPressed: () async {
                                  EasyLoading.show();
                                  widget.departureDataModel.to =
                                      widget.departureDataModel.from.add(
                                    Duration(
                                      days: trip!.totalDays,
                                    ),
                                  );
                                  await TripDeparturesCollection.addDeparture(
                                    widget.departureDataModel,
                                  );
                                  EasyLoading.dismiss();
                                  Navigator.pop(context);
                                }),
                          ),
                          0.03.width.vSpace,
                          Expanded(
                            child: CustomElevatedButton(
                                text: "Cancel",
                                btnColor: AppColors.errorColor,
                                onPressed: () async {
                                  Navigator.pop(context);
                                }),
                          ),
                        ],
                      ),
                      0.02.height.hSpace,
                    ],
                  ).hPadding(0.03.width)
                ],
              ),
            ),
    );
  }
}
