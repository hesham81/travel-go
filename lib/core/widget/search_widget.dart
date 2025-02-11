import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

typedef searchQuery = String? Function(String value);

class SearchWidget extends StatefulWidget {
  final TextEditingController controller;
  final searchQuery? search;

  final double borderRadius;

  const SearchWidget({
    super.key,
    required this.controller,
    this.search,
    this.borderRadius = 2,
  });

  @override
  State<SearchWidget> createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  var empty = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      onChanged: widget.search,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(widget.borderRadius),
          borderSide: BorderSide(
            color: AppColors.whiteColor,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(widget.borderRadius),
          borderSide: BorderSide(
            color: AppColors.whiteColor,
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(widget.borderRadius),
          borderSide: BorderSide(
            color: AppColors.whiteColor,
          ),
        ),
        fillColor: AppColors.whiteColor,
        filled: true,
        prefixIcon: IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.search,
          ),
        ),
        suffixIcon: (empty == false)
            ? IconButton(
                onPressed: () {
                  widget.controller.clear();
                  empty = true;
                  setState(() {});
                },
                icon: Icon(Icons.clear),
              )
            : null,
      ),
    );
  }
}
