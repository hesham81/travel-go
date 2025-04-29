import 'package:flutter/material.dart';
import '/core/extensions/extensions.dart';
import '/modules/layout/pages/user/pages/home/pages/trip/pages/selected_trip/pages/user_trip_reviews/widget/comment_widget.dart';

class UserTripReviews extends StatelessWidget {
  const UserTripReviews({super.key});

  // Predefined list of boys' names
  final List<String> reviewerNames = const [
    "Hisham", "Ahmed", "Ali", "Etsh", "Youssef",
    "Omar", "Khaled", "Tarek", "Sami", "Karim",
    "Zain", "Adam", "Ibrahim", "Mustafa", "Yasin",
    "Hamza", "Fahad", "Rashid", "Bilal", "Nasir"
  ];

  // Predefined list of small review comments
  final List<String> reviewTexts = const [
    "Great service!",
    "Good experience.",
    "Nice trip.",
    "Very helpful staff.",
    "Had a good time.",
    "Well-organized.",
    "Thank you!",
    "Highly recommend.",
    "Amazing!",
    "Will book again.",
    "Perfect!",
    "Friendly team.",
    "Enjoyed it.",
    "Good communication.",
    "Loved it!",
    "Fantastic!",
    "Professional.",
    "Best trip ever.",
    "Quick response.",
    "Reliable service."
  ];

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
            reviewerName: reviewerNames[index % reviewerNames.length],
            isFirstIndex: index ==0 || index == 3 ,
            rating: (index % 5) + 1, // Ratings between 1 and 5
            timestamp: "${(index % 10) + 1} Days Ago", // Timestamps between 1 and 10 days ago
            reviewText: reviewTexts[index % reviewTexts.length],
          ),
          separatorBuilder: (context, index) => 0.01.height.hSpace,
          itemCount: 20, // Display 20 reviews
        ),
      ],
    );
  }
}