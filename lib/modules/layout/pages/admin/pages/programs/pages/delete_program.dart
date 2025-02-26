import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:travel_go/core/utils/programs_collections.dart';
import '/core/extensions/extensions.dart';
import '/core/widget/custom_elevated_button.dart';
import '/core/widget/dividers_word.dart';
import '/core/widget/loading_image_network_widget.dart';
import '/modules/layout/pages/admin/pages/attractions/pages/delete_attractions/pages/delete_selected_attraction.dart';
import '/core/theme/app_colors.dart';
import '/modules/layout/pages/admin/menna/trippp/model/programs.dart';

class DeleteProgram extends StatefulWidget {
  static const routeName = '/delete_program';

  const DeleteProgram({super.key});

  @override
  State<DeleteProgram> createState() => _DeleteProgramState();
}

class _DeleteProgramState extends State<DeleteProgram> {
  _deleteProgramData(BuildContext context, Program program) {
    EasyLoading.show();
    ProgramsCollections.deleteProgram(program).then(
      (value) {
        if (value) {
          EasyLoading.showSuccess("Deleted Successfully");
          EasyLoading.dismiss();
          Navigator.pop(context);
        } else {
          EasyLoading.showError("Something went wrong");
          EasyLoading.dismiss();
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var model = ModalRoute.of(context)!.settings.arguments as Program;
    var theme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          model.programTitle,
          style: theme.titleLarge!.copyWith(
            color: AppColors.whiteColor,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            LoadingImageNetworkWidget(
              imageUrl: model.attraction.imageUrl,
            ),
            0.01.height.hSpace,
            Column(
              children: [
                Row(
                  children: [
                    Text(
                      "Title ",
                      style: theme.titleMedium!.copyWith(
                        color: AppColors.newBlueColor,
                      ),
                    ),
                    0.018.width.vSpace,
                    Expanded(
                      child: Text(
                        model.programTitle,
                        style: theme.titleMedium!.copyWith(
                          color: AppColors.blackColor,
                        ),
                      ),
                    ),
                  ],
                ),
                0.018.height.hSpace,
                Row(
                  children: [
                    Text(
                      "Description ",
                      style: theme.titleMedium!.copyWith(
                        color: AppColors.newBlueColor,
                      ),
                    ),
                    0.018.width.vSpace,
                    Expanded(
                      child: Text(
                        model.programDetails,
                        style: theme.titleMedium!.copyWith(
                          color: AppColors.blackColor,
                        ),
                      ),
                    ),
                  ],
                ),
                0.018.height.hSpace,
                Row(
                  children: [
                    Text(
                      "Day No.",
                      style: theme.titleMedium!.copyWith(
                        color: AppColors.newBlueColor,
                      ),
                    ),
                    0.01.width.vSpace,
                    Expanded(
                      child: Text(
                        model.dayNumber.toString(),
                        style: theme.titleMedium!.copyWith(
                          color: AppColors.blackColor,
                        ),
                      ),
                    ),
                  ],
                ),
                0.01.height.hSpace,
                Row(
                  children: [
                    Expanded(
                      child: CustomElevatedButton(
                        text: "Delete",
                        btnColor: AppColors.errorColor,
                        onPressed: () {
                          _deleteProgramData(context, model);
                        },
                      ),
                    ),
                  ],
                ),
                0.01.height.hSpace,
                DividersWord(
                  text: "Attraction Data",
                ),
                0.02.height.hSpace,
                Row(
                  children: [
                    Text(
                      "Attraction Title : ",
                      style: theme.titleMedium!.copyWith(
                        color: AppColors.newBlueColor,
                      ),
                    ),
                    0.01.width.vSpace,
                    Text(
                      model.attraction.title,
                      style: theme.titleMedium!.copyWith(
                        color: AppColors.blackColor,
                      ),
                    ),
                  ],
                ),
                0.015.height.hSpace,
                Row(
                  children: [
                    Text(
                      "Attraction Location : ",
                      style: theme.titleMedium!.copyWith(
                        color: AppColors.newBlueColor,
                      ),
                    ),
                    0.01.width.vSpace,
                    Expanded(
                      child: Text(
                        model.attraction.location,
                        overflow: TextOverflow.visible,
                        style: theme.titleMedium!.copyWith(
                          color: AppColors.blackColor,
                        ),
                      ),
                    ),
                  ],
                ),
                0.015.height.hSpace,
                Row(
                  children: [
                    Text(
                      "Attraction Description : ",
                      style: theme.titleMedium!.copyWith(
                        color: AppColors.newBlueColor,
                      ),
                    ),
                    0.01.width.vSpace,
                    Expanded(
                      child: Text(
                        model.attraction.description,
                        overflow: TextOverflow.visible,
                        style: theme.titleMedium!.copyWith(
                          color: AppColors.blackColor,
                        ),
                      ),
                    ),
                  ],
                ),
                0.01.height.hSpace,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    CustomElevatedButton(
                      text: "Delete Attraction",
                      btnColor: AppColors.errorColor,
                      onPressed: () {
                        Navigator.pushNamed(
                          context,
                          DeleteSelectedAttraction.routeName,
                          arguments: model.attraction,
                        );
                      },
                    ),
                  ],
                ),
                0.02.height.hSpace,
              ],
            ).hPadding(0.03.width),
          ],
        ),
      ),
    );
  }
}
