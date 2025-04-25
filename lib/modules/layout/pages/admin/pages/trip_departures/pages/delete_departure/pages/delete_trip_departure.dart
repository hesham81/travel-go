import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import '/core/extensions/align.dart';
import '/core/extensions/extensions.dart';
import '/core/theme/app_colors.dart';
import '/core/widget/custom_elevated_button.dart';
import '/core/widget/dividers_word.dart';
import '/core/widget/labels_widget.dart';
import '/core/widget/loading_image_network_widget.dart';
import '/models/trip_data_model.dart';
import '/modules/layout/pages/admin/menna/trippp/utils/trips_collections.dart';
import '/modules/layout/pages/admin/pages/trip_departures/data/model/trip_departure_data_model.dart';
import '/modules/layout/pages/admin/pages/trip_departures/data/use_case/departures.dart';

class DeleteTripDeparture extends StatefulWidget {
  final TripDepartureDataModel tripDepartureDataModel;

  const DeleteTripDeparture({
    super.key,
    required this.tripDepartureDataModel,
  });

  @override
  State<DeleteTripDeparture> createState() => _DeleteTripDepartureState();
}

class _DeleteTripDepartureState extends State<DeleteTripDeparture> {
  TripDataModel? trip;
  bool isLoading = true;

  Future<void> _getCurrentTrip() async {
    trip = await TripCollections.getTrip(widget.tripDepartureDataModel.tripId);
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    Future.wait([_getCurrentTrip()]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return (isLoading)
        ? CircularProgressIndicator(
            backgroundColor: AppColors.newBlueColor,
          ).center
        : Scaffold(
            appBar: AppBar(
              leading: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: Icon(
                  Icons.arrow_back_ios,
                ),
              ),
              title: Text(
                trip?.tripName ?? "",
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: AppColors.whiteColor,
                    ),
              ),
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  LoadingImageNetworkWidget(
                    imageUrl: trip!.imageUrl!,
                  ),
                  0.01.height.hSpace,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      LabelsWidget(
                        label: "From : ",
                        value:
                            "${widget.tripDepartureDataModel.from.year}/${widget.tripDepartureDataModel.from.month}/${widget.tripDepartureDataModel.from.day}",
                      ),
                      0.01.height.hSpace,
                      LabelsWidget(
                        label: "To : ",
                        value:
                            "${widget.tripDepartureDataModel.to.year}/${widget.tripDepartureDataModel.to.month}/${widget.tripDepartureDataModel.to.day}",
                      ),
                      0.01.height.hSpace,
                      LabelsWidget(
                        label: "Duration : ",
                        value:
                            "${widget.tripDepartureDataModel.to.difference(widget.tripDepartureDataModel.from).inDays.toString()} Days",
                      ),
                      0.01.height.hSpace,
                      LabelsWidget(
                          label: "Available Seats : ",
                          value:
                              "${widget.tripDepartureDataModel.availableSeats} Seats"),
                      0.01.height.hSpace,
                      DividersWord(
                        text: "Trip Information",
                      ),
                      0.01.height.hSpace,
                      LabelsWidget(
                        label: "Trip Name : ",
                        value: trip!.tripName,
                      ),
                      0.01.height.hSpace,
                      LabelsWidget(
                        label: "Price : ",
                        value: trip!.price.toString(),
                      ),
                      0.01.height.hSpace,
                      LabelsWidget(
                        label: "Total Guests : ",
                        value: "${trip!.totalGuests} Guests",
                      ),
                      0.01.height.hSpace,
                      CustomElevatedButton(
                        text: "Delete",
                        borderRadius: 10,
                        btnColor: AppColors.errorColor,
                        onPressed: () async {
                          EasyLoading.show();
                          await TripDeparturesCollection.deleteDeparture(
                                  departureId: widget.tripDepartureDataModel.id)
                              .then((value) => Navigator.pop(context))
                              .then(
                                (value) => EasyLoading.dismiss(),
                              );
                        },
                      ),
                      0.03.height.hSpace,
                    ],
                  ).hPadding(0.03.width),
                ],
              ),
            ),
          );
  }
}
