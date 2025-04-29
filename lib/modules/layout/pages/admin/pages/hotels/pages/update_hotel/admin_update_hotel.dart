import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:travel_go/core/services/bot_toast.dart';
import 'package:travel_go/core/utils/hotels_db.dart';
import '/core/extensions/extensions.dart';
import '/core/widget/custom_container.dart';
import '/core/widget/custom_elevated_button.dart';
import '/core/widget/custom_text_form_field.dart';
import '/core/widget/numbers_text_form_field.dart';
import '/models/hotel_model.dart';
import '../../../../../../../../core/theme/app_colors.dart';
import '../../../../../../../../core/widget/dividers_word.dart';
import '../../../../../../../../core/widget/loading_image_network_widget.dart';
import '../../../../../../widget/text_labels_widget.dart';

class AdminUpdateHotel extends StatefulWidget {
  final Hotel hotel;

  const AdminUpdateHotel({
    super.key,
    required this.hotel,
  });

  @override
  State<AdminUpdateHotel> createState() => _AdminUpdateHotelState();
}

class _AdminUpdateHotelState extends State<AdminUpdateHotel> {
  bool isChanged = false;
  TextEditingController hotelNameController = TextEditingController();
  TextEditingController availableRooms = TextEditingController();
  TextEditingController singleRoom = TextEditingController();
  TextEditingController singleRoomPrice = TextEditingController();
  TextEditingController doubleRoom = TextEditingController();
  TextEditingController doubleRoomPrice = TextEditingController();
  TextEditingController suite = TextEditingController();
  TextEditingController suitePrice = TextEditingController();

