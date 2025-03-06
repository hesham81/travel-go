import 'package:currency_picker/currency_picker.dart';
import 'package:flutter/material.dart';
import 'package:travel_go/core/widget/dividers_word.dart';
import '/core/extensions/extensions.dart';
import '/core/theme/app_colors.dart';
import '/core/widget/custom_elevated_button.dart';
import '/core/widget/custom_text_form_field.dart';
import '/core/widget/labels_widget.dart';
import '/core/widget/numbers_text_form_field.dart';
import '/models/trip_data_model.dart';
import '/modules/layout/pages/admin/pages/attractions/pages/update_attractions/widget/play_youtube_video.dart';

class DeleteSelectedTrip extends StatefulWidget {
  final TripDataModel trip;

  const DeleteSelectedTrip({
    super.key,
    required this.trip,
  });

  @override
  State<DeleteSelectedTrip> createState() => _DeleteSelectedTripState();
}

class _DeleteSelectedTripState extends State<DeleteSelectedTrip> {
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            Icons.arrow_back_ios,
          ),
        ),
        title: Text(
          widget.trip.tripName.toUpperCase(),
          style: theme.titleLarge!.copyWith(
            color: AppColors.whiteColor,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 0.5.height,
              alignment: Alignment.bottomRight,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                    widget.trip.imageUrl!,
                  ),
                  fit: BoxFit.cover,
                ),
              ),
              child: IconButton(
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    PlayYoutubeVideo.routeName,
                    arguments: widget.trip.tripVideoUrl,
                  );
                },
                style: IconButton.styleFrom(
                  backgroundColor: AppColors.errorColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                icon: Icon(
                  Icons.play_arrow_outlined,
                  color: AppColors.whiteColor,
                ),
              ),
            ),
            0.01.height.hSpace,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                LabelsWidget(
                  label: "ID : ",
                  value: widget.trip.tripId,
                ),
                0.01.height.hSpace,
                LabelsWidget(
                  label: "Trip Name : ",
                  value: widget.trip.tripName,
                ),
                0.01.height.hSpace,
                LabelsWidget(
                  label: "Source : ",
                  value: widget.trip.source,
                ),
                0.01.height.hSpace,
                LabelsWidget(
                  label: "Destination : ",
                  value: widget.trip.destination,
                ),
                0.01.height.hSpace,
                LabelsWidget(
                  label: "Organized By : ",
                  value: widget.trip.organizedBy.companyName,
                ),
                0.01.height.hSpace,
                LabelsWidget(
                  label: "Price : ",
                  value: "${widget.trip.price} ${widget.trip.currency}",
                ),
                0.01.height.hSpace,
                LabelsWidget(
                  label: "Total Guests : ",
                  value: "${widget.trip.totalGuests} Guest",
                ),
                0.01.height.hSpace,
                LabelsWidget(
                  label: "Total Days : ",
                  value: "${widget.trip.totalDays} Day",
                ),
                0.01.height.hSpace,
                LabelsWidget(
                  label: "Video Url : ",
                  value: widget.trip.tripVideoUrl,
                ),
                0.01.height.hSpace,
                DividersWord(
                  text: "Program",
                ),
                0.01.height.hSpace,
                LabelsWidget(
                  label: "Program Title : ",
                  value: widget.trip.programDetails.first.programTitle,
                ),
                0.01.height.hSpace,
                LabelsWidget(
                  label: "Program Description : ",
                  value: widget.trip.programDetails.first.programDetails,
                ),
                0.01.height.hSpace,
                LabelsWidget(
                  label: "From : ",
                  value: widget.trip.programDetails.first.from.format(context),
                ),
                0.01.height.hSpace,
                LabelsWidget(
                  label: "To : ",
                  value: widget.trip.programDetails.first.to.format(context),
                ),
                0.01.height.hSpace,
                DividersWord(
                  text: "Flight",
                ),
                0.01.height.hSpace,
                LabelsWidget(
                  label: "Flight Id : ",
                  value: widget.trip.flight.flightId,
                ),
                0.01.height.hSpace,
                LabelsWidget(
                  label: "Flight Name : ",
                  value: widget.trip.flight.flightName,
                ),
                0.01.height.hSpace,
                LabelsWidget(
                  label: "Flight Airline : ",
                  value: widget.trip.flight.airline!.flighAirLineName,
                ),
                0.01.height.hSpace,
                DividersWord(
                  text: "Hotel",
                ),
                0.01.height.hSpace,
                LabelsWidget(
                  label: "Hotel Name : ",
                  value: widget.trip.hotel.hotelName,
                ),
                0.01.height.hSpace,
                LabelsWidget(
                  label: "Hotel Location : ",
                  value: widget.trip.hotel.hotelLocation,
                ),
                0.01.height.hSpace,
                LabelsWidget(
                  label: "Total Rooms : ",
                  value: "${widget.trip.hotel.totalRooms} Room",
                ),
                0.01.height.hSpace,
                LabelsWidget(
                  label: "Available Rooms : ",
                  value: "${widget.trip.hotel.availableRooms} Room",
                ),
                0.01.height.hSpace,
                SizedBox(
                  width: double.maxFinite,
                  child: CustomElevatedButton(
                    text: "OK",
                    onPressed: () {},
                    btnColor: AppColors.errorColor,
                  ),
                ),
                0.01.height.hSpace,
              ],
            ).hPadding(0.03.width),
          ],
        ),
      ),
    );
  }
}
