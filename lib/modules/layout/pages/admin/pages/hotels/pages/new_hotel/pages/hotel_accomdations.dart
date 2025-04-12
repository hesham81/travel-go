import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel_go/core/constant/app_assets.dart';
import 'package:travel_go/core/providers/hotel_admin_provider.dart';
import 'package:travel_go/models/hotel_accomdations_data_model.dart';
import '/core/extensions/extensions.dart';
import '/core/theme/app_colors.dart';
import '/core/widget/custom_elevated_button.dart';
import '/core/widget/dividers_word.dart';
import '/core/widget/numbers_text_form_field.dart';

class AdminHotelAccomdations extends StatefulWidget {
  const AdminHotelAccomdations({super.key});

  @override
  State<AdminHotelAccomdations> createState() => _AdminHotelAccomdationsState();
}

class _AdminHotelAccomdationsState extends State<AdminHotelAccomdations> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<HotelAdminProvider>(context);
    var theme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "New Accomdations",
          style: theme.titleLarge!.copyWith(
            color: AppColors.whiteColor,
          ),
        ),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            Icons.arrow_back_ios,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: provider.formKey,
          child: Column(
            children: [
              DividersWord(
                text: "SingleRoom",
              ),
              0.01.height.hSpace,
              GestureDetector(
                onTap: () {
                  provider.pickSingleImages();
                },
                child: (provider.singleImages.isEmpty)
                    ? Image.asset(
                        AppAssets.noAvailableImages,
                      )
                    : CarouselSlider(
                        items: provider.singleImages
                            .map(
                              (e) => Image.file(e),
                            )
                            .toList(),
                        options: CarouselOptions(
                          height: 0.4.height,
                        ),
                      ),
              ),
              0.01.height.hSpace,
              NumbersTextFormField(
                hintText: "Total Rooms",
                controller: provider.singleTotalRoomsController,
                validation: (value) {
                  if (value!.isEmpty) {
                    return "Please Enter Total Rooms";
                  }
                  return null;
                },
              ),
              0.01.height.hSpace,
              NumbersTextFormField(
                hintText: "Available Rooms",
                controller: provider.singleAvailableRoomsController,
                validation: (value) {
                  if (value!.isEmpty) {
                    return "Please Enter Total Rooms";
                  }
                  return null;
                },
              ),
              0.01.height.hSpace,
              NumbersTextFormField(
                hintText: "Price",
                controller: provider.singlePriceController,
                validation: (value) {
                  if (value!.isEmpty) {
                    return "Please Enter Total Rooms";
                  }
                  return null;
                },
              ),
              0.01.height.hSpace,
              GestureDetector(
                onTap: () {
                  provider.pickDoubleImages();
                },
                child: (provider.doubleImages.isEmpty)
                    ? Image.asset(
                        AppAssets.noAvailableImages,
                      )
                    : CarouselSlider(
                        items: provider.doubleImages
                            .map(
                              (e) => Image.file(e),
                            )
                            .toList(),
                        options: CarouselOptions(
                          height: 0.4.height,
                        ),
                      ),
              ),
              0.01.height.hSpace,
              DividersWord(
                text: "DoubleRoom",
              ),
              0.01.height.hSpace,
              NumbersTextFormField(
                hintText: "Total Rooms",
                controller: provider.doubleTotalRoomsController,
                validation: (value) {
                  if (value!.isEmpty) {
                    return "Please Enter Total Rooms";
                  }
                  return null;
                },
              ),
              0.01.height.hSpace,
              NumbersTextFormField(
                hintText: "Available Rooms",
                controller: provider.doubleAvailableRoomsController,
                validation: (value) {
                  if (value!.isEmpty) {
                    return "Please Enter Total Rooms";
                  }
                  return null;
                },
              ),
              0.01.height.hSpace,
              NumbersTextFormField(
                hintText: "Price",
                controller: provider.doublePriceController,
                validation: (value) {
                  if (value!.isEmpty) {
                    return "Please Enter Total Rooms";
                  }
                  return null;
                },
              ),
              0.01.height.hSpace,
              GestureDetector(
                onTap: () {
                  provider.pickSuitImages();
                },
                child: (provider.suitImages.isEmpty)
                    ? Image.asset(
                        AppAssets.noAvailableImages,
                      )
                    : CarouselSlider(
                        items: provider.suitImages
                            .map(
                              (e) => Image.file(e),
                            )
                            .toList(),
                        options: CarouselOptions(
                          height: 0.4.height,
                        ),
                      ),
              ),
              0.01.height.hSpace,
              DividersWord(
                text: "SuiteRoom",
              ),
              0.01.height.hSpace,
              NumbersTextFormField(
                hintText: "Total Rooms",
                controller: provider.suiteTotalRoomsController,
                validation: (value) {
                  if (value!.isEmpty) {
                    return "Please Enter Total Rooms";
                  }
                  return null;
                },
              ),
              0.01.height.hSpace,
              NumbersTextFormField(
                hintText: "Available Rooms",
                controller: provider.suiteAvailableRoomsController,
                validation: (value) {
                  if (value!.isEmpty) {
                    return "Please Enter Total Rooms";
                  }
                  return null;
                },
              ),
              0.01.height.hSpace,
              NumbersTextFormField(
                hintText: "Price",
                controller: provider.suitePriceController,
                validation: (value) {
                  if (value!.isEmpty) {
                    return "Please Enter Total Rooms";
                  }
                  return null;
                },
              ),
              0.03.height.hSpace,
              Row(
                children: [
                  Expanded(
                    child: CustomElevatedButton(
                      text: "OK",
                      onPressed: () async{
                        if (provider.formKey.currentState!.validate() &&
                            provider.singleImages.isNotEmpty &&
                            provider.doubleImages.isNotEmpty &&
                            provider.suitImages.isNotEmpty) {
                          provider.createRooms(
                            singleRoom: HotelAccomdationsDataModel(
                              roomType: "Single Room",
                              roomPrice: double.tryParse(
                                    provider.singlePriceController.text,
                                  ) ??
                                  0.0,
                              roomAvailable: int.tryParse(
                                    provider
                                        .singleAvailableRoomsController.text,
                                  ) ??
                                  0,
                              imagesUrls: [],
                            ),
                            doubleRoom: HotelAccomdationsDataModel(
                              roomType: "Double Room",
                              roomPrice: double.tryParse(
                                    provider.doublePriceController.text,
                                  ) ??
                                  0.0,
                              roomAvailable: int.tryParse(
                                    provider
                                        .doubleAvailableRoomsController.text,
                                  ) ??
                                  0,
                              imagesUrls: [],
                            ),
                            suitRoom: HotelAccomdationsDataModel(
                              roomType: "Suit Room",
                              roomPrice: double.tryParse(
                                    provider.suitePriceController.text,
                                  ) ??
                                  0.0,
                              roomAvailable: int.tryParse(
                                    provider.suiteAvailableRoomsController.text,
                                  ) ??
                                  0,
                              imagesUrls: [],
                            ),
                          );
                          Navigator.pop(context);
                        }
                      },
                    ),
                  ),
                  0.01.height.vSpace,
                  Expanded(
                    child: CustomElevatedButton(
                      text: "Cancel",
                      onPressed: () => Navigator.pop(context),
                      btnColor: AppColors.errorColor,
                    ),
                  ),
                ],
              ),
              0.01.height.hSpace,
            ],
          ).hPadding(0.03.width),
        ),
      ),
    );
  }
}
