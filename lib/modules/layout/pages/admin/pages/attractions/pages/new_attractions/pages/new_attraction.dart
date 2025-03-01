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
  String countryValue = "";
  String stateValue = "";
  String cityValue = "";
  String location = "";
  var formKey = GlobalKey<FormState>();
  List<AttractionsModel> attractions = [
    AttractionsModel(
      id: "Attraction-Beach",
      title: "Sunny Beach",
      location: "California, USA",
      description:
          "A beautiful sunny beach with golden sands and clear blue waters.",
      imageUrl: "https://example.com/beach.jpg",
      videoUrl: "https://example.com/beach.mp4",
      lat: 34.0194,
      long: -118.4912,
      category: "Natural Attractions",
    ),
    AttractionsModel(
      id: "Attraction-Mountain",
      title: "Rocky Mountain",
      location: "Colorado, USA",
      description: "A majestic mountain range with scenic hiking trails.",
      imageUrl: "https://example.com/mountain.jpg",
      videoUrl: "https://example.com/mountain.mp4",
      lat: 39.5501,
      long: -105.7821,
      category: "Natural Attractions",
    ),
    AttractionsModel(
      id: "Attraction-Waterfall",
      title: "Niagara Falls",
      location: "Ontario, Canada",
      description: "A breathtaking waterfall on the US-Canada border.",
      imageUrl: "https://example.com/waterfall.jpg",
      videoUrl: "https://example.com/waterfall.mp4",
      lat: 43.0896,
      long: -79.0849,
      category: "Natural Attractions",
    ),
    AttractionsModel(
      id: "Attraction-Desert",
      title: "Sahara Desert",
      location: "North Africa",
      description: "The largest hot desert in the world with stunning dunes.",
      imageUrl: "https://example.com/desert.jpg",
      videoUrl: "https://example.com/desert.mp4",
      lat: 23.4162,
      long: 25.6628,
      category: "Natural Attractions",
    ),
    AttractionsModel(
      id: "Attraction-Island",
      title: "Bali Island",
      location: "Indonesia",
      description:
          "A paradise island known for its beaches, temples, and culture.",
      imageUrl: "https://example.com/bali.jpg",
      videoUrl: "https://example.com/bali.mp4",
      lat: -8.3405,
      long: 115.0920,
      category: "Natural Attractions",
    ),
    AttractionsModel(
      id: "Attraction-Canyon",
      title: "Grand Canyon",
      location: "Arizona, USA",
      description: "A stunning canyon carved by the Colorado River.",
      imageUrl: "https://example.com/canyon.jpg",
      videoUrl: "https://example.com/canyon.mp4",
      lat: 36.1069,
      long: -112.1129,
      category: "Natural Attractions",
    ),
    AttractionsModel(
      id: "Attraction-Temple",
      title: "Angkor Wat",
      location: "Cambodia",
      description:
          "A stunning ancient temple complex and UNESCO World Heritage site.",
      imageUrl: "https://example.com/angkorwat.jpg",
      videoUrl: "https://example.com/angkorwat.mp4",
      lat: 13.4125,
      long: 103.8667,
      category: "Cultural & Historical Attractions",
    ),
    AttractionsModel(
      id: "Attraction-Tower",
      title: "Burj Khalifa",
      location: "Dubai, UAE",
      description:
          "The tallest building in the world offering breathtaking views.",
      imageUrl: "https://example.com/burjkhalifa.jpg",
      videoUrl: "https://example.com/burjkhalifa.mp4",
      lat: 25.1972,
      long: 55.2744,
      category: "Urban & Architectural Attractions",
    ),
    AttractionsModel(
      id: "Attraction-Village",
      title: "Hallstatt",
      location: "Austria",
      description:
          "A picturesque lakeside village with stunning alpine scenery.",
      imageUrl: "https://example.com/hallstatt.jpg",
      videoUrl: "https://example.com/hallstatt.mp4",
      lat: 47.5622,
      long: 13.6493,
      category: "Cultural & Historical Attractions",
    ),
    AttractionsModel(
      id: "Attraction-Stadium",
      title: "Maracanã Stadium",
      location: "Brazil",
      description: "One of the most famous football stadiums in the world.",
      imageUrl: "https://example.com/maracana.jpg",
      videoUrl: "https://example.com/maracana.mp4",
      lat: -22.9122,
      long: -43.2302,
      category: "Urban & Architectural Attractions",
    ),
    AttractionsModel(
      id: "Attraction-Park",
      title: "Yellowstone National Park",
      location: "Wyoming, USA",
      description: "A famous national park with geysers and diverse wildlife.",
      imageUrl: "https://example.com/yellowstone.jpg",
      videoUrl: "https://example.com/yellowstone.mp4",
      lat: 44.4280,
      long: -110.5885,
      category: "Parks & Protected Areas",
    ),
    AttractionsModel(
      id: "Attraction-Lake",
      title: "Lake Tahoe",
      location: "Nevada, USA",
      description: "A large freshwater lake known for its crystal-clear water.",
      imageUrl: "https://example.com/tahoe.jpg",
      videoUrl: "https://example.com/tahoe.mp4",
      lat: 39.0968,
      long: -120.0324,
      category: "Natural Attractions",
    ),
    AttractionsModel(
      id: "Attraction-River",
      title: "Amazon River",
      location: "South America",
      description:
          "The second longest river in the world, rich in biodiversity.",
      imageUrl: "https://example.com/amazon_river.jpg",
      videoUrl: "https://example.com/amazon_river.mp4",
      lat: -3.4653,
      long: -62.2159,
      category: "Natural Attractions",
    ),
    AttractionsModel(
      id: "Attraction-Forest",
      title: "Amazon Rainforest",
      location: "South America",
      description:
          "The largest rainforest in the world, home to diverse wildlife.",
      imageUrl: "https://example.com/amazon.jpg",
      videoUrl: "https://example.com/amazon.mp4",
      lat: -3.4653,
      long: -62.2159,
      category: "Natural Attractions",
    ),
    AttractionsModel(
      id: "Attraction-Bridge",
      title: "Golden Gate Bridge",
      location: "San Francisco, USA",
      description:
          "An iconic suspension bridge known for its red-orange color and stunning views.",
      imageUrl: "https://example.com/golden_gate.jpg",
      videoUrl: "https://example.com/golden_gate.mp4",
      lat: 37.8199,
      long: -122.4783,
      category: "Urban & Architectural Attractions",
    ),
  ];


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
                    location = "$countryValue,$cityValue";
                    AttractionsModel model = AttractionsModel(
                      category: selectedCategory ?? "Not Categorized",
                      id: idController.text,
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
