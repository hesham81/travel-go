import 'package:flutter/material.dart';
import '/core/extensions/extensions.dart';
import '/core/theme/app_colors.dart';
import '/modules/layout/pages/admin/pages/attractions/widget/attraction_widget.dart';

class EditAttractions extends StatelessWidget {
  const EditAttractions({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
        },
        backgroundColor: AppColors.primaryColor.withOpacity(0.8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(
          Icons.add,
          color: AppColors.blackColor,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListView.separated(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) => AttractionWidget(),
              separatorBuilder:  (context, index) => 0.01.height.hSpace,
              itemCount: 8,
            ),
          ],
        ).hPadding(0.03.width),
      ),
    );
  }
}
