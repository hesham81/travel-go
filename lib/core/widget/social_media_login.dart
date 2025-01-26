import 'package:flutter/material.dart';
import '/core/constant/app_assets.dart';
import '/core/extensions/extensions.dart';
import '/core/theme/app_colors.dart';

class SocialMediaLogin extends StatelessWidget {
  final String text;
  final String imagePath;

  const SocialMediaLogin({
    super.key,
    required this.text,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: AppColors.blackColor,
          width: 0.7,
        ),
        color: AppColors.alabasterWhiteColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          0.07.width.vSpace,
          Image.asset(
            imagePath,
            height: 35,
            width: 35,
          ),
          0.03.width.vSpace,
          Text(
            text,
            style: TextStyle(
              fontSize: 22,
              color: AppColors.blackColor,
              fontWeight: FontWeight.w600,
              fontFamily: 'Poppins',
            ),
          ),
        ],
      ),
    );
  }
}
