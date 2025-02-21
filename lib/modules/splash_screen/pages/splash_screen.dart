import 'dart:async';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import '/core/extensions/align.dart';
import '/core/routes/route_names.dart';
import '/core/theme/app_colors.dart';

class SplashScreen extends StatefulWidget {
  static const String routeName = "/splash";

  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
      Duration(seconds: 4),
      () => Navigator.pushReplacementNamed(
        context,
        RouteNames.signIn,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FadeInLeftBig(
            duration: Duration(seconds: 3),
            child: Image.asset(
              "assets/images/logo2.jpg",
            ).center,
          ),
        ],
      ),
    );
  }
}
