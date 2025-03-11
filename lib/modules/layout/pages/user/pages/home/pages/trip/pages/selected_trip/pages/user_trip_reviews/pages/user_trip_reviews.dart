import 'package:flutter/material.dart';
import '/core/extensions/extensions.dart';
import '/modules/layout/pages/user/pages/home/pages/trip/pages/selected_trip/pages/user_trip_reviews/widget/comment_widget.dart';

class UserTripReviews extends StatelessWidget {
  const UserTripReviews({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        0.01.height.hSpace,
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.zero,
          itemBuilder: (context, index) => ReviewWidget(
            reviewerName: "Hisham",
            rating: index+2,
            timestamp: "${index+1} Days Ago",
            reviewText: "very good Service Support",
          ),
          separatorBuilder: (context, index) => 0.01.height.hSpace,
          itemCount: 15,
        ),
      ],
    );
  }
}
