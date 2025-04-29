import 'package:flutter/material.dart';
import 'package:travel_go/core/theme/app_colors.dart';
import 'package:travel_go/modules/layout/pages/user/pages/home/pages/flight_home/page/pages/bottomsheet.dart';

class BookingScreen extends StatefulWidget {
  const BookingScreen({super.key});

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  List<Map<String, String>> travelers = []; // Store multiple travelers

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF0D75B4),
        title: const Text(
          "Tour and Travel",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                "Trip to Abu Dhabi",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 20),

              // Baggage Policy
              _buildBox(
                title: "Baggage policy",
                children: [
                  _buildPolicyRow(Icons.shopping_bag, "Cabin bag 7kg"),
                  _buildPolicyRow(Icons.luggage, "Check-in bag 20Kgs"),
                ],
              ),
              const SizedBox(height: 15),

              // Cancellation Policy
              _buildBox(
                title: "Cancellation policy",
                children: [
                  _buildPolicyRow(Icons.toggle_on, "Free cancellation"),
                ],
              ),
              const SizedBox(height: 15),

              // Traveler Details Box
              _buildBox(
                title: "Traveller Details",
                children: [
                  Column(
                    children: travelers.isNotEmpty
                        ? travelers
                            .map(
                              (traveler) => Text(
                                "${traveler['firstName']} ${traveler['lastName']}",
                                style: TextStyle(color: AppColors.blackColor),
                              ),
                            )
                            .toList()
                        : [
                            const Text(
                              "0/1 Traveller",
                              style: TextStyle(color: AppColors.blackColor),
                            ),
                          ],
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () async {
                      final result = await showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        builder: (context) => const AddTravellerBottomSheet(),
                      );

                      if (result != null) {
                        setState(() {
                          travelers.add(Map<String, String>.from(
                              result)); // Append new traveler
                        });
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: const Color(0xFF0D75B4),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                        side: const BorderSide(color: Color(0xFF0D75B4)),
                      ),
                    ),
                    child: const Text(
                      "+ Add New Traveller",
                      style: TextStyle(color: AppColors.blackColor),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),

              // Email Field
              _buildBox(
                title: "Booking details will be sent to",
                children: [
                  TextField(
                    decoration: InputDecoration(
                      hintText: "Enter your email",
                      filled: true,
                      fillColor: Colors.grey[300],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Payment Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (travelers.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text(
                                "Please add at least one traveler before proceeding.")),
                      );
                      return;
                    }
                    // Proceed with payment
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF0D75B4),
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text("Payment",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBox({required String title, required List<Widget> children}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.blue),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 10),
          ...children,
        ],
      ),
    );
  }

  Widget _buildPolicyRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, color: const Color(0xFF0D75B4)),
        const SizedBox(width: 10),
        Text(
          text,
          style: TextStyle(
            color: AppColors.blackColor,
          ),
        ),
      ],
    );
  }
}
