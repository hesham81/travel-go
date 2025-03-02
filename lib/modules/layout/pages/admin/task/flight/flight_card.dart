import 'package:flutter/material.dart';
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

  // final Flight flight;

  const FlightCard({
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
          title: Text("Confirm Deletion"),
          content: Text("Are you sure you want to delete ?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close dialog
              },
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close dialog
                // Perform delete action here
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Item deleted")),
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
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Image.network(
                    "https://upload.wikimedia.org/wikipedia/commons/7/7d/Egypt_air_logo.jpg",
                    width: 40),
                const SizedBox(width: 8),
                0.01.width.vSpace,
                Text(
                  "EGYPTAIR",

                  // flight.airline?.flighAirLineName ?? "No Name",
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
