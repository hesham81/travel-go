import 'package:flutter/material.dart';
import 'package:travel_go/core/widget/dividers_word.dart';
import '/core/extensions/align.dart';
import '/core/widget/custom_elevated_button.dart';
import '/core/widget/custom_text_form_field.dart';
import '/core/widget/loading_image_network_widget.dart';
import '/modules/layout/pages/admin/pages/attractions/pages/update_attractions/pages/selected_attraction.dart';
import '/core/extensions/extensions.dart';
import '/core/theme/app_colors.dart';
import '/modules/layout/pages/admin/menna/trippp/model/programs.dart';

class EditProgram extends StatefulWidget {
  static const routeName = '/edit_program';

  const EditProgram({super.key});

  @override
  State<EditProgram> createState() => _EditProgramState();
}

class _EditProgramState extends State<EditProgram> {
  var formKey = GlobalKey<FormState>();
  TextEditingController programTitleController = TextEditingController();
  TextEditingController programDetailsController = TextEditingController();
  bool isUpdated = false;

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
            Form(
              key: formKey,
              child: Column(
                children: [
                  CustomTextFormField(
                    hintText: model.programDetails,
                    controller: programDetailsController,
                    minLine: 2,
                    onComplete: (value) {
                      isUpdated = true;
                      setState(() {});
                    },
                  ),
                  0.01.height.hSpace,
                  CustomTextFormField(
                    hintText: model.programTitle,
                    controller: programTitleController,
                    onComplete: (value) {
                      isUpdated = true;
                      setState(() {});
                    },
                  ),
                  0.01.height.hSpace,
                  Row(
                    children: [
                      Expanded(
                        child: CustomElevatedButton(
                          text: "OK",
                          btnColor: AppColors.newBlueColor,
                          borderRadius: 10,
                          onPressed: isUpdated ?  () {} : null,
                        ),
                      ),
                      0.01.width.vSpace,
                      Expanded(
                        child: CustomElevatedButton(
                          text: "Cancel",
                          btnColor: AppColors.errorColor,
                          borderRadius: 10,
                          onPressed: () {},
                        ),
                      ),
                    ],
                  ),
                  0.02.height.hSpace,
                  DividersWord(text: "Attraction Data" , ),
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
                        text: "Edit Attraction",
                        onPressed: () {
                          Navigator.pushNamed(
                            context,
                            SelectedAttraction.routeName,
                            arguments: model.attraction,
                          );
                        },
                      ),
                    ],
                  ),
                  0.02.height.hSpace,
                ],
              ).hPadding(0.03.width),
            ),
          ],
        ),
      ),
    );
  }
}
