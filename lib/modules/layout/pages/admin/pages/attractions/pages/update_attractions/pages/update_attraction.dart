import 'package:awesome_alert/awesome_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '/core/widget/custom_elevated_button.dart';
import '/core/widget/search_widget.dart';
import '../widget/update_widget.dart';
import '/modules/layout/pages/admin/pages/attractions/pages/update_attractions/pages/selected_attraction.dart';
import '/core/extensions/align.dart';
import '/core/theme/app_colors.dart';
import '/core/utils/attractions_db.dart';
import '/core/extensions/extensions.dart';
import '/models/attractions_model.dart';

class UpdateAttraction extends StatefulWidget {
  const UpdateAttraction({
    super.key,
  });

  @override
  State<UpdateAttraction> createState() => _UpdateAttractionState();
}

class _UpdateAttractionState extends State<UpdateAttraction> {
  List<AttractionsModel> attractions = [];
  List<AttractionsModel> searchedAttraction = [];
  String searchQuery = "";

  List<String> attractionCategories = [
    "   all   ",
    "Natural Attractions",
    "Cultural & Historical Attractions",
    "Urban & Architectural Attractions",
    "Parks & Protected Areas",
    "Entertainment & Recreational Attractions",
    "Religious & Spiritual Attractions",
    "Adventure & Outdoor Attractions",
  ];

  int selectedIndex = 0;
  int sortIndex = 0;
  int categoryIndex = 0;
  TextEditingController controller = TextEditingController();

