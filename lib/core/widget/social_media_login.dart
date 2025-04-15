import 'package:flutter/material.dart';
import '/core/constant/app_assets.dart';
import '/core/extensions/extensions.dart';
import '/core/theme/app_colors.dart';

class SocialMediaLogin extends StatelessWidget {
  final String text;
  final String imagePath;
  final Function()? onTap;

  const SocialMediaLogin({
    super.key,
    required this.text,
    required this.imagePath,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.maxFinite,
        padding: EdgeInsets.symmetric(
          vertical: 0.01.height,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(1),
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              0.09.width.vSpace,
              Image.asset(
                imagePath,
                height: 35,
                width: 35,
              ),
              0.03.width.vSpace,
              Expanded(
                child: Text(
                  text,
                  style: TextStyle(
                    fontSize: 22,
                    color: AppColors.blackColor,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Poppins',
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
