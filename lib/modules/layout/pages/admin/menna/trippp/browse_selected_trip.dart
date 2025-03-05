import 'package:flutter/material.dart';
import '/core/extensions/extensions.dart';
import '/core/theme/app_colors.dart';
import '/core/widget/dividers_word.dart';
import '/models/trip_data_model.dart';
import '/modules/layout/pages/admin/pages/attractions/pages/update_attractions/widget/play_youtube_video.dart';
import '/modules/layout/widget/text_labels_widget.dart';

class BrowseSelectedTrip extends StatelessWidget {
  static const routeName = '/browse-selected-trip';

  BrowseSelectedTrip({super.key});

  @override
  Widget build(BuildContext context) {
    var model = ModalRoute.of(context)?.settings.arguments as TripDataModel;
    var theme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
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
              ],
            ).hPadding(0.03.width),
            0.02.height.hSpace,
            DividersWord(
              text: "Programs",
            ),
            0.01.height.hSpace,
          ],
        ),
      ),
    );
  }
}
