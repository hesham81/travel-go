import 'package:flutter/material.dart';
import 'package:travel_go/core/services/bot_toast.dart';
import '../../../../../../core/widget/custom_container.dart';
import '/core/widget/loading_image_network_widget.dart';
import '/models/flight.dart';
import '/core/extensions/extensions.dart';
import '/core/theme/app_colors.dart';
import '/modules/layout/pages/admin/task/flight/Updateflight.dart';

class FlightCard extends StatelessWidget {
  final String destination;
  final String date;
  final String time;
  final String price;
  final String flightClass;
  final Flight flight;

  // final Flight flight;

  const FlightCard({
    required this.flight,
    super.key,
    required this.destination,
    required this.date,
    required this.time,
    required this.price,
    required this.flightClass,
    // required this.flight,
  });

  void _showDeleteConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            "Confirm Deletion",
            style: TextStyle(color: AppColors.newBlueColor),
          ),
          content: Text(
            "Are you sure you want to delete ?",
            style: TextStyle(color: AppColors.blackColor),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close dialog
              },
              child: Text(
                "Cancel",
                style: TextStyle(color: AppColors.newBlueColor),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                BotToastServices.showSuccessMessage(
                  "Item Deleted Successfully",
                );
              },
              child: Text("Delete", style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).textTheme;
    return CustomContainer(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                LoadingImageNetworkWidget(
                  imageUrl: flight.airline!.flightAirLineImageUrl,
                  width: 80,
                ),
                const SizedBox(width: 8),
                0.01.width.vSpace,
                Text(
                  flight.airline!.flighAirLineName,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.newBlueColor,
                  ),
                ),
                const Spacer(),
                Text(
                  "Economy",
                  style: const TextStyle(
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            0.01.height.hSpace,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => UpdateFlight(),
                      ),
                    );
                  },
                  icon: const Icon(
                    Icons.edit,
                  ),
                ),
                IconButton(
                  onPressed: () => _showDeleteConfirmationDialog(context),
                  icon: const Icon(
                    Icons.delete,
                    color: Colors.red,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