  _showBottomModelSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          width: double.maxFinite,
          decoration: BoxDecoration(
            color: AppColors.whiteColor,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(20),
              topLeft: Radius.circular(20),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                "Categories",
                style: TextTheme.of(context).titleMedium,
              ),
              0.01.height.hSpace,
              SizedBox(
                height: 0.05.height,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) => CustomElevatedButton(
                    text: attractionCategories[index],
                    btnColor: (categoryIndex == index)
                        ? AppColors.greyColor
                        : AppColors.newBlueColor,
                    borderColor: (categoryIndex == index)
                        ? AppColors.newBlueColor
                        : AppColors.greyColor,
                    borderWidth: 1.2,
                    onPressed: () {
                      categoryIndex = index;
                      setState(() {});
                      Navigator.pop(context);
                    },
                    textColor: (categoryIndex == index)
                        ? AppColors.blackColor
                        : AppColors.whiteColor,
                  ),
                  separatorBuilder: (context, index) => 0.01.width.vSpace,
                  itemCount: attractionCategories.length,
                ),
              ),
              0.01.height.hSpace,
              Divider(
                color: AppColors.blackColor,
              ).hPadding(
                0.05.width,
              ),
              0.01.height.hSpace,
              Row(
                children: [
                  Text(
                    "Sort",
                    style: TextTheme.of(context).titleMedium,
                  ),
                  0.03.width.vSpace,
                  CustomElevatedButton(
                    text: "A-Z",
                    btnColor: (sortIndex == 0)
                        ? AppColors.greyColor
                        : AppColors.newBlueColor,
                    borderColor: (sortIndex == 0)
                        ? AppColors.newBlueColor
                        : AppColors.greyColor,
                    borderWidth: 1.2,
                    textColor: (sortIndex == 0)
                        ? AppColors.blackColor
                        : AppColors.whiteColor,
                    onPressed: () {
                      sortIndex = 0;
                      setState(() {});
                      Navigator.pop(context);
                    },
                  ),
                  Spacer(),
                  CustomElevatedButton(
                    text: "Z-A",
                    btnColor: (sortIndex == 1)
                        ? AppColors.greyColor
                        : AppColors.newBlueColor,
                    borderColor: (sortIndex == 1)
                        ? AppColors.newBlueColor
                        : AppColors.greyColor,
                    borderWidth: 1.2,
                    textColor: (sortIndex == 1)
                        ? AppColors.blackColor
                        : AppColors.whiteColor,
                    onPressed: () {
                      sortIndex = 1;
                      setState(() {});
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
              0.01.height.hSpace,
              Divider(
                color: AppColors.blackColor,
              ).hPadding(
                0.05.width,
              ),
              0.01.height.hSpace,
              Text(
                "Distance",
                style: TextTheme.of(context).titleMedium,
              ),
              0.03.width.vSpace,
              CustomElevatedButton(
                text: "More Than 10KM",
                onPressed: () {},
              ),
              0.03.width.vSpace,
              CustomElevatedButton(
                text: "More Than 50KM",
                onPressed: () {},
              ),
              0.03.width.vSpace,
              CustomElevatedButton(
                text: "More Than 100KM",
                onPressed: () {},
              ),
              0.03.width.vSpace,
              CustomElevatedButton(
                text: "More Than 500KM",
                onPressed: () {},
              ),
              0.03.width.vSpace,
              CustomElevatedButton(
                text: "More Than 1000KM",
                onPressed: () {},
              ),
            ],
          ).allPadding(10),
        );
      },
    );
  }

  List<AttractionsModel> allAttractions = [];

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
            SearchWidget(
              controller: controller,
              suffixIcon: (searchQuery == "")
                  ? IconButton(
                      onPressed: () {
                        _showBottomModelSheet(context);
                      },
                      icon: Icon(
                        Icons.filter_list,
                      ),
                    )
                  : IconButton(
                      onPressed: () {
                        searchQuery = "";
                        setState(() {});
                      },
                      icon: Icon(
                        Icons.search_off_outlined,
                      ),
                    ),
              search: (value) {
                setState(() {
                  searchQuery = value; // Update the search query
                  if (searchQuery.isNotEmpty) {
                    attractions = allAttractions.where((element) {
                      return element.title
                          .toLowerCase()
                          .contains(searchQuery.toLowerCase());
                    }).toList();
                  } else {
                    attractions = List.from(allAttractions);
                  }
                });
              },
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
                        itemBuilder: (context, index) =>
                            UpdateExploreAttraction(
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
                allAttractions = snapshot.data!.docs
                    .map(
                      (e) => e.data(),
                    )
                    .toList();
                attractions = snapshot.data!.docs.map(
                  (e) {
                    if (e.data().category ==
                        attractionCategories[categoryIndex]) {
                      searchedAttraction.add(e.data());
                      return e.data();
                    } else {
                      return e.data();
                    }
                  },
                ).toList();

                if (categoryIndex == 0) {
                  attractions = List.from(allAttractions);
                } else if (categoryIndex == 1) {
                  attractions = allAttractions
                      .where((element) =>
                          element.category ==
                          attractionCategories[categoryIndex])
                      .toList();
                } else if (categoryIndex == 2) {
                  attractions = allAttractions
                      .where((element) =>
                          element.category ==
                          attractionCategories[categoryIndex])
                      .toList();
                } else if (categoryIndex == 3) {
                  attractions = allAttractions
                      .where((element) =>
                          element.category ==
                          attractionCategories[categoryIndex])
                      .toList();
                } else if (categoryIndex == 4) {
                  attractions = allAttractions
                      .where((element) =>
                          element.category ==
                          attractionCategories[categoryIndex])
                      .toList();
                } else if (categoryIndex == 5) {
                  attractions = allAttractions
                      .where((element) =>
                          element.category ==
                          attractionCategories[categoryIndex])
                      .toList();
                } else if (categoryIndex == 6) {
                  attractions = allAttractions
                      .where((element) =>
                          element.category ==
                          attractionCategories[categoryIndex])
                      .toList();
                } else if (categoryIndex == 7) {
                  attractions = allAttractions
                      .where((element) =>
                          element.category ==
                          attractionCategories[categoryIndex])
                      .toList();
                }
                if (attractions.isNotEmpty) {
                  if (sortIndex == 0) {
                    attractions.sort(
                        (a, b) => a.title.compareTo(b.title)); // Ascending
                  } else {
                    attractions.sort(
                        (a, b) => b.title.compareTo(a.title)); // Descending
                  }
                }

                return ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) => UpdateExploreAttraction(
                    model: attractions[index],
                    deleteFunction: () {
                      AwesomeAlert alert = AwesomeAlert(context: context);
                      alert.showAlert(
                        title: "Delete",
                        description:
                            "You Make Sure That You Are Need To Delete ${attractions[index].title} ? ",
                        confirmText: "OK",
                        confirmAction: () {
                          alert.hideAlert();
                          AttractionsDB.deleteAttraction(attractions[index]);
                          EasyLoading.showSuccess(
                            "${attractions[index]} Is Deleted Successfully",
                          );
                        },
                        confirmButtonColor: AppColors.newBlueColor,
                        cancelable: true,
                        cancelText: "Cancel",
                        cancelAction: () => alert.hideAlert(),
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
                );
              },
            ),
          ],
        ).hPadding(0.03.width),
      ),
    );
  }
}
