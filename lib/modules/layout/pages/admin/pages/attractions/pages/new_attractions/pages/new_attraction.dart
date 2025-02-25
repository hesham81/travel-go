import 'package:country_state_city_picker/country_state_city_picker.dart';
import 'package:flutter/material.dart';
import 'package:phone_form_field/phone_form_field.dart';
import '../../../../../../../../../core/theme/app_colors.dart';
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
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController videoUrlController = TextEditingController();
  String countryValue = "";
  String stateValue = "";
  String cityValue = "";
  String location = "";

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "New Attraction",
          style: theme.textTheme.titleLarge!.copyWith(
            color: AppColors.whiteColor,
          ),
        ),
      ),
      body: Column(
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
            hintText: "Title",
            controller: titleController,
          ),
          0.01.height.hSpace,
          CustomTextFormField(
            hintText: "Description",
            minLine: 2,
          ),
          0.01.height.hSpace,
          CustomTextFormField(
            hintText: "Video Url",
            controller: videoUrlController,
          ),
          0.01.height.hSpace,
          SelectState(
            onCountryChanged: (value) {
              setState(() {
                countryValue = value;
              });
            },
            onStateChanged: (value) {
              setState(() {
                stateValue = value;
              });
            },
            onCityChanged: (value) {
              setState(() {
                cityValue = value;
              });
            },
          ),
          0.01.height.hSpace,
          CustomElevatedButton(
            text: "Submit",
            onPressed: () {},
          ),
        ],
      ).hPadding(0.03.width),
    );
  }
}
