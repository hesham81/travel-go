import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '/core/constant/app_assets.dart';
import '/core/extensions/extensions.dart';

class ReviewWidget extends StatelessWidget {
  final String reviewerName;
  final int rating;
  final String timestamp;
  final String reviewText;
  final bool isFirstIndex;

  const ReviewWidget({
    super.key,
    required this.reviewerName,
    required this.rating,
    required this.timestamp,
    required this.reviewText,
    this.isFirstIndex = false,
  });

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).textTheme;
    return Container(
      padding: const EdgeInsets.all(10.0),
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
            backgroundImage: CachedNetworkImageProvider(
              (isFirstIndex)
                  ? "https://scontent.fcai22-1.fna.fbcdn.net/v/t39.30808-6/489928976_2045949285915231_1389553330135841803_n.jpg?_nc_cat=102&ccb=1-7&_nc_sid=6ee11a&_nc_ohc=ScW51y-F_bYQ7kNvwGDdhFm&_nc_oc=AdkRS3DRqwohUn3g_a1mNjywbkX8UDOKDfrpM92-mWi1pRjEfHQLXELN_t_KtFNT3xA&_nc_zt=23&_nc_ht=scontent.fcai22-1.fna&_nc_gid=EBpQNJgqUk0sUfA3jiT-cw&oh=00_AfE1498GJqVRgflAjZ_vU8Tjs-001MV0oMY7if4HUx1slw&oe=68146D54"
                  : "https://i.pinimg.com/736x/87/14/55/8714556a52021ba3a55c8e7a3547d28c.jpg",
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
                          fontWeight: FontWeight.bold,
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
                overflow: TextOverflow.ellipsis,
                style: theme.labelSmall!.copyWith(
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
