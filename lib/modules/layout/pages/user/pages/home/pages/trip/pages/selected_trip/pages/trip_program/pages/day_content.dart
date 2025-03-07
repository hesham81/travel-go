import 'package:flutter/material.dart';
import 'package:travel_go/core/extensions/extensions.dart';
import 'package:travel_go/core/theme/app_colors.dart';
import 'package:travel_go/models/program_model.dart';

class DayContent extends StatelessWidget {
  final ProgramModel model;

  const DayContent({
    super.key,
    required this.model,
  });

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).textTheme;
    return Container(
      height: 0.1.height,
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            model.from.format(context),
            style: theme.titleMedium,
          ),
          0.02.width.vSpace,

          Expanded(
            child: Text(
              model.programDetails,
              overflow: TextOverflow.ellipsis,
              style: theme.titleMedium,
            ),
          ),
          0.01.width.vSpace,
          Icon(
            Icons.arrow_forward_ios,
          ),
        ],
      ),
    );
  }
}
