import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/modules/layout/pages/admin/menna/trippp/model/company_model.dart';
import '/modules/layout/pages/admin/pages/trip_departures/widget/trip_filter_bottom_sheet.dart';
import '/core/constant/app_assets.dart';
import '/core/extensions/align.dart';
import '/core/routes/route_transact.dart';
import '/models/trip_data_model.dart';
import '/modules/layout/pages/admin/pages/trip_departures/pages/browse_departure/pages/explore_selected_list_of_departures.dart';
import '/core/providers/collections_provider.dart';
import '/core/extensions/extensions.dart';
import '/core/theme/app_colors.dart';
import '/modules/layout/pages/admin/pages/trip_departures/pages/browse_departure/widget/trip_explorer.dart';

class BrowseTripDeparture extends StatefulWidget {
  const BrowseTripDeparture({super.key});

  @override
  State<BrowseTripDeparture> createState() => _BrowseTripDepartureState();
}

class _BrowseTripDepartureState extends State<BrowseTripDeparture> {
  final TextEditingController searchController = TextEditingController();
  List<TripDataModel> searchList = [];
  List<TripDataModel> allList = [];
  bool isFirstTime = false;

  _startWithSearchList(CollectionsProvider provider) {
    searchList.addAll(provider.getAllTripsData);
    allList.addAll(provider.getAllTripsData);
    isFirstTime = true;
    setState(() {});
  }

  _showBottomModelSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => TripFilterBottomSheet(
        sortAToZ: _sortAToZ,
        sortZToA: _sortZToA,
        mostCheep: _mostCheep,
        companyFilter: _companyFilter,
      ),
      isScrollControlled: true,
      enableDrag: true,
      isDismissible: true,
    );
  }

  _sortAToZ() {
    searchList.sort(
      (a, b) => a.tripName.toLowerCase().compareTo(b.tripName.toLowerCase()),
    );
    setState(() {});
    Navigator.pop(context);
  }

  _sortZToA() {
    searchList.sort(
      (a, b) => b.tripName.toLowerCase().compareTo(a.tripName.toLowerCase()),
    );
    setState(() {});
    Navigator.pop(context);
  }

  _mostCheep() {
    double cheepPrice = searchList.first.price;
    for (var price in searchList) {
      if (price.price < cheepPrice) {
        cheepPrice = price.price;
      }
    }
    searchList = searchList
        .where(
          (element) => element.price == cheepPrice,
        )
        .toList();
    setState(() {});
    Navigator.pop(context);
  }

  _companyFilter(Company? company) {
    if (company == null) {
      _startWithSearchList(
        Provider.of<CollectionsProvider>(context, listen: false),
      );
    } else {
      Provider.of<CollectionsProvider>(context, listen: false).getAllTrips();
      allList = Provider.of<CollectionsProvider>(context, listen: false).getAllTripsData;
      searchList = allList
          .where(
            (element) =>
                element.organizedBy.companyName == company.companyName &&
                element.tripName.toLowerCase().contains(searchController.text.toLowerCase()),
          )
          .toList();
      setState(() {});
    }
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).textTheme;
    var provider = Provider.of<CollectionsProvider>(context);
    if (isFirstTime == false) {
      _startWithSearchList(provider);
    }
    onSearchChanged(String searchQuery) {
      searchList.clear();
      for (var trip in provider.getAllTripsData) {
        if (trip.tripName.toLowerCase().contains(
              searchQuery.toLowerCase(),
            )) {
          searchList.add(trip);
        }
      }
    }

    setState(() {});

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            Icons.arrow_back_ios,
          ),
        ),
        title: Text(
          "Trip Departures",
          style: theme.titleLarge!.copyWith(
            color: AppColors.whiteColor,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            0.01.height.hSpace,
            Row(
              children: [
                Expanded(
                  flex: 10,
                  child: CupertinoSearchTextField(
                    controller: searchController,
                    autocorrect: true,
                    autofocus: true,
                    onChanged: (value) {
                      onSearchChanged(value);
                      setState(() {});
                    },
                    onSubmitted: (value) {},
                  ),
                ),
                if (searchController.text.isNotEmpty)
                  Expanded(
                    flex: 1,
                    child: IconButton(
                      onPressed: () {
                        _showBottomModelSheet(context);
                      },
                      icon: Icon(
                        Icons.filter_list,
                      ),
                    ),
                  ),
              ],
            ),
            0.01.height.hSpace,
            (searchList.isEmpty)
                ? Column(
                    children: [
                      0.2.height.hSpace,
                      Image.asset(AppAssets.noSearchResult).center,
                    ],
                  )
                : ListView.separated(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) => GestureDetector(
                      onTap: () => Navigator.push(
                        context,
                        SlideRightRoute(
                          page: ExploreSelectedListOfDepartures(
                            model: (searchList.isNotEmpty)
                                ? searchList[index]
                                : provider.getAllTripsData[index],
                          ),
                        ),
                      ),
                      child: TripExplorer(
                        model: searchList[index],
                      ),
                    ),
                    separatorBuilder: (context, _) => 0.01.height.hSpace,
                    itemCount: searchList.length,
                  ),
          ],
        ).hPadding(0.03.width),
      ),
    );
  }
}
