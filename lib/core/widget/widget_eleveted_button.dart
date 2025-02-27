import 'package:flutter/material.dart';
import 'package:travel_go/core/theme/app_colors.dart';

class WidgetElevetedButton extends StatelessWidget {
  final Widget child;
  final Color btnColor;
  final Color textColor;
  final Color? borderColor;
  final double? borderWidth;
  final EdgeInsets? padding;
  final double textSize;
  final double borderRadius;
  final FontWeight textWeight;
  final Function()? onPressed;

  const WidgetElevetedButton({
    super.key,
    required this.child,
    this.btnColor = AppColors.newBlueColor,
    this.textColor = AppColors.whiteColor,
    this.borderColor,
    this.borderWidth,
    this.padding,
    this.textSize = 15,
    this.textWeight = FontWeight.w600,
    this.onPressed,
    this.borderRadius = 15 ,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(

        padding: padding ?? EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        backgroundColor: btnColor,
        shape: RoundedRectangleBorder(
          side: BorderSide(
            color: borderColor ?? Colors.transparent,
            width: borderWidth ?? 0,
          ),
          borderRadius: BorderRadius.circular(
            borderRadius,
          ),
        ),
      ),
      child: child,
    );
  }
}
