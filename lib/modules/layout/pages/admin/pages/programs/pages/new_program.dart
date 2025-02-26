import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import '/core/services/bot_toast.dart';
import '/core/utils/attractions_db.dart';
import '/core/utils/programs_collections.dart';
import '/core/widget/custom_elevated_button.dart';
import '/models/attractions_model.dart';
import '/modules/layout/pages/admin/menna/trippp/model/programs.dart';
import '/modules/layout/pages/admin/pages/attractions/pages/new_attractions/pages/new_attraction.dart';
import '/core/constant/app_assets.dart';
import '/core/extensions/extensions.dart';
import '/core/theme/app_colors.dart';
import '/core/widget/custom_text_form_field.dart';
import '/core/widget/numbers_text_form_field.dart';

class NewProgram extends StatefulWidget {
  static const routeName = '/new-program';

  const NewProgram({super.key});

  @override
  State<NewProgram> createState() => _NewProgramState();
}

class _NewProgramState extends State<NewProgram> {
  List<AttractionsModel> attractions = [];
  var formKey = GlobalKey<FormState>();
  var titleController = TextEditingController();
  var descriptionController = TextEditingController();
  var noOfDaysController = TextEditingController();
  var selectedAttraction = TextEditingController();
  late AttractionsModel attraction;

  @override
  void initState() {
    super.initState();
    AttractionsDB.getAttractionsList().then(
      (value) {
        attractions = value;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).textTheme;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text(
          "Add Program",
          style: theme.titleLarge!.copyWith(
            color: AppColors.whiteColor,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            0.01.height.hSpace,
            Form(
              key: formKey,
              child: Column(
                children: [
                  CustomTextFormField(
                    hintText: "Program Title",
                    controller: titleController,
                    validation: (value) =>
                        titleController.text.isEmpty ? "Enter title" : null,
                  ),
                  0.01.height.hSpace,
                  CustomTextFormField(
                    hintText: "Program Description",
                    controller: descriptionController,
                    validation: (value) => descriptionController.text.isEmpty
                        ? "Enter Description"
                        : null,
                    minLine: 3,
                  ),
                  0.01.height.hSpace,
                  NumbersTextFormField(
                    hintText: "Day Number ",
                    validation: (value) => noOfDaysController.text.isEmpty
                        ? "Enter Number Of Days"
                        : null,
                  ),
                  0.01.height.hSpace,
                  Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: DropdownMenu(
                          width: double.maxFinite,
                          hintText: "Attraction",
                          controller: selectedAttraction,
                          dropdownMenuEntries: [
                            for (var attraction in attractions)
                              DropdownMenuEntry(
                                value: attraction,
                                label: attraction.title,
                              ),
                          ],
                        ),
                      ),
                      0.01.width.vSpace,
                      Expanded(
                        flex: 1,
                        child: CustomElevatedButton(
                          text: "Add",
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => NewAttraction(),
                              ),
                            );
                          },
                          textSize: 18,
                          padding: EdgeInsets.symmetric(vertical: 15),
                          borderRadius: 10,
                        ),
                      ),
                    ],
                  ),
                  0.02.height.hSpace,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      CustomElevatedButton(
                        text: "OK",
                        borderRadius: 10,
                        onPressed: () async {
                          if (formKey.currentState!.validate() &&
                              selectedAttraction.text.isNotEmpty) {
                            EasyLoading.show();
                            for (var element in attractions) {
                              if (element.title == selectedAttraction.text) {
                                attraction = element;
                                break;
                              }
                            }
                            Program program = Program(
                              programTitle: titleController.text,
                              programDetails: descriptionController.text,
                              attraction: attraction,
                              dayNumber:
                                  int.tryParse(noOfDaysController.text) ?? 1,
                            );
                            await ProgramsCollections.addProgram(program)
                                .then((value) {
                              if (value) {
                                EasyLoading.dismiss();
                                BotToastServices.showSuccessMessage(
                                  "Program Added Successfully",
                                );
                                Navigator.pop(context);
                              } else {
                                EasyLoading.dismiss();
                                BotToastServices.showErrorMessage(
                                  "Check Your Data",
                                );
                              }
                            });
                          } else {
                            EasyLoading.dismiss();
                            BotToastServices.showErrorMessage(
                              "Check Your Data",
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ],
              ).hPadding(0.03.width),
            ),
          ],
        ),
      ),
    );
  }
}
