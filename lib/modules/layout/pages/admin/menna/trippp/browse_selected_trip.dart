import 'package:flutter/material.dart';
import 'package:route_transitions/route_transitions.dart';
import 'package:travel_go/core/routes/route_transact.dart';
import 'package:travel_go/modules/layout/pages/admin/menna/trippp/flight_details.dart';
import 'package:travel_go/modules/layout/pages/admin/pages/trips/pages/edit_selected_hotels.dart';
import '/core/widget/custom_elevated_button.dart';
import '/modules/layout/pages/admin/pages/programs/pages/browse_program/pages/program_details.dart';
import '/core/extensions/extensions.dart';
import '/core/theme/app_colors.dart';
import '/models/trip_data_model.dart';
import '/modules/layout/pages/admin/pages/attractions/pages/update_attractions/widget/play_youtube_video.dart';
import '/modules/layout/widget/text_labels_widget.dart';

class BrowseSelectedTrip extends StatelessWidget {
  static const routeName = '/browse-selected-trip';

  const BrowseSelectedTrip({super.key});

  @override
  Widget build(BuildContext context) {
    var model = ModalRoute.of(context)?.settings.arguments as TripDataModel;
    var theme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            Icons.arrow_back_ios,
            color: AppColors.whiteColor,
          ),
        ),
        title: Text(
          model.tripName.toUpperCase(),
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
                    model.imageUrl!,
                  ),
                  fit: BoxFit.cover,
                ),
              ),
              child: IconButton(
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    PlayYoutubeVideo.routeName,
                    arguments: model.tripVideoUrl,
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
              children: [
                TextLabelsWidget(
                  label: "ID : ",
                  value: model.tripId,
                ),
                0.01.height.hSpace,
                TextLabelsWidget(
                  label: "Name : ",
                  value: model.tripName,
                ),
                0.01.height.hSpace,
                TextLabelsWidget(
                  label: "From : ",
                  value: model.source,
                ),
                0.01.height.hSpace,
                TextLabelsWidget(
                  label: "To : ",
                  value: model.destination,
                ),
                0.01.height.hSpace,
                TextLabelsWidget(
                  label: "Total Days : ",
                  value: "${model.totalDays} Days",
                ),
                0.01.height.hSpace,
                TextLabelsWidget(
                  label: "Price : ",
                  value: "${model.price} ${model.currency}",
                ),
                0.01.height.hSpace,
                TextLabelsWidget(
                  label: "Total Guests : ",
                  value: "${model.totalGuests} Guest",
                ),
                0.01.height.hSpace,
                TextLabelsWidget(
                  label: "Organized By : ",
                  value: "${model.organizedBy.companyName} Company",
                ),
              ],
            ).hPadding(0.03.width),
            0.02.height.hSpace,
            SizedBox(
              width: double.maxFinite,
              child: CustomElevatedButton(
                text: "Program Details",
                borderRadius: 10,
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    ProgramDetails.routeName,
                    arguments: model,
                  );
                },
              ),
            ).hPadding(0.03.width),
            0.01.height.hSpace,
            SizedBox(
              width: double.maxFinite,
              child: CustomElevatedButton(
                text: "Flight Details",
                borderRadius: 10,
                onPressed: () {
                  Navigator.push(
                    context,
                    SlideRightRoute(
                      page: FlightDetails(
                        flight: model.flightId,
                      ),
                    ),
                  );
                },
              ),
            ).hPadding(0.03.width),
            0.01.height.hSpace,
            SizedBox(
              width: double.maxFinite,
              child: CustomElevatedButton(
                text: "Hotel Details",
                borderRadius: 10,
                onPressed: () => slideLeftWidget(
                    newPage: EditSelectedHotels(
                      hotelId: model.hotelId,
                    ),
                    context: context),
              ),
            ).hPadding(0.03.width),
            0.01.height.hSpace,
          ],
        ),
      ),
    );
  }
}
