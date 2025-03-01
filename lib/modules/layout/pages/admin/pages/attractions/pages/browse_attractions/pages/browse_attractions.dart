import 'package:flutter/material.dart';
import 'package:searchfield/searchfield.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '/modules/layout/pages/admin/pages/attractions/widget/selected_deleted_widget.dart';
import '/modules/layout/pages/admin/pages/attractions/pages/update_attractions/pages/selected_attraction.dart';
import '/core/extensions/align.dart';
import '/core/theme/app_colors.dart';
import '/core/utils/attractions_db.dart';
import '/modules/layout/pages/admin/pages/attractions/widget/all_explore_widget.dart';
import '/core/extensions/extensions.dart';
import '/models/attractions_model.dart';

class BrowseAttractions extends StatefulWidget {
  const BrowseAttractions({
    super.key,
  });

  @override
  State<BrowseAttractions> createState() => _BrowseAttractionsState();
}

List<String> attractionCategories = [
  "all",
  "Natural Attractions",
  "Cultural & Historical Attractions",
  "Urban & Architectural Attractions",
  "Parks & Protected Areas",
  "Entertainment & Recreational Attractions",
  "Religious & Spiritual Attractions",
  "Adventure & Outdoor Attractions",
];

class _BrowseAttractionsState extends State<BrowseAttractions> {
  List<AttractionsModel> attractions = [];
  List<AttractionsModel> searchedAttraction = [];
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Travel Go"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            0.01.height.hSpace,
            SearchField<AttractionsModel>(
              dynamicHeight: true,
              scrollbarDecoration: ScrollbarDecoration(
                thickness: 1.2,
                radius: Radius.circular(15),
              ),
              suggestions: attractions
                  .map(
                    (attraction) => SearchFieldListItem<AttractionsModel>(
                      attraction.title,
                      item: attraction,
                      child: ListTile(
                        title: Text(attraction.title),
                        subtitle: Text(attraction.location),
                      ),
                    ),
                  )
                  .toList(),
              searchInputDecoration: SearchInputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                hintText: "Search For Attraction",
                prefixIcon: Icon(Icons.search),
                suffixIcon: (searchedAttraction.isEmpty)
                    ? null
                    : IconButton(
                        onPressed: () {
                          searchedAttraction.clear();
                          setState(() {});
                        },
                        icon: Icon(Icons.search_off_outlined),
                      ),
              ),
              onSearchTextChanged: (query) {
                if (query.isEmpty) {
                  searchedAttraction.clear();
                  if (mounted) {
                    setState(() {});
                  }
                  return null;
                }

                final filteredAttractions = attractions.where((attraction) {
                  return attraction.title
                          .toLowerCase()
                          .contains(query.toLowerCase()) ||
                      attraction.location
                          .toLowerCase()
                          .contains(query.toLowerCase());
                }).toList();

                return filteredAttractions.map((attraction) {
                  return SearchFieldListItem<AttractionsModel>(
                    attraction.title,
                    item: attraction,
                    child: ListTile(
                      title: Text(attraction.title),
                      subtitle: Text(attraction.location),
                    ),
                  );
                }).toList();
              },
              onSuggestionTap:
                  (SearchFieldListItem<AttractionsModel> suggestion) {
                if (suggestion.item != null) {
                  searchedAttraction = [];
                  searchedAttraction.add(suggestion.item!);
                  setState(() {});
                }
              },
            ),
            0.01.height.hSpace,
            SizedBox(
              height: 0.05.height,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.zero,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      searchedAttraction.clear();
                      selectedIndex = index;
                      for(var element in attractions) {
                        if(element.category == attractionCategories[index]) {
                          searchedAttraction.add(element);
                        }
                      }
                      setState(() {});
                    },
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: (selectedIndex == index)
                            ? AppColors.newBlueColor
                            : AppColors.whiteColor,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: (selectedIndex == index)
                              ? AppColors.whiteColor
                              : AppColors.newBlueColor,
                        ),
                      ),
                      child: Text(
                        attractionCategories[index],
                        style:
                            Theme.of(context).textTheme.titleMedium!.copyWith(
                                  color: (selectedIndex == index)
                                      ? AppColors.whiteColor
                                      : AppColors.newBlueColor,
                                ),
                      ).allPadding(2),
                    ),
                  );
                },
                separatorBuilder: (context, _) => 0.02.width.vSpace,
                itemCount: attractionCategories.length,
              ),
            ),
            0.01.height.hSpace,
            StreamBuilder(
              stream: AttractionsDB.getAllAttractions(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.error_outline,
                        color: AppColors.greyColor,
                        size: 180,
                      ),
                      Text(
                        snapshot.error.toString(),
                      ).center
                    ],
                  );
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: Skeletonizer(
                      enabled: true,
                      enableSwitchAnimation: true,
                      child: ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) => AllExploreAttractions(
                          model: attractions[index],
                        ),
                        separatorBuilder: (context, index) =>
                            0.01.height.hSpace,
                        itemCount: 10,
                      ),
                    ),
                  );
                }
                if (snapshot.connectionState == ConnectionState.none) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.wifi_tethering_error,
                        color: AppColors.greyColor,
                        size: 180,
                      ),
                      Text(
                        "No Internet Connection",
                        style: Theme.of(context).textTheme.titleLarge,
                      ).center
                    ],
                  );
                }
                attractions = snapshot.data!.docs
                    .map(
                      (e) => e.data(),
                    )
                    .toList();

                return Visibility(
                  visible: searchedAttraction.isEmpty,
                  replacement: ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) => AllExploreAttractions(
                      model: searchedAttraction[index],
                      deleteFunction: () {
                        Navigator.pushNamed(
                          context,
                          SelectedDeletedWidget.routeName,
                          arguments: searchedAttraction[index],
                        );
                      },
                      editFunction: () {
                        Navigator.pushNamed(
                          context,
                          SelectedAttraction.routeName,
                          arguments: searchedAttraction[index],
                        );
                      },
                    ),
                    separatorBuilder: (context, index) => 0.01.height.hSpace,
                    itemCount: searchedAttraction.length,
                  ),
                  child: ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) => AllExploreAttractions(
                      model: attractions[index],
                      deleteFunction: () {
                        Navigator.pushNamed(
                          context,
                          SelectedDeletedWidget.routeName,
                          arguments: attractions[index],
                        );
                      },
                      editFunction: () {
                        Navigator.pushNamed(
                          context,
                          SelectedAttraction.routeName,
                          arguments: attractions[index],
                        );
                      },
                    ),
                    separatorBuilder: (context, index) => 0.01.height.hSpace,
                    itemCount: attractions.length,
                  ),
                );
              },
            ),
          ],
        ).hPadding(0.03.width),
      ),
    );
  }
}
