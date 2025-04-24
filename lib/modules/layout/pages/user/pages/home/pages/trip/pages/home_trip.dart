import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:route_transitions/route_transitions.dart';
import 'package:travel_go/core/constant/app_assets.dart';
import 'package:travel_go/core/providers/collections_provider.dart';
import 'package:travel_go/modules/layout/pages/user/pages/home/pages/trip/widget/model_sheet_trip_filter.dart';
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
  bool _isSearchEnabled = false;
  double _opacity = 1;
  List<TripDataModel>? searchList = [];

  _search(String query) {
    searchList = tripList
        .where(
          (element) =>
              element.tripName.toLowerCase().contains(query.toLowerCase()),
        )
        .toList();
    if (searchList!.isEmpty) searchList = null;
    setState(() {});
  }

  int _sortIndex = 0;
  int _filterIndex = 0;

  void _showModelSheet(BuildContext context) {
    showModalBottomSheet(
      backgroundColor: AppColors.whiteColor,
      isScrollControlled: true,
      scrollControlDisabledMaxHeightRatio: 1.height,
      context: context,
      builder: (context) => ModelSheetTripFilter(
        sortAToZ: _sortAtoZ,
        sortZToA: _sortZToA,
        sortIndex: _sortIndex,
        bookMarked: _bookMarked,
        sortPriceLowToHigh: _sortPriceLowToHigh,
        sortPriceHighToLow: _sortPriceHighToLow,
        filterIndex: _filterIndex,
        trips: searchList!,
        lessThanWeek: _lessThanWeek,
      ),
    );
  }

  void _lessThanWeek() {
    if (searchList == null) return;
    _filterIndex = 1;
    searchList!.clear();
    searchList!.addAll(tripList.where(
      (element) => element.totalDays <= 7,
    ));

    setState(() {});
    Navigator.pop(context);
  }

  void _sortPriceLowToHigh() {
    if (searchList == null) return;

    searchList!.sort((a, b) => a.price.compareTo(b.price));
    _sortIndex = 2;
    setState(() {});
    Navigator.pop(context);
  }

  void _sortPriceHighToLow() {
    if (searchList == null) return;

    searchList!.sort((a, b) => b.price.compareTo(a.price));
    _sortIndex = 3;
    setState(() {});
    Navigator.pop(context);
  }

  _bookMarked() {
    if (searchList == null) return;
    _filterIndex = 0;
    searchList!.clear();
    searchList!.addAll(tripList.where(
      (element) =>
          element.favourites != null && element.favourites!.contains(user!.uid),
    ));

    setState(() {});
    Navigator.pop(context);
  }

  _sortAtoZ() {
    if (searchList == null) return;
    searchList!.sort(
      (a, b) => a.tripName.toLowerCase().compareTo(b.tripName.toLowerCase()),
    );
    _sortIndex = 0;
    setState(() {});
    Navigator.pop(context);
  }

  _sortZToA() {
    if (searchList == null) return;
    searchList!.sort(
      (a, b) => b.tripName.toLowerCase().compareTo(a.tripName.toLowerCase()),
    );
    _sortIndex = 1;
    setState(() {});
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var provider = Provider.of<CollectionsProvider>(context);

    return RefreshIndicator(
      onRefresh: () async {
        setState(() {});
      },
      color: AppColors.newBlueColor,
      backgroundColor: AppColors.whiteColor,
      child: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        child: SafeArea(
          child: Column(
            children: [
              AppBarWidget(),
              0.02.height.hSpace,
              if (!_isSearchEnabled)
                AnimatedOpacity(
                  opacity: _opacity,
                  duration: Duration(seconds: 1),
                  child: Row(
                    children: [
                      Column(
                        children: [
                          Text(
                            "Hi , ${user!.displayName}",
                            style: theme.textTheme.titleMedium!.copyWith(
                              color: AppColors.blackColor,
                            ),
                          ),
                          0.01.height.hSpace,
                          Text(
                            "Let's explore the world!",
                            style: theme.textTheme.titleSmall!.copyWith(
                              color: AppColors.newBlueColor,
                            ),
                          ),
                        ],
                      ),
                      Spacer(),
                      IconButton(
                        onPressed: () {
                          _isSearchEnabled = !_isSearchEnabled;
                          if (_opacity == 0) {
                            _opacity = 1;
                          } else {
                            _opacity = 0;
                          }
                          setState(() {});
                        },
                        style: IconButton.styleFrom(
                            backgroundColor: AppColors.newBlueColor,
                            padding: EdgeInsets.all(12)),
                        icon: Icon(
                          Icons.search,
                          color: AppColors.whiteColor,
                        ),
                      ),
                      0.01.width.vSpace,
                    ],
                  ),
                ),
              if (_isSearchEnabled)
                Row(
                  children: [
                    Expanded(
                      flex: 10,
                      child: CupertinoSearchTextField(
                        autocorrect: true,
                        autofocus: true,
                        onChanged: _search,
                        onSubmitted: (value) {},
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: IconButton(
                        onPressed: () {
                          _showModelSheet(context);
                        },
                        icon: Icon(
                          Icons.filter_list,
                        ),
                      ),
                    ),
                  ],
                ),
              Visibility(
                visible: !_isSearchEnabled,
                child: Column(
                  children: [
                    0.02.height.hSpace,
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
                  ],
                ),
              ),
              0.01.height.hSpace,
              Text(
                (_isSearchEnabled) ? "Search Results" : "Featured Trips",
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
                  if (searchList?.isEmpty == true) searchList = tripList;
                  if (searchList == null) {
                    return Image.asset(AppAssets.noSearchResult);
                  }
                  return ListView.separated(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) => GestureDetector(
                      onTap: () {
                        provider.setTrip(searchList![index]);
                        slideRightWidget(
                          context: context,
                          newPage: SelectedHomeScreenTrip(
                            model: searchList![index],
                          ),
                        );
                      },
                      child: HomeTripCartWidget(
                        model: searchList![index],
                      ),
                    ),
                    separatorBuilder: (context, index) => 0.01.height.hSpace,
                    itemCount: searchList!.length,
                  );
                },
              ),
              0.01.height.hSpace,
            ],
          ).hPadding(0.03.width),
        ),
      ),
    );
  }
}
