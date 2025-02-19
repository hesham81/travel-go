import 'package:flutter/material.dart';
import '/core/extensions/extensions.dart';
import '/core/theme/app_colors.dart';

class AccomdationWidget extends StatelessWidget {
  final String textDescription;
  final Function() onTap;

  const AccomdationWidget({
    super.key,
    required this.textDescription,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 0.07.height,
        decoration: BoxDecoration(
          color: AppColors.greyColor,
          borderRadius: BorderRadius.circular(
            20,
          ),
        ),
        child: Row(
          children: [
            Text(
              textDescription,
              style: theme.textTheme.titleMedium,
            ),
            Spacer(),
            Icon(
              Icons.arrow_forward_ios,
            ),
          ],
        ).allPadding(15),
      ),
    );
  }
}
