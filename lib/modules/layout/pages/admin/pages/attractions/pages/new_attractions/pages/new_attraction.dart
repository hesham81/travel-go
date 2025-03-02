import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';
import 'package:travel_go/core/utils/id_generator.dart';
import 'package:travel_go/modules/layout/pages/admin/pages/attractions/widget/attraction_map.dart';
import '/core/services/bot_toast.dart';
import '/core/services/storage.dart';
import '/core/utils/attractions_db.dart';
import '/models/attractions_model.dart';
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

  String? selectedCategory;

  List<String> attractionCategories = [
    "Natural Attractions",
    "Cultural & Historical Attractions",
    "Urban & Architectural Attractions",
    "Parks & Protected Areas",
    "Entertainment & Recreational Attractions",
    "Religious & Spiritual Attractions",
    "Adventure & Outdoor Attractions",
  ];

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController videoUrlController = TextEditingController();
  TextEditingController idController = TextEditingController();
  var formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    idController.text = IdGenerator.generateAttractionId(
        attractionTitle: titleController.text ?? "");
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
                hintText: "Id",
                controller: idController,
                isReadOnly: true,
              ),
              0.01.height.hSpace,
              CustomTextFormField(
                hintText: "Title",
                controller: titleController,
                onComplete: (value) {
                  setState(() {});
                },
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
              DropdownMenu(
                width: double.maxFinite,
                hintText: selectedCategory ?? "Category",
                dropdownMenuEntries: [
                  for (var category in attractionCategories)
                    DropdownMenuEntry(
                      value: selectedCategory,
                      label: category,
                    ),
                ],
              ),
              0.01.height.hSpace,
              SizedBox(
                height: 0.4.height,
                child: AttractionMap(),
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
                    AttractionsModel model = AttractionsModel(
                      category: selectedCategory ?? "Not Categorized",
                      id: idController.text,
                      title: titleController.text,
                      location: "location",
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
