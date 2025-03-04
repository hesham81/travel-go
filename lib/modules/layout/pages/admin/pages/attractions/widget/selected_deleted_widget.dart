import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:latlong2/latlong.dart';
import '/core/services/bot_toast.dart';
import '/modules/layout/pages/admin/pages/attractions/pages/update_attractions/widget/set_map_location.dart';
import '/core/utils/attractions_db.dart';
import '/core/extensions/extensions.dart';
import '/core/theme/app_colors.dart';
import '/core/widget/custom_elevated_button.dart';
import '/core/widget/custom_text_form_field.dart';
import '/models/attractions_model.dart';

class SelectedDeletedWidget extends StatefulWidget {
  static const routeName = '/selected_deleted_attraction';

  const SelectedDeletedWidget({super.key});

  @override
  State<SelectedDeletedWidget> createState() => _SelectedDeletedWidgetState();
}

class _SelectedDeletedWidgetState extends State<SelectedDeletedWidget> {
  TextEditingController titleController = TextEditingController();
  TextEditingController videoUrlController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  bool isChanged = false;

  _uploadChanges(BuildContext context, AttractionsModel model) async {
    EasyLoading.show();
    AttractionsModel newModel = AttractionsModel(
      category: model.category,
      id: model.id,
      title: titleController.text.isEmpty ? model.title : titleController.text,
      location: model.location,
      description: (descriptionController.text.isEmpty)
          ? model.description
          : descriptionController.text,
      imageUrl: model.imageUrl,
      videoUrl: (videoUrlController.text.isEmpty)
          ? model.videoUrl
          : videoUrlController.text,
    );
    await AttractionsDB.editAttraction(
      model,
      newModel,
    ).then(
      (value) {
        EasyLoading.dismiss();
        (value)
            ? EasyLoading.showSuccess("Attraction Updated Successfully")
            : EasyLoading.showError("Attraction Updated Failed");
      },
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    var model = ModalRoute.of(context)!.settings.arguments as AttractionsModel;
    var theme = Theme.of(context);
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text(
          model.title,
          style: theme.textTheme.titleLarge!.copyWith(
            color: AppColors.whiteColor,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.network(
              model.imageUrl,
            ),
            0.01.height.hSpace,
            CustomTextFormField(
              hintText: model.id,
              isReadOnly: true,
            ).hPadding(0.03.width),
            0.01.height.hSpace,
            CustomTextFormField(
              hintText: model.title,
              controller: titleController,
              isReadOnly: true,
              onComplete: (value) {
                isChanged = true;

                return null;
              },
            ).hPadding(0.03.width),
            0.01.height.hSpace,
            CustomTextFormField(
              hintText: model.description,
              controller: descriptionController,
              minLine: 5,
              isReadOnly: true,
              onComplete: (value) {
                isChanged = true;
                return null;
              },
            ).hPadding(0.03.width)
            ,
            0.01.height.hSpace,
            CustomTextFormField(
              hintText: model.videoUrl ?? "No Video Url Founded",
              controller: videoUrlController,
              isReadOnly: true,
              onComplete: (value) {
                isChanged = true;
                return null;
              },
            ).hPadding(0.03.width),
            0.01.height.hSpace,
            CustomTextFormField(
              hintText: model.location,
              isReadOnly: true,
            ).hPadding(0.03.width),
            0.01.height.hSpace,
            SizedBox(
              height: 0.4.height,
              child: SetMapLocation(
                locations: LatLng(model.lat ?? 0, model.long ?? 0),
              ),
            ).hPadding(0.03.width),
            0.01.height.hSpace,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: CustomElevatedButton(
                    text: "Delete",
                    btnColor: AppColors.errorColor,
                    onPressed: () {
                      AttractionsDB.deleteAttraction(model);
                      BotToastServices.showSuccessMessage(
                          "Attraction Deleted Successfully");
                      Navigator.pop(context);
                    },
                    borderRadius: 10,
                  ),
                ),
              ],
            ).hPadding(0.03.width),
          ],
        ),
      ),
    );
  }
}
