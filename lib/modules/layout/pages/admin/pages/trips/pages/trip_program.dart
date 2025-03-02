import 'dart:io';

import 'package:day_night_time_picker/day_night_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '/core/providers/trip_admin_provider.dart';
import '/core/utils/id_generator.dart';
import '/core/extensions/alignment.dart';
import '/core/widget/widget_eleveted_button.dart';
import '/modules/layout/pages/admin/pages/attractions/pages/new_attractions/pages/new_attraction.dart';
import '/core/extensions/extensions.dart';
import '/core/theme/app_colors.dart';
import '/core/utils/programs_collections.dart';
import '/core/widget/custom_elevated_button.dart';
import '/models/attractions_model.dart';
import '/core/utils/attractions_db.dart';
import '/core/widget/custom_text_form_field.dart';
import '/core/widget/loading_image_network_widget.dart';
import '/modules/layout/pages/admin/menna/trippp/model/programs.dart';

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
    var model = ModalRoute.of(context)!.settings.arguments as int;
    var provider = Provider.of<TripAdminProvider>(context);
    int lengthOfPrograms = provider.getDaySpecificProgram[model].program.length;
    programIdController.text = IdGenerator.generateProgramId(
      dayNumber: (model + 1),
      programTitle: selectedAttraction.text ?? "",
      programNumber: (lengthOfPrograms + 1),
    );
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Program ${lengthOfPrograms + 1} Day ${model + 1}",
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
                          child: LoadingImageNetworkWidget(
                              imageUrl:
                                  "https://i.pinimg.com/736x/5d/63/e1/5d63e18215fd5e1ab2cc1fe3db2d8359.jpg"),
                        )
                      : SizedBox(
                          height: 0.3.height,
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) =>
                                Image.file(_images[index]),
                            separatorBuilder: (context, index) =>
                                0.01.width.vSpace,
                            itemCount: _images.length,
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
                  Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: DropdownMenu(
                          controller: selectedAttraction,
                          enableFilter: true,
                          onSelected: (value) {
                            for (var attractionSearch in attractions) {
                              if (attractionSearch.title ==
                                  selectedAttraction.text) {
                                provider
                                    .setSelectedAttraction(attractionSearch);
                                setState(() {});
                              }
                            }
                          },
                          width: double.maxFinite,
                          dropdownMenuEntries: [
                            for (var element in attractions)
                              DropdownMenuEntry(
                                value: attraction,
                                label: element.title,
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
                          borderRadius: 12,
                          padding: EdgeInsets.symmetric(
                            vertical: 0.02.height,
                          ),
                        ),
                      ),
                    ],
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
                          if (formKey.currentState!.validate()) {
                            _images.clear();
                            provider.addSpecificProgramDay(
                              Program(
                                programTitle: "programTitle",
                                programDetails: "programDetails",
                                attraction: provider.getSelectedAttraction ??
                                    AttractionsModel(
                                      category: "category",
                                      id: "id",
                                      title: "title",
                                      location: "location",
                                      description: "description",
                                      imageUrl: "imageUrl",
                                    ),
                                dayNumber: (model + 1),
                              ),
                              index,
                              lengthOfPrograms,
                            );
                            provider.setSelectedAttraction(null);
                            Navigator.pop(context);
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
