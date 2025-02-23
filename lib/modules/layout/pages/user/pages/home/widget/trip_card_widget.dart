import 'package:flutter/material.dart';
import '/core/extensions/align.dart';
import '/core/extensions/alignment.dart';
import '/core/services/bot_toast.dart';
import '/core/widget/custom_rating_widget.dart';
import '/core/widget/loading_image_network_widget.dart';
import '/core/extensions/extensions.dart';
import '/models/trip_model.dart';

import '../../../../../../../core/theme/app_colors.dart';

class TripCardWidget extends StatefulWidget {
  final TripModel tripModel;

  const TripCardWidget({
    super.key,
    required this.tripModel,
  });

  @override
  State<TripCardWidget> createState() => _TripCardWidgetState();
}

class _TripCardWidgetState extends State<TripCardWidget> {
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Container(
      width: double.maxFinite,
      height: 0.2.height,
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: LoadingImageNetworkWidget(
              imageUrl: widget.tripModel.imageUrl,
            ),
          ),
          widget.tripModel.isFavorite == true
              ? IconButton(
                  onPressed: () {
                    widget.tripModel.isFavorite = !widget.tripModel.isFavorite;
                    BotToastServices.showSuccessMessage(
                      "${widget.tripModel.title} Removed From favourite",
                    );
                    setState(() {});
                  },
                  icon: Icon(
                    Icons.bookmark,
                    color: AppColors.newBlueColor,
                  ),
                ).alignTopRight()
              : IconButton(
                  onPressed: () {
                    widget.tripModel.isFavorite = !widget.tripModel.isFavorite;
                    BotToastServices.showSuccessMessage(
                      "${widget.tripModel.title} Added To favourite",
                    );
                    setState(() {});
                  },
                  icon: Icon(
                    Icons.bookmark_outline,
                    color: AppColors.newBlueColor,
                  ),
                ).alignTopRight(),
          Text(
            widget.tripModel.title,
            style: theme.textTheme.bodyMedium!.copyWith(
              color: AppColors.whiteColor,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ).centerTopWidget(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${widget.tripModel.endDateTime.difference(widget.tripModel.startDateTime).inDays} Days",
              ),
              0.01.height.hSpace,
              Text(
                "${widget.tripModel.price} ${widget.tripModel.currency}",
                style: theme.textTheme.bodyMedium!.copyWith(
                  color: AppColors.whiteColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              Spacer(),
              CustomRatingWidget(
                initialRating: 3.5,
                tapOnlyMode: true,
                minRating: 3.5,
                itemSize: 20,
                mainColor: AppColors.newBlueColor,
              ),
              0.01.height.hSpace,
            ],
          ).allPadding(10),
        ],
      ),
    );
  }
}
