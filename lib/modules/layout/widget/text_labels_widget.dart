import 'package:flutter/material.dart';
import 'package:travel_go/core/extensions/dimensions.dart';
import 'package:travel_go/core/extensions/extensions.dart';

import '../../../core/theme/app_colors.dart';

class TextLabelsWidget extends StatelessWidget {
  final String label;
  final String value;

  const TextLabelsWidget({
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
          style: theme.labelLarge,
        ),
        0.01.width.vSpace,
        Text(
          value,
          overflow: TextOverflow.ellipsis,
          style: theme.labelLarge!.copyWith(
            color: AppColors.newBlueColor,
          ),
        ),
      ],
    );
  }
}
