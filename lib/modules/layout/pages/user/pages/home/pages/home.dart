import 'dart:developer';

import 'package:flutter/material.dart';
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
  _openBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => FilterWidget(),
      isDismissible: true,
      enableDrag: true,
    );
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
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text(
          "Travel Go",
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.notifications,
            ),
          ),
          IconButton(
            onPressed: () {
              FirebaseAuthServices.logout();
              Navigator.pushNamedAndRemoveUntil(
                context,
                FirstScreen.routeName,
                (route) => false,
              );
            },
            icon: Icon(
              Icons.logout,
              color: AppColors.errorColor,
            ),
          ),
        ],
      ),
      drawer: MyDrawer(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: DefaultTabController(
            length: 3,
            child: Column(
              children: [
                SearchWidget(
                  controller: searchController,
                  suffixIcon: searchQueryText != ""
                      ? IconButton(
                          onPressed: () {
                            _openBottomSheet(context);
                          },
                          icon: Icon(
                            Icons.filter_list,
                          ),
                        )
                      : null,
                  search: (value) {
                    searchQueryText = value;
                    searchQuery();
                    setState(
                      () {},
                    );
                  },
                ).vPadding(0.01.height).hPadding(0.09.width),
                0.01.height.hSpace,
                TabBar(
                  onTap: (index) {},
                  dividerColor: Colors.transparent,
                  indicatorColor: Colors.transparent,
                  tabs: [
                    CustomElevatedButton(
                      text: "Trip",
                      onPressed: () {
                        btnColor:
                        Colors.grey.withAlpha(80);
                      },
                      borderRadius: 15,
                      textSize: 12,
                      borderColor: AppColors.dodgurBlueColor,
                      btnColor: Colors.grey.withAlpha(80),
                      textColor: AppColors.blackColor,
                    ),
                    CustomElevatedButton(
                      text: "Flight",
                      onPressed: () {
                        btnColor:
                        Colors.grey.withAlpha(80);
                      },
                      borderRadius: 15,
                      textSize: 12,
                      btnColor: AppColors.dodgurBlueColor,
                      textColor: AppColors.whiteColor,
                    ),
                    CustomElevatedButton(
                      text: "Hotel",
                      onPressed: () {
                        btnColor:
                        Colors.grey.withAlpha(80);
                      },
                      borderRadius: 15,
                      textSize: 12,
                      btnColor: AppColors.dodgurBlueColor,
                      textColor: AppColors.whiteColor,
                    ),
                  ],
                ).hPadding(0.03.width),
                0.02.height.hSpace,
                Visibility(
                  visible: searchList.isEmpty,
                  replacement: ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) => GestureDetector(
                      onTap: () {
                        log('Clicked');
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DahabTripScreen(),
                          ),
                        );
                      },
                      child: TripCardWidget(
                        tripModel: searchList[index],
                      ),
                    ),
                    separatorBuilder: (index, context) => 0.02.height.hSpace,
                    itemCount: searchList.length,
                  ),
                  child: ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) => GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DahabTripScreen()));
                      },
                      child: TripCardWidget(
                        tripModel: tripList[index],
                      ),
                    ),
                    separatorBuilder: (index, context) => 0.02.height.hSpace,
                    itemCount: tripList.length,
                  ),
                )
              ],
            ),
          ),
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
