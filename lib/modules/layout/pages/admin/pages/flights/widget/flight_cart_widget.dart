import 'package:flutter/material.dart';
import '/core/widget/loading_image_network_widget.dart';
import '/models/flight_airlines.dart';
import '/core/extensions/extensions.dart';
import '/core/theme/app_colors.dart';

class FlightCartWidget extends StatelessWidget {
  final FlightAirlines model;

  const FlightCartWidget({
    super.key,
    required this.model,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: AppColors.dodgurBlueColor,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "${model.flighAirLineName} Air Line",
                      style: TextStyle(
                        fontSize: 15,
                        color: AppColors.blackColor,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: LoadingImageNetworkWidget(
                    imageUrl: model.flightAirLineImageUrl,
                  ),
                ),
              ),
            ],
          )
        ],
      ).allPadding(20),
    );
  }
}
