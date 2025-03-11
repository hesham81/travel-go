import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel_go/core/providers/reservation_provider.dart';
import 'package:travel_go/core/utils/favourite_trip_collections.dart';
import 'package:travel_go/core/utils/firebase_auth_services.dart';
import 'package:travel_go/models/favourite_trip_model.dart';
import 'package:travel_go/modules/layout/pages/admin/menna/trippp/utils/trips_collections.dart';
import '/core/extensions/align.dart';
import '/core/widget/labels_widget.dart';
import '/core/extensions/extensions.dart';
import '/core/theme/app_colors.dart';
import '/core/widget/loading_image_network_widget.dart';
import '/models/trip_data_model.dart';

class HomeTripCartWidget extends StatefulWidget {
  final TripDataModel model;

  const HomeTripCartWidget({
    super.key,
    required this.model,
  });

  @override
  State<HomeTripCartWidget> createState() => _HomeTripCartWidgetState();
}

class _HomeTripCartWidgetState extends State<HomeTripCartWidget> {
  bool isFavourite = false;

  _checkIfFavourite() {
    var user = FirebaseAuthServices.getCurrentUserData();

    if (widget.model.favourites?.isNotEmpty ?? false)
      for (String id in widget.model.favourites!) {
        if (id == user!.uid) {
          isFavourite = true;
          setState(() {});
          break;
        }
        else
          {
            isFavourite = false;
          }
      }
  }

  @override
  void initState() {
    _checkIfFavourite();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).textTheme;
    var provider = Provider.of<ReservationProvider>(context);
    return Container(
      height: 0.2.height,
      width: double.maxFinite,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.4),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              children: [
                LabelsWidget(
                  label: "Name : ",
                  value: widget.model.tripName,
                ),
                0.01.height.hSpace,
                LabelsWidget(
                  label: "From : ",
                  value: widget.model.source,
                ),
                0.01.height.hSpace,
                LabelsWidget(
                  label: "To : ",
                  value: widget.model.destination,
                ),
                0.01.height.hSpace,
                LabelsWidget(
                  label: "Price : ",
                  value: "${widget.model.price} ${widget.model.currency}",
                ),
                0.01.height.hSpace,
              ],
            ).allPadding(5),
          ),
          Expanded(
            flex: 1,
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                  child: LoadingImageNetworkWidget(
                    imageUrl: widget.model.imageUrl!,
                  ),
                ),
                IconButton(
                  onPressed: () async {
                    if (isFavourite) {
                      int index = widget.model.favourites!.indexOf(
                        provider.user!.uid,
                      );
                      widget.model.favourites!.removeAt(index);
                      widget.model.favourites!.remove(
                          FirebaseAuthServices.getCurrentUserData()!.uid);
                      await TripCollections.updateFavouriteTrip(widget.model);
                      isFavourite = false;
                      setState(() {});
                    } else {
                      widget.model.favourites!
                          .add(FirebaseAuthServices.getCurrentUserData()!.uid);
                      await TripCollections.updateFavouriteTrip(widget.model);
                      isFavourite = true;
                      setState(() {});
                    }
                  },
                  style: IconButton.styleFrom(
                    backgroundColor: AppColors.whiteColor,
                    padding: EdgeInsets.zero,
                  ),
                  icon: (isFavourite)
                      ? Icon(
                          Icons.bookmark,
                          color: AppColors.newBlueColor,
                        )
                      : Icon(
                          Icons.bookmark_border,
                          color: AppColors.newBlueColor,
                        ),
                ).alignTopRight(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
