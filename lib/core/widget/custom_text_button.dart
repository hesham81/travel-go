import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class CustomTextButton extends StatelessWidget {
  final Function() onPressed;
  final String text;
  final Color textColor;
  final double textSize;
  final FontWeight textWeight;

  const CustomTextButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.textColor = AppColors.strongBlueColor,
    this.textSize = 16 ,
    this.textWeight = FontWeight.w600,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {},
      style: TextButton.styleFrom(
        overlayColor: Colors.transparent,
      ),
      child: Text(
        text,
        style: TextStyle(
          color: textColor,
          fontWeight: textWeight,
          fontSize: textSize,
          fontFamily: 'Poppins',
        ),
      ),
    );
  }
}
