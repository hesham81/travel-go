import 'dart:io';

import 'package:country_state_city_picker/country_state_city_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';
import 'package:travel_go/core/services/bot_toast.dart';
import 'package:travel_go/core/services/storage.dart';
import 'package:travel_go/core/utils/attractions_db.dart';
import 'package:travel_go/core/validations/validations.dart';
import 'package:travel_go/models/attractions_model.dart';
import '/core/theme/app_colors.dart';
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
  String imageUrl = "";

  File? _image;

  pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? selectedImage =
        await picker.pickImage(source: ImageSource.gallery);

    if (selectedImage != null) {
      _image = File(selectedImage.path);
    }
    setState(() {});
  }

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController videoUrlController = TextEditingController();
  String countryValue = "";
  String stateValue = "";
  String cityValue = "";
  String location = "";
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text(
          "New Attraction",
          style: theme.textTheme.titleLarge!.copyWith(
            color: AppColors.whiteColor,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              0.01.height.hSpace,
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: GestureDetector(
                  onTap: () {
                    pickImage();
                  },
                  child: _image == null
                      ? Image.asset(
                          AppAssets.uploadImage,
                        )
                      : Image.file(_image!),
                ),
              ),
              0.01.height.hSpace,
              CustomTextFormField(
                hintText: "Title",
                controller: titleController,
                validation: (value) {
                  return titleController.text.isEmpty
                      ? "Title Can't De Empty"
                      : null;
                },
              ),
              0.01.height.hSpace,
              CustomTextFormField(
                hintText: "Description",
                minLine: 2,
                controller: descriptionController,
                validation: (value) {
                  return descriptionController.text.isEmpty
                      ? "Description Can't De Empty"
                      : null;
                },
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
                onPressed: () async {
                  if (_image == null) {
                    EasyLoading.showError("Upload Image");
                    return;
                  }
                  if (formKey.currentState!.validate()) {
                    Storage.uploadPublicAttraction(
                      attractionName: "attractionName",
                      image: _image!,
                      fileName: titleController.text.isEmpty
                          ? "attraction"
                          : titleController.text,
                    );
                    imageUrl = Storage.getPublicUrlAttractionImage(
                          titleController.text,
                        ) ??
                        "";
                    location = "$countryValue,$cityValue";
                    AttractionsModel model = AttractionsModel(
                      title: titleController.text,
                      location: location,
                      description: descriptionController.text,
                      imageUrl: imageUrl,
                      videoUrl: videoUrlController.text.isEmpty
                          ? null
                          : videoUrlController.text,
                    );
                    EasyLoading.show();
                    await AttractionsDB.addAttractionsData(model).then(
                      (value) {
                        return value
                            ? BotToastServices.showSuccessMessage(
                                "Attraction Uploaded Successfully",
                              )
                            : BotToastServices.showErrorMessage(
                                "Failed While Upload Attraction",
                              );
                      },
                    );
                    Navigator.pop(context);
                    EasyLoading.dismiss();
                  }
                },
              ),
            ],
          ).hPadding(0.03.width),
        ),
      ),
    );
  }
}
