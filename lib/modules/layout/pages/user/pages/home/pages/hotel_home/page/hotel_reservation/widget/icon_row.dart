import 'package:flutter/material.dart';
import 'package:travel_go/core/extensions/dimensions.dart';
import 'package:travel_go/core/extensions/extensions.dart';

class IconRow extends StatelessWidget {
  final Icon icon;
  final Text text;

  const IconRow({
    super.key,
    required this.icon,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        icon,
        0.01.height.vSpace,
        text,
      ],
    );
  }
}