  _update() async {
    EasyLoading.show();
    widget.hotel.availableRooms = (availableRooms.text.isEmpty)
        ? widget.hotel.availableRooms
        : int.parse(availableRooms.text);
    widget.hotel.hotelName = hotelNameController.text.isEmpty
        ? widget.hotel.hotelName
        : hotelNameController.text;
    widget.hotel.accomdations[0].roomAvailable = (singleRoom.text.isEmpty)
        ? widget.hotel.accomdations[0].roomAvailable
        : int.parse(singleRoom.text);
    widget.hotel.accomdations[0].roomPrice = (singleRoomPrice.text.isEmpty)
        ? widget.hotel.accomdations[0].roomPrice
        : double.parse(singleRoomPrice.text);
    widget.hotel.accomdations[1].roomAvailable = (doubleRoom.text.isEmpty)
        ? widget.hotel.accomdations[1].roomAvailable
        : int.parse(doubleRoom.text);
    widget.hotel.accomdations[1].roomPrice = (doubleRoomPrice.text.isEmpty)
        ? widget.hotel.accomdations[1].roomPrice
        : double.parse(doubleRoomPrice.text);
    widget.hotel.accomdations[2].roomAvailable = (suite.text.isEmpty)
        ? widget.hotel.accomdations[2].roomAvailable
        : int.parse(suite.text);
    widget.hotel.accomdations[2].roomPrice = (suitePrice.text.isEmpty)
        ? widget.hotel.accomdations[2].roomPrice
        : double.parse(suitePrice.text);
    final response = await HotelsDB.updateHotel(widget.hotel);
    EasyLoading.dismiss();
    if (response) {
      BotToastServices.showSuccessMessage("Hotel Updated");
      Navigator.pop(context);
    } else {
      BotToastServices.showErrorMessage("Something Went Wrong");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            Icons.arrow_back_ios,
          ),
        ),
        title: Text(
          "Tour And Travel",
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: AppColors.whiteColor,
              ),
        ),
        centerTitle: true,
      ),
      bottomNavigationBar: CustomContainer(
        child: Row(
          children: [
            Expanded(
              child: CustomElevatedButton(
                text: "OK",
                onPressed: (isChanged) ? _update : null,
              ),
            ),
            0.01.width.vSpace,
            Expanded(
              child: CustomElevatedButton(
                text: "Cancel",
                btnColor: AppColors.errorColor,
                onPressed: () => Navigator.pop(context),
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            LoadingImageNetworkWidget(
              imageUrl: widget.hotel.imageUrl,
            ),
            0.01.height.hSpace,
            Column(
              children: [
                TextLabelsWidget(
                  label: "Hotel Id : ",
                  value: widget.hotel.hotelName,
                ),
                0.01.height.hSpace,
                TextLabelsWidget(
                  label: "Hotel Location : ",
                  value: widget.hotel.hotelLocation,
                ),
                0.01.height.hSpace,
                TextLabelsWidget(
                  label: "Hotel Rating : ",
                  value: widget.hotel.hotelRating.toString(),
                ),
                0.01.height.hSpace,
                TextLabelsWidget(
                  label: "Total Rooms : ",
                  value: widget.hotel.totalRooms.toString(),
                ),
                0.01.height.hSpace,
                CustomTextFormField(
                  hintText: widget.hotel.hotelName,
                  controller: hotelNameController,
                  onChanged: (value) {
                    setState(() {
                      isChanged = true;
                    });
                  },
                ),
                0.01.height.hSpace,
                CustomTextFormField(
                  hintText: "${widget.hotel.totalRooms} Available",
                  controller: availableRooms,
                  onChanged: (value) {
                    setState(() {
                      isChanged = true;
                    });
                  },
                ),
                0.01.height.hSpace,
                DividersWord(
                  text: "Room Details ",
                ),
                0.01.height.hSpace,
                TextLabelsWidget(
                  label: "",
                  value: "Single Room : ",
                ),
                0.01.height.hSpace,
                NumbersTextFormField(
                  hintText:
                      "${widget.hotel.accomdations.first.roomAvailable} Room",
                  controller: singleRoom,
                  onChanged: (value) {
                    setState(() {
                      isChanged = true;
                    });
                  },
                ),
                0.01.height.hSpace,
                NumbersTextFormField(
                  hintText: "\$${widget.hotel.accomdations.first.roomPrice}",
                  controller: singleRoomPrice,
                  onChanged: (value) {
                    setState(() {
                      isChanged = true;
                    });
                  },
                ),
                0.01.height.hSpace,
                Divider(
                  color: AppColors.newBlueColor,
                ).hPadding(
                  0.15.width,
                ),
                0.01.height.hSpace,
                TextLabelsWidget(
                  label: "",
                  value: "Double Room : ",
                ),
                NumbersTextFormField(
                  hintText:
                      "${widget.hotel.accomdations[1].roomAvailable} Room",
                  controller: doubleRoom,
                  onChanged: (value) {
                    setState(() {
                      isChanged = true;
                    });
                  },
                ),
                0.01.height.hSpace,
                NumbersTextFormField(
                  hintText: "\$${widget.hotel.accomdations[1].roomPrice}",
                  controller: doubleRoomPrice,
                  onChanged: (value) {
                    setState(() {
                      isChanged = true;
                    });
                  },
                ),
                0.01.height.hSpace,
                Divider(
                  color: AppColors.newBlueColor,
                ).hPadding(
                  0.15.width,
                ),
                0.01.height.hSpace,
                TextLabelsWidget(
                  label: "",
                  value: "Suite : ",
                ),
                NumbersTextFormField(
                  hintText:
                      "${widget.hotel.accomdations.last.roomAvailable} Room",
                  controller: suite,
                  onChanged: (value) {
                    setState(() {
                      isChanged = true;
                    });
                  },
                ),
                0.01.height.hSpace,
                NumbersTextFormField(
                  hintText: "\$${widget.hotel.accomdations.last.roomPrice}",
                  controller: suitePrice,
                  onChanged: (value) {
                    setState(() {
                      isChanged = true;
                    });
                  },
                ),
                0.01.height.hSpace,
              ],
            ).hPadding(0.03.width),
          ],
        ),
      ),
    );
  }
}
