import 'package:flutter/material.dart';
import 'package:travel_go/core/extensions/extensions.dart';
import '/core/theme/app_colors.dart';
import '/core/widget/loading_image_network_widget.dart';
import '/models/flight_model.dart';

class FlightsWidget extends StatelessWidget {
  final Flight model;
  final Function()? onTap;

  const FlightsWidget({
    super.key,
    required this.model,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.maxFinite,
        decoration: BoxDecoration(
          color: AppColors.greyColor,
          borderRadius: BorderRadius.circular(
            25,
          ),
        ),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  model.flightName,
                  style: theme.textTheme.titleLarge,
                ),
                Spacer(),
                SizedBox(
                  height: 0.1.height,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: LoadingImageNetworkWidget(
                      imageUrl: model.airline!.flightAirLineImageUrl,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ).allPadding(10),
      ),
    );
  }
}
