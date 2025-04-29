import 'package:flutter/material.dart';
import 'package:travel_go/core/extensions/extensions.dart';
import 'package:travel_go/core/widget/custom_container.dart';

class FlightSearchContainer extends StatelessWidget {
  const FlightSearchContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      child: Column(
        children: [
          Row(
            children: [
              Text(
                "Recommended For You",
              ),
            ],
          )
        ],
      ).allPadding(10),
    );
  }
}
