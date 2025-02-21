import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:travel_go/core/theme/app_colors.dart';

class CustomRatingWidget extends StatefulWidget {
  late double endRating = 0;
  final double initialRating;
  final double minRating;
  final Color mainColor;

  final int itemCount;
  final bool allowHalfRating;
  final bool tapOnlyMode;
  final double itemSize;

  CustomRatingWidget({
    super.key,
    this.initialRating = 3,
    this.minRating = 0,
    this.itemCount = 5,
    this.allowHalfRating = true,
    this.tapOnlyMode = true,
    this.mainColor = Colors.amber,
    this.itemSize = 40,
  });

  @override
  State<CustomRatingWidget> createState() => _CustomRatingWidgetState();
}

class _CustomRatingWidgetState extends State<CustomRatingWidget> {
  @override
  Widget build(BuildContext context) {
    return RatingBar.builder(
      initialRating: widget.initialRating,
      minRating: widget.minRating,
      itemSize: widget.itemSize,
      tapOnlyMode: widget.tapOnlyMode,
      direction: Axis.horizontal,
      allowHalfRating: widget.allowHalfRating,
      itemCount: widget.itemCount,
      unratedColor: AppColors.greyColor.withAlpha(80),
      itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
      itemBuilder: (context, _) => Icon(
        Icons.star,
        color: widget.mainColor,
      ),
      onRatingUpdate: (rating) {
        widget.endRating = rating;
      },
    );
  }
}
