import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../theme/app_colors.dart';

typedef Validator = String? Function(String? value);

class NumbersTextFormField extends StatefulWidget {
  final String hintText;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final bool isPassword;
  final Validator? validation;
  final TextEditingController? controller;
  final Color borderColor;
  final Function(String)? onComplete;

  final TextStyle? hintStyle;

  const NumbersTextFormField({
    super.key,
    required this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    this.isPassword = false,
    this.validation,
    this.controller,
    this.borderColor = AppColors.blackColor,
    this.hintStyle,
    this.onComplete,
  });

  @override
  State<NumbersTextFormField> createState() => _NumbersTextFormFieldState();
}

class _NumbersTextFormFieldState extends State<NumbersTextFormField> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      onSubmitted: widget.onComplete,
      keyboardType: TextInputType.numberWithOptions(
        decimal: true,
      ),
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.digitsOnly,
        FilteringTextInputFormatter.allow(
          RegExp(
            r'^\d*\.?\d*',
          ),
        ),
      ],
      controller: widget.controller,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(
            color: widget.borderColor,
            width: 1.05,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(
            color: widget.borderColor,
            width: 1.05,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(
            color: widget.borderColor,
            width: 1.05,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(
            color: AppColors.errorColor,
            width: 1.05,
          ),
        ),
        hintText: widget.hintText,
        hintStyle: widget.hintStyle,
      ),
    );
  }
}
