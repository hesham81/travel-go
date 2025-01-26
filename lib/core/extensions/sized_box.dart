import 'package:flutter/widgets.dart';

extension gapSpace on num {
  Widget get hSpace => SizedBox(
        width: toDouble(),
      );

  Widget get vSpace => SizedBox(
        height: toDouble(),
      );
}
