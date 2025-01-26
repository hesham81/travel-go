import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class BackLeadingWidget extends StatelessWidget {
  const BackLeadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        Navigator.pop(context);
      },
      icon: CircleAvatar(
        backgroundColor: AppColors.greyColor,
        child: const Center(
          child: Icon(
            Icons.arrow_back,
            color: Colors.black,
            size: 25,
          ),
        ),
      ),
    );
  }
}
