import 'package:flutter/material.dart';
import 'package:travel_go/core/theme/app_colors.dart';

class AppBarWidget extends StatelessWidget {
  final String title;

  const AppBarWidget({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).textTheme;
    return AppBar(
      leading: IconButton(
        onPressed: () => Navigator.pop(context),
        icon: Icon(
          Icons.arrow_back_ios,
        ),
      ),
      title: Text(
        title,
        style: theme.titleLarge!.copyWith(
          color: AppColors.whiteColor,
        ),
      ),
      centerTitle: true,
    );
  }
}
