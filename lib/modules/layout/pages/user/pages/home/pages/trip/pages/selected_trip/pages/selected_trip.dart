import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';
import 'package:travel_go/core/extensions/align.dart';
import 'package:travel_go/core/extensions/extensions.dart';
import 'package:travel_go/core/providers/collections_provider.dart';
import 'package:travel_go/core/theme/app_colors.dart';
import 'package:travel_go/core/widget/custom_elevated_button.dart';
import 'package:travel_go/core/widget/custom_text_button.dart';
import 'package:travel_go/core/widget/loading_image_network_widget.dart';
import 'package:travel_go/models/trip_data_model.dart';
import 'package:travel_go/modules/layout/pages/admin/pages/attractions/pages/update_attractions/widget/set_map_location.dart';
import 'package:travel_go/modules/layout/pages/admin/pages/trip_departures/data/use_case/departures.dart';
import 'package:travel_go/modules/layout/pages/user/pages/home/pages/trip/pages/selected_trip/pages/utilities_trip.dart';
import 'package:travel_go/modules/layout/pages/user/widget/app_bar.dart';

class SelectedHomeScreenTrip extends StatefulWidget {
  final TripDataModel model;

  const SelectedHomeScreenTrip({
    super.key,
    required this.model,
  });

  @override
  State<SelectedHomeScreenTrip> createState() => _SelectedHomeScreenTripState();
}

class _SelectedHomeScreenTripState extends State<SelectedHomeScreenTrip> {
  List<String> buttonsItems = [
    "Utilities",
    "Program",
    "Attractions",
    "Hotel",
    "Flight"
  ];

  int selectedIndex = 0;
  int totalPlaces = 0;

  _calcTotalPlaces() {
    widget.model.programDetails.forEach((e) {
      totalPlaces += e.attractions.length;
    });
    setState(() {});
  }

  @override
  void initState() {
    _calcTotalPlaces();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> body = [
      UtilitiesTrip(
        model: widget.model,
        totalPlaces: totalPlaces,
      ),
    ];
    var theme = Theme.of(context).textTheme;
    var provider = Provider.of<CollectionsProvider>(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppBarWidget(),
            0.01.height.hSpace,
            SizedBox(
              height: 0.4.height,
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(25),
                    child: LoadingImageNetworkWidget(
                      imageUrl: widget.model.imageUrl!,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        widget.model.destination,
                        style: theme.titleMedium!.copyWith(
                          color: AppColors.whiteColor,
                        ),
                      ),
                      Spacer(),
                      IconButton(
                        onPressed: () {},
                        style: IconButton.styleFrom(
                          backgroundColor: AppColors.whiteColor,
                          padding: EdgeInsets.zero,
                        ),
                        icon: Icon(
                          Icons.bookmark_border,
                          color: AppColors.newBlueColor,
                        ),
                      ),
                      0.01.height.hSpace,
                    ],
                  ).alignBottom().hPadding(0.02.width).vPadding(0.01.height),
                  BackButton(
                    style: ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(
                        AppColors.whiteColor,
                      ),
                    ),
                  ).allPadding(5)
                ],
              ),
            ),
            0.015.height.hSpace,
            SizedBox(
              height: 0.04.height,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) => CustomTextButton(
                  onPressed: () {
                    selectedIndex = index;
                    setState(() {});
                  },
                  text: buttonsItems[index],
                  textSize: 13,
                  textColor: (selectedIndex == index)
                      ? AppColors.blackColor
                      : AppColors.newBlueColor,
                ),
                separatorBuilder: (context, index) => 0.08.width.vSpace,
                itemCount: buttonsItems.length,
              ),
            ),
            body[selectedIndex],
          ],
        ).hPadding(0.03.width),
      ),
    );
  }
}
