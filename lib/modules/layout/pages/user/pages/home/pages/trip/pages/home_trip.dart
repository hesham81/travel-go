import 'package:flutter/material.dart';
import 'package:travel_go/modules/layout/pages/user/widget/app_bar.dart';
import '/modules/layout/pages/user/pages/home/widget/trip_card_widget.dart';
import '/modules/layout/pages/user/pages/profile/pages/user_profile.dart';
import '/core/extensions/alignment.dart';
import '/core/extensions/extensions.dart';
import '/core/constant/app_assets.dart';
import '/core/theme/app_colors.dart';
import '/core/utils/firebase_auth_services.dart';
import '/core/widget/custom_text_button.dart';
import '/core/widget/loading_image_network_widget.dart';
import '/core/widget/recommended_widget.dart';
import '/models/recommend_model.dart';
import '/models/trip_model.dart';

class HomeTrip extends StatefulWidget {
  const HomeTrip({super.key});

  @override
  State<HomeTrip> createState() => _HomeTripState();
}

class _HomeTripState extends State<HomeTrip> {
  var user = FirebaseAuthServices.getCurrentUserData();
  List<TripModel> tripList = [
    TripModel(
      id: '1',
      imageUrl:
      "https://i.pinimg.com/474x/6a/99/ee/6a99ee843798375c5f7049316e8d31ed.jpg",
      title: 'Paris',
      startDateTime: DateTime(2025, 10, 12),
      endDateTime: DateTime(2025, 10, 15),
      price: 12000,
    ),
    TripModel(
      id: '5',
      imageUrl:
      "https://i.pinimg.com/474x/a1/40/72/a140720c714f8689dc23c9dbe8c7be13.jpg",
      title: 'Dynamo Kiev',
      startDateTime: DateTime(2025, 10, 12),
      endDateTime: DateTime(2025, 10, 15),
      price: 1800,
      currency: "USD",
    ),
    TripModel(
      id: '6',
      imageUrl:
      "https://i.pinimg.com/474x/ac/82/3f/ac823f39ce49b221f8d1c3cb44f88073.jpg",
      title: 'Aswan',
      startDateTime: DateTime(2025, 3, 12),
      endDateTime: DateTime(2025, 3, 15),
      price: 800,
    ),
    TripModel(
      id: '4',
      imageUrl:
      "https://i.pinimg.com/474x/ea/77/e6/ea77e6b28d3c330c8da3e2c565cb3da3.jpg",
      title: 'Sharm',
      startDateTime: DateTime(2025, 3, 21),
      endDateTime: DateTime(2025, 4, 5),
      price: 3000,
    ),
    TripModel(
      id: '2',
      imageUrl:
      "https://i.pinimg.com/474x/5b/9c/95/5b9c95ae4a85c7ca6fc04919222654fc.jpg",
      title: 'Dahab',
      startDateTime: DateTime(2025, 8, 16),
      endDateTime: DateTime(2025, 8, 19),
      price: 4000,
    ),
    TripModel(
      id: '3',
      imageUrl:
      "https://i.pinimg.com/474x/a8/91/3d/a8913dd1fc3dcc7a3a8e9af97c0167f0.jpg",
      title: 'Alex',
      startDateTime: DateTime(2025, 4, 20),
      endDateTime: DateTime(2025, 4, 23),
      price: 4500,
    ),
  ];
  List<RecommendModel> recommendations = [
    RecommendModel(
      name: "Sunset Resort",
      imgUrl:
      "https://i.pinimg.com/474x/fd/24/f7/fd24f7618315267be4c3c1f137b07ba5.jpg",
      rating: 4.0,
      location: "Maldives",
    ),
    RecommendModel(
      name: "Mountain Escape",
      imgUrl:
      "https://i.pinimg.com/474x/9a/8a/15/9a8a15c6f624f8eced6e8749814d1346.jpg",
      rating: 3.7,
      location: "Switzerland",
    ),
    RecommendModel(
      name: "Urban Luxury Hotel",
      imgUrl:
      "https://i.pinimg.com/474x/a9/11/11/a91111291a57cbbdd936a3673fb229fb.jpg",
      rating: 4.6,
      location: "New York, USA",
    ),
    RecommendModel(
      name: "Tropical Paradise",
      imgUrl:
      "https://i.pinimg.com/474x/f5/3b/e4/f53be4d19b19f8c0116af5e0e804b4a5.jpg",
      rating: 4.0,
      location: "Bali, Indonesia",
    ),
    RecommendModel(
      name: "Historic Castle Stay",
      imgUrl:
      "https://i.pinimg.com/474x/70/ba/b8/70bab828bc5768acfd79719a8180639f.jpg",
      rating: 4.5,
      location: "Edinburgh, Scotland",
    ),
    RecommendModel(
      name: "Pyramids of Egypt",
      imgUrl:
      "https://i.pinimg.com/474x/9b/73/61/9b7361b0dfbd5ffaf4f92928a2f554ed.jpg",
      rating: 4.5,
      location: "Giza, Egypt",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return  SingleChildScrollView(
      child: SafeArea(
        child: Column(
          children: [
            AppBarWidget(),
            0.02.height.hSpace,
            Row(
              children: [
                Column(
                  children: [
                    Text(
                      "Hi , ${user!.displayName}",
                      style: theme.textTheme.titleLarge!.copyWith(
                        color: AppColors.blackColor,
                      ),
                    ),
                    0.01.height.hSpace,
                    Text(
                      "Let's explore the world!",
                      style: theme.textTheme.titleMedium!.copyWith(
                        color: AppColors.newBlueColor,
                      ),
                    ),
                  ],
                ),
                Spacer(),
                CircleAvatar(
                  backgroundColor: AppColors.newBlueColor,
                  radius: 20,
                  child: Icon(
                    Icons.search,
                    color: AppColors.whiteColor,
                  ),
                ),
                0.01.width.vSpace,
              ],
            ),
            0.01.height.hSpace,
            Divider(),
            0.01.height.hSpace,
            Row(
              children: [
                Text(
                  "Special For You",
                  style: theme.textTheme.titleMedium!.copyWith(
                    color: AppColors.blackColor,
                  ),
                ),
                Spacer(),
                CustomTextButton(
                  onPressed: () {},
                  text: "Discover More",
                ),
              ],
            ),
            0.01.height.hSpace,
            SizedBox(
              height: 0.3.height,
              child: ListView.separated(
                padding: EdgeInsets.zero,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    child: RecommendedWidget(
                      model: recommendations[index],
                    ),
                  );
                },
                separatorBuilder: (context, _) => 0.02.width.vSpace,
                itemCount: recommendations.length,
              ),
            ),
            0.01.height.hSpace,
            Divider(),
            0.01.height.hSpace,
            Text(
              "Featured Trips",
              style: theme.textTheme.titleMedium!.copyWith(
                color: AppColors.blackColor,
              ),
            ).leftBottomWidget(),
            0.01.height.hSpace,
            ListView.separated(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) => TripCardWidget(
                tripModel: tripList[index],
              ),
              separatorBuilder: (context, _) => 0.01.height.hSpace,
              itemCount: tripList.length,
            ),
          ],
        ).hPadding(0.03.width),
      ),
    );
  }
}
