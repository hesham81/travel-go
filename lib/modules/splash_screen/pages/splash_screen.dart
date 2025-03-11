import 'dart:async';
import 'package:animate_do/animate_do.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:route_transitions/route_transitions.dart';
import '/core/constant/local_storage.dart';
import '/core/constant/shared_preferences_keys.dart';
import '/modules/layout/pages/admin/task/adminscreen.dart';
import '/modules/layout/pages/manager/pages/manager_home/manager_home_screen.dart';
import '/core/utils/firebase_auth_services.dart';
import '/modules/layout/pages/user/pages/home/pages/home.dart';
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
    Timer(Duration(seconds: 4), () {
      User? user = FirebaseAuthServices.getCurrentUserData();
      (user?.uid == null)
          ? Navigator.pushReplacementNamed(
              context,
              RouteNames.signIn,
            )
          : (LocalStorageData.getString(SharedPreferencesKey.login) == "user")
              ? Navigator.pushReplacementNamed(context, Home.routeName)
              : (LocalStorageData.getString(SharedPreferencesKey.login) ==
                      "admin")
                  ? slideLeftWidget(newPage: AdminHome(), context: context)
                  : slideLeftWidget(
                      newPage: ManagerHomeScreen(), context: context);
    });
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
