import 'dart:io';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:day_night_time_picker/day_night_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '/core/constant/app_assets.dart';
import '/core/services/bot_toast.dart';
import '/core/services/storage.dart';
import '/models/program_model.dart';
import '/modules/layout/pages/admin/pages/trips/pages/select_attraction.dart';
import '/core/providers/trip_admin_provider.dart';
import '/core/utils/id_generator.dart';
import '/core/extensions/alignment.dart';
import '/core/widget/widget_eleveted_button.dart';
import '/core/extensions/extensions.dart';
import '/core/theme/app_colors.dart';
import '/core/utils/programs_collections.dart';
import '/core/widget/custom_elevated_button.dart';
import '/models/attractions_model.dart';
import '/core/utils/attractions_db.dart';
import '/core/widget/custom_text_form_field.dart';

class TripProgram extends StatefulWidget {
  static const String routeName = '/trip_program';

  const TripProgram({super.key});

  @override
  State<TripProgram> createState() => _TripProgramState();
}

class _TripProgramState extends State<TripProgram> {
  List<AttractionsModel> attractions = [];

  var formKey = GlobalKey<FormState>();
  var titleController = TextEditingController();
  var descriptionController = TextEditingController();
  var programIdController = TextEditingController();
  var noOfDaysController = TextEditingController();
  var selectedAttraction = TextEditingController();
  AttractionsModel? attraction;
  int index = 0;

  Time? from;
  List<File> _images = [];

  Future<void> pickImage() async {
    final ImagePicker picker = ImagePicker();
    final List<XFile> selectedImages = await picker.pickMultiImage();

    if (selectedImages.isNotEmpty) {
      setState(() {
        _images
            .addAll(selectedImages.map((image) => File(image.path)).toList());
      });
    }
  }

  Time? to;

  @override
  void initState() {
    super.initState();
    AttractionsDB.getAttractionsList().then(
      (value) {
        attractions = value;
      },
    );
    ProgramsCollections.getAllPrograms().then(
      (value) => value,
    );
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).textTheme;
    var provider = Provider.of<TripAdminProvider>(context);
    programIdController.text = IdGenerator.generateProgramId(
      programTitle: titleController.text ?? "",
      programNumber: (provider.listOfPrograms.length + 1),
    );
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Program ${provider.listOfPrograms.length + 1} ",
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
                  (_images.isEmpty)
                      ? GestureDetector(
                          onTap: () {
                            pickImage();
                          },
                          child: Image.asset(
                            AppAssets.noAvailableImages,
                          ),
                        )
                      : SizedBox(
                          height: 0.3.height,
                          child: CarouselSlider(
                            items: _images.map((imagePath) {
                              return Container(
                                margin: EdgeInsets.all(5.0),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8.0),
                                  child: Image.file(
                                    imagePath,
                                    fit: BoxFit.cover,
                                    width: double.infinity,
                                  ),
                                ),
                              );
                            }).toList(),
                            options: CarouselOptions(
                              reverse: false,
                              autoPlay: true,
                            ),
                          ),
                        ),
                  0.01.height.hSpace,
                  CustomTextFormField(
                    hintText: "Program Id",
                    controller: programIdController,
                    isReadOnly: true,
                    validation: (value) =>
                        titleController.text.isEmpty ? "Enter title" : null,
                  ),
                  0.01.height.hSpace,
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
                  Text(
                    "Select Attraction",
                    style: theme.titleMedium!.copyWith(
                      color: AppColors.blackColor,
                    ),
                  ).leftBottomWidget(),
                  0.01.height.hSpace,
                  SizedBox(
                    width: double.maxFinite,
                    child: CustomElevatedButton(
                      text: "Select Attractions",
                      onPressed: () {
                        Navigator.pushNamed(
                          context,
                          SelectAttraction.routeName,
                        );
                      },
                    ),
                  ),
                  0.01.height.hSpace,
                  ListView.separated(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) => CheckboxListTile(
                      value: (provider.noOfDays.contains(
                        (index + 1),
                      )),
                      onChanged: (value) {
                        if (value == true) {
                          provider.noOfDays.add((index + 1));
                        } else {
                          provider.noOfDays.remove((index + 1));
                        }
                        setState(() {});
                      },
                      selectedTileColor: AppColors.newBlueColor,
                      checkColor: AppColors.whiteColor,
                      hoverColor: AppColors.newBlueColor,
                      title: Text(
                        "Day : ${index + 1}",
                        style: theme.bodyMedium!
                            .copyWith(color: AppColors.blackColor),
                      ),
                    ),
                    separatorBuilder: (context, index) => 0.02.height.hSpace,
                    itemCount: provider.getTotalDays,
                  ),
                  0.01.height.hSpace,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: WidgetElevetedButton(
                          child: Row(
                            children: [
                              Text(
                                (from == null)
                                    ? "From"
                                    : "${from!.hour}:${from!.minute}",
                                style: theme.titleMedium!.copyWith(
                                  color: AppColors.whiteColor,
                                ),
                              ),
                              Spacer(),
                              Icon(
                                Icons.date_range,
                                color: AppColors.whiteColor,
                              ),
                            ],
                          ),
                          onPressed: () {
                            Navigator.of(context).push(
                              showPicker(
                                value: from ?? Time(hour: 0, minute: 0),
                                onChange: (Time) {
                                  setState(() {
                                    from = Time;
                                  });
                                },
                                sunrise: TimeOfDay(hour: 6, minute: 0),
                                sunset: TimeOfDay(hour: 18, minute: 0),
                                duskSpanInMinutes: 120, // optional
                              ),
                            );
                          },
                        ),
                      ),
                      0.05.width.vSpace,
                      Expanded(
                        child: WidgetElevetedButton(
                          child: Row(
                            children: [
                              Text(
                                (to == null)
                                    ? "To"
                                    : "${to!.hour}:${to!.minute}",
                                style: theme.titleMedium!.copyWith(
                                  color: AppColors.whiteColor,
                                ),
                              ),
                              Spacer(),
                              Icon(
                                Icons.date_range,
                                color: AppColors.whiteColor,
                              ),
                            ],
                          ),
                          onPressed: () {
                            Navigator.of(context).push(
                              showPicker(
                                value: to ?? from ?? Time(hour: 0, minute: 0),
                                onChange: (Time time) {
                                  setState(() {
                                    to = time;
                                  });
                                },
                                sunrise: TimeOfDay(hour: 6, minute: 0),
                                sunset: TimeOfDay(hour: 18, minute: 0),
                                blurredBackground: true,
                                duskSpanInMinutes: 120, // optional
                              ),
                            );
                          },
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
                              _images.isNotEmpty) {
                            List<String> urls = [];
                            EasyLoading.show();
                            await Storage.uploadProgramAttractionsImages(
                              _images,
                              programIdController.text,
                              provider,
                            ).then(
                              (value) {
                                if (!value) {
                                  EasyLoading.dismiss();
                                  return;
                                }
                              },
                            );
                            print(provider.imageUrls);
                            provider.addProgram(
                              ProgramModel(
                                programTitle: titleController.text,
                                programDetails: descriptionController.text,
                                attractions: provider.selectedAttraction,
                                dayNumber: provider.noOfDays,
                                from: from!,
                                to: to!,
                                id: programIdController.text,
                                images: provider.imageUrls,
                              ),
                            );
                            provider.endOfAddProgram();
                            EasyLoading.dismiss();
                            Navigator.pop(context);
                            setState(() {});
                          } else {
                            BotToastServices.showErrorMessage(
                              "Check Your Inputs",
                            );
                          }
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
