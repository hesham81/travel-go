import 'package:flutter/material.dart';
import '/core/extensions/extensions.dart';
import '/models/program_model.dart';

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
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "${model.from.format(context)} - ${model.to.format(context)}",
            style: theme.titleMedium,
          ),
          0.02.width.vSpace,
          Expanded(
            child: Text(
              model.programTitle,
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
