import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:travel_go/core/extensions/dimensions.dart';
import 'package:travel_go/core/extensions/extensions.dart';

import '../../../../../../../../../core/theme/app_colors.dart';
import '../../../../../../../../../core/widget/custom_elevated_button.dart';
import '../../../../../../../../../core/widget/custom_text_form_field.dart';
import '../../../../../../../../../models/attractions_model.dart';

class DeleteSelectedAttraction extends StatelessWidget {
  static const routeName = '/delete_selected_attraction';

  const DeleteSelectedAttraction({super.key});

  @override
  Widget build(BuildContext context) {
    var model = ModalRoute.of(context)!.settings.arguments as AttractionsModel;
    return Scaffold(
      appBar: AppBar(
        title: Text(model.location),
      ),
      body: Column(
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
          CustomTextFormField(
            hintText: model.id,
            isReadOnly: true,
          ).hPadding(0.03.width),
          0.01.height.hSpace,
          CustomTextFormField(
            hintText: model.description,
            isReadOnly: true,
          ).hPadding(0.03.width),
          0.01.height.hSpace,
          CustomElevatedButton(
            text: "Delete",
            btnColor: AppColors.errorColor,
            borderRadius: 10,
            onPressed: () {
              Navigator.pop(context);
              EasyLoading.showSuccess("Deleted Successfully");
            },
          ).hPadding(0.03.width),
        ],
      ),
    );
  }
}
