import 'package:flutter/material.dart';
import 'package:travel_go/core/extensions/extensions.dart';
import 'package:travel_go/core/widget/custom_elevated_button.dart';

class DeparturesFilter extends StatefulWidget {
  final Function() highSeatFilter;
  final Function() lowSeatFilter;

  const DeparturesFilter({
    super.key,
    required this.highSeatFilter,
    required this.lowSeatFilter,
  });

  @override
  State<DeparturesFilter> createState() => _DeparturesFilterState();
}

class _DeparturesFilterState extends State<DeparturesFilter> {
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).textTheme;
    return Container(
      width: double.maxFinite,
      height: 0.4.height,
      child: Expanded(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Filter",
              style: theme.titleMedium,
            ),
            0.01.height.hSpace,
            Divider(),
            0.01.height.hSpace,
            Text(
              "Available Seats",
              style: theme.titleMedium,
            ),
            Row(
              children: [
                CustomElevatedButton(
                  text: "High",
                  onPressed: widget.highSeatFilter,
                ),
                0.01.width.vSpace,
                CustomElevatedButton(
                  text: "Low",
                  onPressed: widget.lowSeatFilter,
                ),
              ],
            )
          ],
        ).allPadding(15),
      ),
    );
  }
}
