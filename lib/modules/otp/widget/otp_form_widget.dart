import 'package:flutter/material.dart';
import 'package:travel_go/core/theme/app_colors.dart';

typedef Validator = String? Function(String? value);
class OtpFormWidget extends StatelessWidget {
  final TextEditingController controller;
  final Validator? validator;
  const OtpFormWidget({
    super.key,
    required this.controller,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 50,
      child: TextFormField(
        validator: validator,
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        maxLength: 1,
        controller: controller,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        decoration: InputDecoration(
          counterText: "",
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(
              color: AppColors.newBlueColor,
              width: 1,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(
              color: AppColors.errorColor,
              width: 1,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(
              color: AppColors.newBlueColor,
              width: 1,
            ),
          ),
          focusedErrorBorder:OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(
              color: AppColors.errorColor,
              width: 1,
            ),
          ) ,
          fillColor: Colors.transparent,
          filled: true,
          errorMaxLines: 1,

        ),
      ),
    );
    ;
  }
}
