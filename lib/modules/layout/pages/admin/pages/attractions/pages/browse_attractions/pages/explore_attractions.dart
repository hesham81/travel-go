import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:travel_go/core/extensions/extensions.dart';
import 'package:travel_go/core/theme/app_colors.dart';
import 'package:travel_go/core/widget/loading_image_network_widget.dart';
import 'package:travel_go/models/attractions_model.dart';
import 'package:travel_go/modules/layout/pages/admin/pages/attractions/pages/update_attractions/widget/play_youtube_video.dart';
import 'package:travel_go/modules/layout/pages/admin/pages/attractions/pages/update_attractions/widget/set_map_location.dart';

class ExploreAttractions extends StatelessWidget {
  static const String routeName = "/browse-attraction";

  const ExploreAttractions({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).textTheme;
    var model = ModalRoute.of(context)?.settings.arguments as AttractionsModel;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          model.title,
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
                    model.imageUrl,
                  ),
                  fit: BoxFit.cover,
                ),
              ),
              child: IconButton(
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    PlayYoutubeVideo.routeName,
                    arguments: model.videoUrl,
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
                  color: AppColors.newBlueColor,
                ),
              ),
            ),
            0.01.height.hSpace,
            Row(
              children: [
                Text(
                  "Attraction ID : ",
                  style: theme.titleMedium!.copyWith(
                    color: AppColors.blackColor,
                  ),
                ),
                0.01.width.vSpace,
                Text(
                  model.id,
                  style: theme.titleMedium!.copyWith(
                    color: AppColors.newBlueColor,
                  ),
                ),
              ],
            ).hPadding(0.03.width),
            0.01.height.hSpace,
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Attraction Description : ",
                  style: theme.titleMedium!.copyWith(
                    color: AppColors.blackColor,
                  ),
                ),
                0.01.width.vSpace,
                Text(
                  model.description,
                  style: theme.titleMedium!.copyWith(
                    color: AppColors.newBlueColor,
                  ),
                ),
              ],
            ).hPadding(0.03.width),
            0.01.height.hSpace,
            Row(
              children: [
                Text(
                  "Attraction Category : ",
                  style: theme.titleMedium!.copyWith(
                    color: AppColors.blackColor,
                  ),
                ),
                0.01.width.vSpace,
                Text(
                  model.category,
                  style: theme.titleMedium!.copyWith(
                    color: AppColors.newBlueColor,
                  ),
                ),
              ],
            ).hPadding(0.03.width),
            0.01.height.hSpace,
            Row(
              children: [
                Text(
                  "Attraction Location : ",
                  style: theme.titleMedium!.copyWith(
                    color: AppColors.blackColor,
                  ),
                ),
                0.01.width.vSpace,
                Text(
                  model.location,
                  style: theme.titleMedium!.copyWith(
                    color: AppColors.newBlueColor,
                  ),
                ),
              ],
            ).hPadding(0.03.width),
            0.01.height.hSpace,
            SizedBox(
              height: 0.5.height,
              child: SetMapLocation(
                locations: LatLng(model.lat ?? 0, model.long ?? 0),
              ),
            ).hPadding(0.03.width),
            0.01.height.hSpace,
          ],
        ),
      ),
    );
  }
}
