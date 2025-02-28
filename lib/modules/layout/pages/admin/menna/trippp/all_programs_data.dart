import 'package:flutter/material.dart';
import 'package:travel_go/core/extensions/align.dart';
import 'package:travel_go/core/extensions/dimensions.dart';
import 'package:travel_go/core/extensions/extensions.dart';
import 'package:travel_go/core/theme/app_colors.dart';
import 'package:travel_go/core/widget/custom_elevated_button.dart';
import 'package:travel_go/core/widget/custom_text_form_field.dart';
import 'package:travel_go/core/widget/loading_image_network_widget.dart';
import 'package:travel_go/modules/layout/pages/admin/pages/programs/pages/add_program/pages/new_program.dart';
import 'package:travel_go/modules/layout/pages/admin/pages/trips/pages/trip_program.dart';

class AllProgramsData extends StatefulWidget {
  static const routeName = '/all-programs-data';

  const AllProgramsData({super.key});

  @override
  State<AllProgramsData> createState() => _AllProgramsDataState();
}

class _AllProgramsDataState extends State<AllProgramsData> {
  bool isEmpty = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Day Program',
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: AppColors.whiteColor,
              ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            LoadingImageNetworkWidget(
              imageUrl:
                  "https://i.pinimg.com/736x/46/4b/ca/464bca0a73f4213243a7293eeb70c639.jpg",
            ).center,
            0.1.height.hSpace,
            CustomElevatedButton(
              text: "Add Program",
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  TripProgram.routeName,
                  arguments: "Program 1 Day 1 ",
                );
              },
              borderRadius: 10,
            ),
          ],
        ).allPadding(10),
      ),
    );
  }
}
