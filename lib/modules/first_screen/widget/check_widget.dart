import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';

class CheckWidget extends StatefulWidget {
  const CheckWidget({super.key});

  @override
  State<CheckWidget> createState() => _CheckWidgetState();
}

class _CheckWidgetState extends State<CheckWidget> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          value: isChecked,
          side: BorderSide(color: AppColors.azureBlueColor),
          fillColor: WidgetStateProperty.resolveWith<Color>(
            (states) {
              if (states.contains(WidgetState.selected)) {
                return AppColors.skyBlueColor; // Fill color when checked
              }
              return AppColors.whiteColor; // Fill color when unchecked
            },
          ),
          onChanged: (bool? newValue) {
            setState(
              () {
                isChecked = newValue ?? false;
              },
            );
          },
        ),
        const Expanded(
          child: Text(
            'I agree to the terms and conditions',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: AppColors.blackColor,
            ),
          ),
        ),
      ],
    );
  }
}
