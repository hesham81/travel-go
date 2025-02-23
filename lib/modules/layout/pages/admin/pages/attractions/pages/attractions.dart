import 'package:flutter/material.dart';
import '/core/extensions/extensions.dart';
import '/core/theme/app_colors.dart';
import '/modules/layout/pages/admin/pages/attractions/pages/delete_attractions/pages/delete_attraction.dart';
import '/modules/layout/pages/admin/pages/attractions/pages/new_attractions/pages/new_attraction.dart';
import '/modules/layout/pages/admin/pages/attractions/pages/update_attractions/pages/update_attraction.dart';

class Attractions extends StatefulWidget {
  const Attractions({super.key});

  @override
  State<Attractions> createState() => _AttractionsState();
}

class _AttractionsState extends State<Attractions> {
  int selectedIndex = 0;

  _onPageChanged(int index) {
    selectedIndex = index;
    setState(
      () {},
    );
  }

  var pages = [
    NewAttraction(),
    UpdateAttraction(),
    DeleteAttraction(),
  ];

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: DefaultTabController(
        initialIndex: selectedIndex,
        length: 3,
        child: SingleChildScrollView(
          child: Column(
            children: [
              TabBar(
                dividerColor: Colors.transparent,
                isScrollable: false,
                onTap: _onPageChanged,
                tabs: [
                  Text(
                    "New Attractions",
                    style: theme.textTheme.titleLarge!.copyWith(
                      color: AppColors.blackColor,
                      fontSize: 12,
                    ),
                  ).vPadding(0.01.height),
                  Text(
                    "Update Attractions",
                    style: theme.textTheme.titleLarge!.copyWith(
                      color: AppColors.blackColor,
                      fontSize: 12,
                    ),
                  ).vPadding(0.01.height),
                  Text(
                    "Delete Attractions",
                    style: theme.textTheme.titleLarge!.copyWith(
                      color: AppColors.blackColor,
                      fontSize: 12,
                    ),
                  ).vPadding(0.01.height),
                ],
              ),
              0.01.height.hSpace,
              pages[selectedIndex]
            ],
          ),
        ),
      ),
    );
  }
}
