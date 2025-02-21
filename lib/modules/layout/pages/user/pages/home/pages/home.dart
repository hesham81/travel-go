import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:travel_go/core/widget/custom_text_button.dart';
import 'package:travel_go/core/widget/loading_image_network_widget.dart';
import 'package:travel_go/modules/sign_in/pages/sign_in.dart';
import '/core/widget/custom_elevated_button.dart';
import '/core/theme/app_colors.dart';
import '/core/utils/firebase_auth_services.dart';
import '/modules/first_screen/pages/first_screen.dart';
import '/modules/layout/pages/user/pages/home/widget/filter_widget.dart';
import '/modules/layout/pages/user/pages/home/widget/my_drawer.dart';
import '/modules/layout/pages/user/pages/v1/flight.dart';
import '/modules/layout/pages/user/pages/home/widget/trip_card_widget.dart';
import '/core/constant/app_assets.dart';
import '/models/trip_model.dart';
import '/core/extensions/extensions.dart';
import '/core/widget/search_widget.dart';

class Home extends StatefulWidget {
  static const routeName = '/home';

  Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var user = FirebaseAuthServices.getCurrentUserData();

  _openBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => FilterWidget(),
      isDismissible: true,
      enableDrag: true,
    );
  }

  @override
  void initState() {
    super.initState();
  }

  var searchController = TextEditingController();
  List<TripModel> searchList = [];
  List<TripModel> tripList = [
    TripModel(
      id: '1',
      imageUrl: AppAssets.dahabaIMG,
      title: 'Dahab',
      startDateTime: DateTime(2024, 10, 12),
      endDateTime: DateTime(2024, 10, 15),
      price: 3000,
    ),
    TripModel(
      id: '5',
      imageUrl: AppAssets.dahabaIMG,
      title: 'Dynamo Kiev',
      startDateTime: DateTime(2024, 10, 12),
      endDateTime: DateTime(2024, 10, 15),
      price: 1800,
      currency: "USD",
    ),
    TripModel(
      id: '6',
      imageUrl: AppAssets.sharmIMG,
      title: 'Aswan',
      startDateTime: DateTime(2024, 10, 12),
      endDateTime: DateTime(2024, 10, 15),
      price: 800,
    ),
    TripModel(
      id: '4',
      imageUrl: AppAssets.dahabaIMG,
      title: 'Sharm',
      startDateTime: DateTime(2025, 3, 12),
      endDateTime: DateTime(2025, 8, 15),
      price: 3000,
    ),
    TripModel(
      id: '2',
      imageUrl: AppAssets.sharmIMG,
      title: 'Dahab',
      startDateTime: DateTime(2024, 10, 16),
      endDateTime: DateTime(2024, 10, 19),
      price: 4000,
    ),
    TripModel(
      id: '3',
      imageUrl: AppAssets.dahabaIMG,
      title: 'Alex',
      startDateTime: DateTime(2024, 10, 20),
      endDateTime: DateTime(2024, 10, 23),
      price: 4500,
    ),
  ];
  String searchQueryText = "";

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              Row(
                children: [
                  Image.asset(
                    AppAssets.logo,
                    height: 60,
                    width: 60,
                    fit: BoxFit.cover,
                  ),
                  Text(
                    "Travel Go",
                    style: theme.textTheme.titleSmall!.copyWith(
                      color: AppColors.newBlueColor,
                    ),
                  ).hPadding(0.03.width),
                  Spacer(),
                  user.photoURL == null
                      ? Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(
                                AppAssets.noProfileImage,
                              ),
                            ),
                            shape: BoxShape.circle,
                          ),
                          height: 70,
                          width: 70,
                        )
                      : ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: LoadingImageNetworkWidget(
                            imageUrl: user.photoURL!,
                          ),
                        ),
                  0.01.width.vSpace,
                ],
              ),
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
            ],
          ).hPadding(0.03.width),
        ),
      ),
    );
  }

  void searchQuery() {
    searchList.clear();

    for (var trip in tripList) {
      if (trip.title.toLowerCase().contains(searchQueryText.toLowerCase())) {
        searchList.add(trip);
      } else if (trip.id
          .toLowerCase()
          .contains(searchQueryText.toLowerCase())) {
        searchList.add(trip);
      } else if (trip.currency
          .toLowerCase()
          .contains(searchQueryText.toLowerCase())) {
        searchList.add(trip);
      } else if (trip.price
          .toString()
          .toLowerCase()
          .contains(searchQueryText.toLowerCase())) {
        searchList.add(trip);
      } else if (trip.startDateTime.year
          .toString()
          .toLowerCase()
          .contains(searchQueryText.toLowerCase())) {
        searchList.add(trip);
      } else if (trip.endDateTime.day
          .toString()
          .toLowerCase()
          .contains(searchQueryText.toLowerCase())) {
        searchList.add(trip);
      } else if (trip.endDateTime.month
          .toString()
          .toLowerCase()
          .contains(searchQueryText.toLowerCase())) {
        searchList.add(trip);
      } else if (trip.price.toString() == searchQueryText) {
        searchList.add(trip);
      }
    }
    setState(() {});
  }
}
