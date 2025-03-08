import 'package:flutter/material.dart';
import '/core/constant/app_assets.dart';
import '/core/extensions/extensions.dart';

class ReviewWidget extends StatelessWidget {
  final String reviewerName;
  final int rating;
  final String timestamp;
  final String reviewText;

  const ReviewWidget({
    super.key,
    required this.reviewerName,
    required this.rating,
    required this.timestamp,
    required this.reviewText,
  });

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).textTheme;
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            backgroundImage: AssetImage(
              AppAssets.profile,
            ),
            radius: 30,
          ),
          0.03.width.vSpace,
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        reviewerName,
                        style: theme.titleMedium!.copyWith(
                          color: Colors.black,
                        ),
                      ),
                      _buildRatingStars(
                        rating,
                      ),
                    ],
                  ),
                  0.2.width.vSpace,
                  Text(
                    timestamp,
                    style: theme.labelMedium!.copyWith(
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
              Text(
                reviewText,
                style: theme.labelMedium!.copyWith(
                  color: Colors.black,
                  fontSize: 14,
                ),
              )
            ],
          ),
          0.03.width.vSpace,
        ],
      ),
    );
  }

  Widget _buildRatingStars(int rating) {
    return Row(
      children: List.generate(5, (index) {
        return Icon(
          index < rating ? Icons.star : Icons.star_border,
          color: Colors.amber,
          size: 16,
        );
      }),
    );
  }
}
