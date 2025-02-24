import 'package:flutter/material.dart';
import 'package:travel_go/core/widget/custom_elevated_button.dart';

class SelectedTrip extends StatelessWidget {
  static const routeName = "/selected-trip";
  const SelectedTrip({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          // CustomElevatedButton(text: "Reserve", onPressed: () => CreditCard,)
        ],
      ),
    );
  }
}
