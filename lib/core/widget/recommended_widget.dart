import 'package:flutter/material.dart';
import '/core/extensions/align.dart';
import '/core/theme/app_colors.dart';
import '/core/widget/custom_rating_widget.dart';
import '/models/recommend_model.dart';
import '/core/extensions/extensions.dart';

class RecommendedWidget extends StatefulWidget {
  final RecommendModel model;
  bool isFavourite;

  RecommendedWidget({
    super.key,
    required this.model,
    this.isFavourite = false,
  });

  @override
  State<RecommendedWidget> createState() => _RecommendedWidgetState();
}

class _RecommendedWidgetState extends State<RecommendedWidget> {
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Container(
      width: 0.5.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        image: DecorationImage(
          image: NetworkImage(
            widget.model.imgUrl,
          ),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          widget.isFavourite
              ? IconButton(
                  onPressed: () {
                    widget.isFavourite = !widget.isFavourite;
                    setState(() {});
                  },
                  icon: Icon(
                    Icons.favorite,
                    color: AppColors.newBlueColor,
                  ),
                ).alignTopRight()
              : IconButton(
                  onPressed: () {
                    widget.isFavourite = !widget.isFavourite;
                    setState(() {});
                  },
                  icon: Icon(
                    Icons.favorite_outline,
                    color: AppColors.newBlueColor,
                  ),
                ).alignTopRight(),
          Spacer(),
          Text(
            widget.model.name,
            style: theme.textTheme.titleLarge!.copyWith(
              color: AppColors.whiteColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          0.01.height.hSpace,
          Row(
            children: [
              Icon(
                Icons.location_on_rounded,
                color: AppColors.whiteColor,
              ),
              0.01.width.vSpace,
              Text(
                widget.model.location,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.titleMedium!.copyWith(
                  color: AppColors.whiteColor,
                ),
              ),
            ],
          ),
          CustomRatingWidget(
            tapOnlyMode: true,
            minRating: widget.model.rating,
            initialRating: widget.model.rating,
            itemSize: 21,
            mainColor: AppColors.newBlueColor,
          ),
          0.01.height.hSpace,
        ],
      ).hPadding(0.03.width),
    );
  }
}
