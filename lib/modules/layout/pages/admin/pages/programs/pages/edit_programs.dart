import 'package:flutter/material.dart';
import 'package:travel_go/core/extensions/extensions.dart';
import 'package:travel_go/core/widget/search_widget.dart';

import '../../../../../../../core/theme/app_colors.dart';

class EditPrograms extends StatefulWidget {
  const EditPrograms({super.key});

  @override
  State<EditPrograms> createState() => _EditProgramsState();
}

class _EditProgramsState extends State<EditPrograms> {
  TextEditingController searchController = TextEditingController();
  var programs = [] ;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: AppColors.primaryColor.withOpacity(0.8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(
          Icons.add,
          color: AppColors.blackColor,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SearchWidget(
              controller: searchController,
              borderRadius: 10,
            ),
          ],
        ),
      ).allPadding(10),
    );
  }
}
