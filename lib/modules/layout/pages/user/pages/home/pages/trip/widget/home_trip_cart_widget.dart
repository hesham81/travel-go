import 'package:flutter/material.dart';
import '/core/extensions/align.dart';
import '/core/widget/labels_widget.dart';
import '/core/extensions/extensions.dart';
import '/core/theme/app_colors.dart';
import '/core/widget/loading_image_network_widget.dart';
import '/models/trip_data_model.dart';

class HomeTripCartWidget extends StatelessWidget {
  final TripDataModel model;

  const HomeTripCartWidget({
    super.key,
    required this.model,
  });

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).textTheme;
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
                  value: model.tripName,
                ),
                0.01.height.hSpace,
                LabelsWidget(
                  label: "From : ",
                  value: model.source,
                ),
                0.01.height.hSpace,
                LabelsWidget(
                  label: "To : ",
                  value: model.destination,
                ),
                0.01.height.hSpace,
                LabelsWidget(
                  label: "Price : ",
                  value: "${model.price} ${model.currency}",
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
                    imageUrl: model.imageUrl!,
                  ),
                ),
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
                ).alignTopRight(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
