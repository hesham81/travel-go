import 'package:flutter/material.dart';

import 'app_colors.dart';

abstract class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    primaryColor: AppColors.primaryColor,
    scaffoldBackgroundColor: AppColors.primaryColor,
    textTheme: TextTheme(
      bodyMedium: TextStyle(
        color: AppColors.whiteColor,
      ),
    ),
  );
}
