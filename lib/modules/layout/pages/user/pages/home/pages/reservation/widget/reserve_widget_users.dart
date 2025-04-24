import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';
import '/core/extensions/extensions.dart';
import '/core/theme/app_colors.dart';
import '/core/widget/custom_text_form_field.dart';
import '/core/widget/numbers_text_form_field.dart';

class ReserveWidgetUsers extends StatefulWidget {
  const ReserveWidgetUsers({super.key});

  @override
  State<ReserveWidgetUsers> createState() => _ReserveWidgetUsersState();
}

class _ReserveWidgetUsersState extends State<ReserveWidgetUsers> {
  List<String> relations = [
    "Friends",
    "Family",
    "Others",
  ];

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
          NumbersTextFormField(
            hintText: "Age : ",
          ),
          0.01.height.hSpace,
          CustomDropdown(
            hintText: "RelationShip",
            items: relations,
            headerBuilder: (context, selectedItem, enabled) => Text(
              selectedItem,
              style: Theme.of(context).textTheme.labelLarge!.copyWith(
                    color: AppColors.blackColor,
                  ),
            ),
            listItemBuilder: (context, item, isSelected, onItemSelect) => Text(
              item,
              style: Theme.of(context).textTheme.labelLarge!.copyWith(
                    color: AppColors.blackColor,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            onChanged: (p0) {},
          )
        ],
      ),
    );
  }
}
