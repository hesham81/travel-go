import 'package:flutter/material.dart';
import 'package:travel_go/core/extensions/extensions.dart';
import 'package:travel_go/core/widget/custom_text_form_field.dart';

class ReserveWidgetUsers extends StatelessWidget {
  const ReserveWidgetUsers({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
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
          CustomTextFormField(
            hintText: "Name : ",
          ),
          0.01.height.hSpace,
          CustomTextFormField(
            hintText: "National ID : ",
          ),
        ],
      ),
    );
  }
}
