import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:travel_go/modules/layout/pages/user/pages/trips/selected_trip/selected_trip.dart';
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
        currency: "USD"),
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
      body: SafeArea(
        child: Column(
          children: [
            SearchWidget(
              controller: searchController,
              search: (value) {
                searchQueryText = value;
                searchQuery();
                setState(() {});
              },
            ).vPadding(0.01.height).hPadding(0.09.width),
            0.02.height.hSpace,
            Visibility(
              visible: searchList.isEmpty,
              replacement: Expanded(
                child: ListView.separated(
                  itemBuilder: (context, index) => TripCardWidget(
                    tripModel: searchList[index],
                  ),
                  separatorBuilder: (index, context) => 0.02.height.hSpace,
                  itemCount: searchList.length,
                ),
              ),
              child: Expanded(
                child: ListView.separated(
                  itemBuilder: (context, index) => GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        SelectedTrip.routeName,
                        arguments: tripList[index],
                      );
                    },
                    child: TripCardWidget(
                      tripModel: tripList[index],
                    ),
                  ),
                  separatorBuilder: (index, context) => 0.02.height.hSpace,
                  itemCount: tripList.length,
                ),
              ),
            )
          ],
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
