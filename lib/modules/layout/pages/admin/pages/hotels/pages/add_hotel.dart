import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:image_picker/image_picker.dart';
import '/core/services/storage.dart';
import '/core/constant/app_assets.dart';
import '/core/extensions/align.dart';
import '/core/extensions/extensions.dart';
import '/core/utils/hotels_db.dart';
import '/core/widget/custom_elevated_button.dart';
import '/core/widget/custom_text_form_field.dart';
import '/core/widget/label.dart';
import '/core/widget/numbers_text_form_field.dart';
import '/models/hotel_model.dart';
import '/core/theme/app_colors.dart';

class AddHotel extends StatefulWidget {
  static const routeName = '/add-hotel';

  const AddHotel({super.key});

  @override
  State<AddHotel> createState() => _AddHotelState();
}

class _AddHotelState extends State<AddHotel> {
  var hotelNameController = TextEditingController();
  var availableRoomsController = TextEditingController();
  var totalRoomsController = TextEditingController();
  var hotelRatingController = 0.0;
  var hotelLocationController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  File? _image;

  Future<void> _pickImage() async {
    var source = ImageSource.gallery;
    final picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Add Hotel",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppColors.blackColor,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _image == null
                ? GestureDetector(
                    onTap: () async {
                      _image = null;
                      await _pickImage();
                    },
                    child: Image.asset(
                      AppAssets.uploadImage,
                      width: double.maxFinite,
                      height: 0.3.height,
                      fit: BoxFit.cover,
                    ),
                  )
                : Image.file(
                    _image!,
                    width: double.maxFinite,
                    height: 0.3.height,
                    fit: BoxFit.cover,
                  ),
            0.01.height.hSpace,
            Form(
              key: formKey,
              autovalidateMode: AutovalidateMode.onUnfocus,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Label(
                    text: "Hotel Name",
                    textSize: 15,
                  ).hPadding(0.01.width),
                  0.01.height.hSpace,
                  CustomTextFormField(
                    hintText: "hotelName",
                    controller: hotelNameController,
                  ),
                  0.01.height.hSpace,
                  Label(
                    text: "Available Rooms",
                    textSize: 15,
                  ).hPadding(0.01.width),
                  0.01.height.hSpace,
                  NumbersTextFormField(
                    hintText: "Available Rooms",
                    controller: availableRoomsController,
                  ),
                  0.01.height.hSpace,
                  Label(
                    text: "Total Rooms",
                    textSize: 15,
                  ).hPadding(0.01.width),
                  0.01.height.hSpace,
                  NumbersTextFormField(
                    controller: totalRoomsController,
                    hintText: "Total Rooms",
                    validation: (value) {
                      var totalRooms = int.parse(totalRoomsController.text);
                      var avaRooms = int.parse(availableRoomsController.text);
                      if (totalRooms < avaRooms) {
                        return "Total Rooms Can't be less than Available Rooms";
                      }
                      return null;
                    },
                  ),
                  0.01.height.hSpace,
                  Label(
                    text: "Hotel Locations",
                    textSize: 15,
                  ).hPadding(0.01.width),
                  0.01.height.hSpace,
                  CustomTextFormField(
                    hintText: "Hotel Location",
                    controller: hotelLocationController,
                  ),
                  0.01.height.hSpace,
                  RatingBar.builder(
                    initialRating: 1.0,
                    minRating: 1.0,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                    itemBuilder: (context, _) => Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    onRatingUpdate: (rating) {
                      hotelRatingController = rating;
                    },
                  ).center,
                  0.01.height.hSpace,

                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      CustomElevatedButton(
                        text: "Add",
                        padding: EdgeInsets.zero,
                        textSize: 25,
                        borderRadius: 15,
                        onPressed: () async {
                          EasyLoading.show();
                          if (_image != null) {
                            await Storage.uploadPublicImage(
                              hotelName: hotelNameController.text,
                              image: _image!,
                              fileName: hotelNameController.text,
                            );
                          } else {
                            EasyLoading.dismiss();
                            EasyLoading.showError("Error While Upload Image ");
                          }

                          if (formKey.currentState!.validate()) {
                            var url = Storage.getPublicUrlImage(
                                hotelNameController.text);
                            Hotel data = Hotel(
                              imageUrl: url ?? "",
                              availableRooms: int.parse(
                                availableRoomsController.text,
                              ),
                              hotelLocation: hotelLocationController.text,
                              hotelName: hotelNameController.text,
                              hotelRating: hotelRatingController,
                              totalRooms: int.parse(totalRoomsController.text),
                            );
                            HotelsDB.addHotel(
                              hotel: data,
                            ).then((_) {
                              EasyLoading.dismiss();
                            });
                            Navigator.pop(context);
                          }
                        },
                      ),
                    ],
                  ),
                ],
              ).hPadding(0.02.width),
            ),
          ],
        ),
      ),
    );
  }
}
