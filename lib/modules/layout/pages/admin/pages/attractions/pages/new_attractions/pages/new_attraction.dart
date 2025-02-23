import 'package:flutter/material.dart';
import '/core/constant/app_assets.dart';
import '/core/extensions/extensions.dart';
import '/core/widget/custom_elevated_button.dart';
import '/core/widget/custom_text_form_field.dart';

class NewAttraction extends StatefulWidget {
  const NewAttraction({super.key});

  @override
  State<NewAttraction> createState() => _NewAttractionState();
}

class _NewAttractionState extends State<NewAttraction> {
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        0.01.height.hSpace,
        ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Image.asset(
            AppAssets.uploadImage,
          ),
        ),
        0.01.height.hSpace,
        CustomTextFormField(
          hintText: "Name ",
        ),
        0.01.height.hSpace,
        CustomTextFormField(
          hintText: "Location ",
        ),
        0.01.height.hSpace,
        CustomTextFormField(
          hintText: "Description ",
        ),
        0.01.height.hSpace,
        CustomElevatedButton(
          text: "Submit",
          onPressed: () {},
        ),
      ],
    ).hPadding(0.03.width);
  }
}
