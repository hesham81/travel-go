import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel_go/core/extensions/dimensions.dart';
import 'package:travel_go/core/extensions/extensions.dart';
import 'package:travel_go/core/providers/collections_provider.dart';
import 'package:travel_go/core/widget/dividers_word.dart';
import 'package:travel_go/core/widget/labels_widget.dart';
import 'package:travel_go/modules/layout/pages/user/widget/app_bar.dart';

import '../../../../../../../../../../../../../core/theme/app_colors.dart';
import '../../../../../../../../../../../../../core/widget/loading_image_network_widget.dart';

class RoomPrices extends StatelessWidget {
  const RoomPrices({super.key});

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<CollectionsProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Room Prices",
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: AppColors.whiteColor,
              ),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: AppColors.whiteColor,
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            AppBarWidget(),
            0.01.height.hSpace,
            DividersWord(
              text: provider.getHotel!.accomdations.first.roomType,
            ),
            0.01.height.hSpace,
            LabelsWidget(
              label: "Price : ",
              value:
                  "${provider.getHotel!.accomdations.first.roomPrice.toString()} ${provider.getTrip!.currency}",
            ),
            0.01.height.hSpace,
            LabelsWidget(
              label: "Available Rooms : ",
              value:
                  "${provider.getHotel!.accomdations.first.roomAvailable.toString()} Room",
            ),
            0.01.height.hSpace,
            CarouselSlider(
              items: provider.getHotel!.accomdations.first.imagesUrls
                  .map(
                    (e) => LoadingImageNetworkWidget(imageUrl: e),
                  )
                  .toList(),
              options: CarouselOptions(
                height: 400,
                aspectRatio: 16 / 9,
                viewportFraction: 0.8,
                initialPage: 0,
                enableInfiniteScroll: true,
                reverse: false,
                autoPlay: true,
                autoPlayInterval: Duration(seconds: 3),
                autoPlayAnimationDuration: Duration(milliseconds: 800),
                autoPlayCurve: Curves.fastOutSlowIn,
                enlargeCenterPage: true,
                enlargeFactor: 0.3,
                scrollDirection: Axis.horizontal,
              ),
            ),
            0.01.height.hSpace,
            DividersWord(
              text: provider.getHotel!.accomdations[1].roomType,
            ),
            0.01.height.hSpace,
            LabelsWidget(
              label: "Price : ",
              value:
                  "${provider.getHotel!.accomdations[1].roomPrice.toString()} ${provider.getTrip!.currency}",
            ),
            0.01.height.hSpace,
            LabelsWidget(
              label: "Available Rooms : ",
              value:
                  "${provider.getHotel!.accomdations[1].roomAvailable.toString()} Room",
            ),
            0.01.height.hSpace,
            CarouselSlider(
              items: provider.getHotel!.accomdations[1].imagesUrls
                  .map(
                    (e) => LoadingImageNetworkWidget(imageUrl: e),
                  )
                  .toList(),
              options: CarouselOptions(
                height: 400,
                aspectRatio: 16 / 9,
                viewportFraction: 0.8,
                initialPage: 0,
                enableInfiniteScroll: true,
                reverse: false,
                autoPlay: true,
                autoPlayInterval: Duration(seconds: 3),
                autoPlayAnimationDuration: Duration(milliseconds: 800),
                autoPlayCurve: Curves.fastOutSlowIn,
                enlargeCenterPage: true,
                enlargeFactor: 0.3,
                scrollDirection: Axis.horizontal,
              ),
            ),
            0.01.height.hSpace,
            DividersWord(
              text: provider.getHotel!.accomdations[2].roomType,
            ),
            0.01.height.hSpace,
            LabelsWidget(
              label: "Price : ",
              value:
                  "${provider.getHotel!.accomdations[2].roomPrice.toString()} ${provider.getTrip!.currency}",
            ),
            0.01.height.hSpace,
            LabelsWidget(
              label: "Available Rooms : ",
              value:
                  "${provider.getHotel!.accomdations[2].roomAvailable.toString()} Room",
            ),
            0.01.height.hSpace,
            CarouselSlider(
              items: provider.getHotel!.accomdations[2].imagesUrls
                  .map(
                    (e) => LoadingImageNetworkWidget(imageUrl: e),
                  )
                  .toList(),
              options: CarouselOptions(
                height: 400,
                aspectRatio: 16 / 9,
                viewportFraction: 0.8,
                initialPage: 0,
                enableInfiniteScroll: true,
                reverse: false,
                autoPlay: true,
                autoPlayInterval: Duration(seconds: 3),
                autoPlayAnimationDuration: Duration(milliseconds: 800),
                autoPlayCurve: Curves.fastOutSlowIn,
                enlargeCenterPage: true,
                enlargeFactor: 0.3,
                scrollDirection: Axis.horizontal,
              ),
            ),
            0.05.height.hSpace,
          ],
        ).hPadding(0.03.width),
      ),
    );
  }
}
