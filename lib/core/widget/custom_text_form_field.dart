import 'package:flutter/material.dart';
import '/core/theme/app_colors.dart';

typedef Validator = String? Function(String? value);

class CustomTextFormField extends StatefulWidget {
  final String hintText;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final bool? isPassword;
  final Validator? validation;
  final TextEditingController? controller;
  final Color borderColor;

  final TextStyle? hintStyle;

  const CustomTextFormField({
    super.key,
    required this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    this.isPassword,
    this.validation,
    this.controller,
    this.borderColor = AppColors.blackColor,
    this.hintStyle,
  });

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  bool visible = false;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: widget.validation,
      obscureText: visible,
      obscuringCharacter: "*",
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
        suffixIcon: (widget.isPassword != null)
            ? (visible)
                ? IconButton(
                    onPressed: () {
                      setState(() {
                        visible = !visible;
                      });
                    },
                    icon: const Icon(
                      Icons.visibility_off_outlined,
                    ),
                  )
                : IconButton(
                    onPressed: () {
                      setState(() {
                        visible = !visible;
                      });
                    },
                    icon: const Icon(
                      Icons.visibility_outlined,
                    ),
                  )
            : (widget.suffixIcon) != null
                ? Icon(widget.suffixIcon)
                : null,
      ),
    );
  }
}
