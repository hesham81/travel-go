import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:travel_go/core/extensions/align.dart';

class FlightHome extends StatelessWidget {
  const FlightHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset("assets/icons/no_favourite.json").center,
        ],
      ),
    );
  }
}
