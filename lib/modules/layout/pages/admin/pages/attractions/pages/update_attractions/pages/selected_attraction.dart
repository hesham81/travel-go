import 'package:flutter/material.dart';
import '/core/extensions/extensions.dart';
import '/core/theme/app_colors.dart';
import '/core/widget/custom_elevated_button.dart';
import '/core/widget/custom_text_form_field.dart';
import '/models/attractions_model.dart';

class SelectedAttraction extends StatelessWidget {
  static const routeName = '/selected_attraction';

  const SelectedAttraction({super.key});

  @override
  Widget build(BuildContext context) {
    var model = ModalRoute.of(context)!.settings.arguments as AttractionsModel;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text(model.title),
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
              hintText: model.location,
              isReadOnly: true,
            ).hPadding(0.03.width),
            0.01.height.hSpace,
            CustomTextFormField(
              hintText: model.videoUrl ?? "No Video Url Founded",
              minLine: 3,
            ).hPadding(0.03.width),
            0.01.height.hSpace,
            CustomTextFormField(
              hintText: model.description,
              minLine: 3,
            ).hPadding(0.03.width),
            0.01.height.hSpace,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: CustomElevatedButton(
                    text: "OK",
                    onPressed: () {},
                    borderRadius: 10,
                  ),
                ),
                0.01.width.vSpace,
                Expanded(
                  child: CustomElevatedButton(
                    text: "Cancel",
                    btnColor: AppColors.errorColor,
                    onPressed: () {
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
