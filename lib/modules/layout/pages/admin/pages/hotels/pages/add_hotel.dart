import 'package:flutter/material.dart';

import '../../../../../../../core/theme/app_colors.dart';

class AddHotel extends StatelessWidget {
  static const routeName = '/add-hotel';

  const AddHotel({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Add Hotel",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppColors.blackColor,
          ),
        ),
      ),
    );
  }
}
