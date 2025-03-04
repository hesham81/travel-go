import 'package:flutter/material.dart';
import '/core/extensions/extensions.dart';
import '/core/theme/app_colors.dart';

class ProgramDayWidget extends StatelessWidget {
  final int index;

  const ProgramDayWidget({
    super.key,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 0.1.height,
      width: double.maxFinite,
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.circular(
          10,
        ),
      ),
      // child: GestureDetector(
      //   onTap: () {
      //     Navigator.pushNamed(
      //       context,
      //       AllProgramsData.routeName,
      //       arguments: index,
      //     );
      //   },
      //   child: Row(
      //     children: [
      //       Text(
      //         'Day ${index + 1} Programs',
      //         style: Theme.of(context).textTheme.titleMedium!.copyWith(
      //               color: AppColors.blackColor,
      //             ),
      //       ).hPadding(
      //         0.03.width,
      //       ),
      //       Spacer(),
      //       Icon(
      //         Icons.arrow_forward_ios,
      //         color: AppColors.blackColor,
      //       ),
      //       0.02.width.vSpace,
      //     ],
      //   ),
      // ),
    );
  }
}
