import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:route_transitions/route_transitions.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '/core/routes/route_transact.dart';
import '/modules/layout/pages/user/pages/home/pages/trip/pages/selected_trip/pages/selected_trip.dart';
import '/models/trip_data_model.dart';
import '/modules/layout/pages/admin/menna/trippp/utils/trips_collections.dart';
import '/modules/layout/pages/user/pages/home/pages/trip/widget/home_trip_cart_widget.dart';
import '/modules/layout/pages/user/widget/app_bar.dart';
import '/core/extensions/alignment.dart';
import '/core/extensions/extensions.dart';
import '/core/theme/app_colors.dart';
import '/core/utils/firebase_auth_services.dart';
import '/core/widget/custom_text_button.dart';
import '/core/widget/recommended_widget.dart';
import '/models/recommend_model.dart';

class HomeTrip extends StatefulWidget {
  const HomeTrip({super.key});

  @override
  State<HomeTrip> createState() => _HomeTripState();
}

class _HomeTripState extends State<HomeTrip> {
  User? user = FirebaseAuthServices.getCurrentUserData();
  List<TripDataModel> tripList = [];
  List<RecommendModel> recommendations = [
    RecommendModel(
      name: "Pyramids of Egypt",
      imgUrl:
          "https://i.pinimg.com/474x/9b/73/61/9b7361b0dfbd5ffaf4f92928a2f554ed.jpg",
      rating: 4.5,
      location: "Giza, Egypt",
    ),
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
      location: "Bali,",
    ),
    RecommendModel(
      name: "Historic Castle Stay",
      imgUrl:
          "https://i.pinimg.com/474x/70/ba/b8/70bab828bc5768acfd79719a8180639f.jpg",
      rating: 4.5,
      location: "Edinburgh,",
    ),
  ];

  // List<TripDataModel> favouriteTrips = [];

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return SingleChildScrollView(
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
            StreamBuilder(
              stream: TripCollections.getAllTrips(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Column(
                    children: [
                      0.05.height.hSpace,
                      CircularProgressIndicator(),
                    ],
                  );
                }
                if (snapshot.hasData) {
                  tripList = snapshot.data!.docs
                      .map(
                        (e) => e.data(),
                      )
                      .toList();
                }
                return ListView.separated(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) => GestureDetector(
                    onTap: () => slideRightWidget(
                      context: context,
                      newPage: SelectedHomeScreenTrip(
                        model: tripList[index],
                      ),
                    ),
                    child: HomeTripCartWidget(
                      model: tripList[index],
                    ),
                  ),
                  separatorBuilder: (context, index) => 0.01.height.hSpace,
                  itemCount: tripList.length,
                );
              },
            ),
            0.01.height.hSpace,
          ],
        ).hPadding(0.03.width),
      ),
    );
  }
}
