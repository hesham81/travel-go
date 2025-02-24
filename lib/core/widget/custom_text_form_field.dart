import 'package:flutter/material.dart';
import '/core/theme/app_colors.dart';

typedef Validator = String? Function(String? value);

class CustomTextFormField extends StatefulWidget {
  final String hintText;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final bool isPassword;
  final Validator? validation;
  final TextEditingController? controller;
  final Color borderColor;
  final isReadOnly;
  final Validator? onChanged;

  final TextStyle? hintStyle;

  const CustomTextFormField({
    super.key,
    required this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    this.isPassword = false,
    this.validation,
    this.controller,
    this.borderColor = AppColors.blackColor,
    this.hintStyle,
    this.isReadOnly = false,
    this.onChanged,
  });

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  bool visible = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: widget.onChanged,
      readOnly: widget.isReadOnly,
      validator: widget.validation,
      controller: widget.controller,
      obscureText: widget.isPassword ? visible : false,
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
        suffixIcon: (widget.isPassword == true)
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
                ? GestureDetector(
                    child: Icon(
                      widget.suffixIcon,
                    ),
                  )
                : null,
      ),
    );
  }
}
