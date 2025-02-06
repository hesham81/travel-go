import 'package:flutter/material.dart';
import '/core/extensions/extensions.dart';
import '/core/theme/app_colors.dart';
import '/models/trip.dart';

class TripCart extends StatelessWidget {
  final Trip model;

  const TripCart({
    super.key,
    required this.model,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      decoration: BoxDecoration(
        color: AppColors.alabasterWhiteColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  model.title,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: AppColors.blackColor,
                  ),
                ),
                0.02.height.hSpace,
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.flight_land,
                    ),
                    Text(
                      overflow: TextOverflow.ellipsis,
                      "${model.destination} Airport",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: AppColors.blackColor,
                      ),
                    ),
                  ],
                ),
                0.015.height.hSpace,
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.flight_takeoff_outlined,
                    ),
                    0.02.width.hSpace,
                    Text(
                      "${model.source} Airport",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: AppColors.blackColor,
                      ),
                    ),
                  ],
                ),
                0.02.height.hSpace,
                Text(
                  "${model.price} ${model.currency}",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: AppColors.blackColor,
                  ),
                ),
                10.hSpace,
                Text(
                  "${model.noOfDays} Days",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: AppColors.blackColor,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.network(
                    model.imageUrl,
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) {
                        return child;
                      }
                      return Center(
                        child: CircularProgressIndicator(
                          value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded /
                                  (loadingProgress.expectedTotalBytes ?? 1)
                              : null,
                        ),
                      );
                    },
                    errorBuilder: (context, error, stackTrace) {
                      return Center(
                        child: Icon(Icons.error, color: Colors.red, size: 50),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ).allPadding(10),
    );
  }
}
