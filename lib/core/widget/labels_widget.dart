import 'package:flutter/material.dart';
import 'package:travel_go/core/theme/app_colors.dart';

class LabelsWidget extends StatelessWidget {
  final String label;

  final String value;

  const LabelsWidget({
    super.key,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).textTheme;
    return Row(
      children: [
        Text(
          label,
          style: theme.labelLarge!.copyWith(
            color: AppColors.newBlueColor,
          ),
        ),
        Text(
          value,
          overflow: TextOverflow.ellipsis,
          style: theme.labelLarge!.copyWith(
            color: AppColors.blackColor,
          ),
        ),
      ],
    );
  }
}
