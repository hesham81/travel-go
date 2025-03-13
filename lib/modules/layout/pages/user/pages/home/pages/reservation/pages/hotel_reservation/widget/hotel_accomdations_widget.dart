import 'package:flutter/material.dart';
import '/core/extensions/extensions.dart';
import '/core/theme/app_colors.dart';

class HotelAccomdationsWidget extends StatelessWidget {
  final IconData icon;

  final String title;

  const HotelAccomdationsWidget({
    super.key,
    required this.icon,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:  EdgeInsets.symmetric(
        horizontal: title.length > 8 ? 3 : 18.0,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.4),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          0.01.height.hSpace,
          Icon(
            icon,
            color: AppColors.newBlueColor,
          ),
          0.01.height.hSpace,
          Text(
            title,
            style: Theme.of(context).textTheme.titleSmall!.copyWith(
                  color: AppColors.blackColor,
                  fontSize: 13,
                ),
          ),
          0.01.height.hSpace,
        ],
      ),
    );
  }
}
