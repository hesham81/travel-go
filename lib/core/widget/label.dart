import 'package:flutter/material.dart';
import '/core/theme/app_colors.dart';

class Label extends StatelessWidget {
  final String text;

  final Color textColor;
  final double textSize;
  final FontWeight textWeight;

  const Label({
    super.key,
    required this.text,
     this.textColor = AppColors.blackColor,
     this.textSize = 20 ,
     this.textWeight = FontWeight.w600,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: textColor,
        fontWeight: textWeight,
        fontSize: textSize,
        fontFamily: 'Poppins',
      ),
    );
  }
}
