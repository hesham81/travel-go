import 'package:currency_picker/currency_picker.dart';
import 'package:flutter/material.dart';
import '/core/extensions/extensions.dart';
import '/core/theme/app_colors.dart';
import '/core/widget/custom_elevated_button.dart';
import '/core/widget/custom_text_form_field.dart';
import '/core/widget/labels_widget.dart';
import '/core/widget/numbers_text_form_field.dart';
import '/models/trip_data_model.dart';
import '/modules/layout/pages/admin/pages/attractions/pages/update_attractions/widget/play_youtube_video.dart';

class UpdateTripWidget extends StatefulWidget {
  final TripDataModel trip;

  const UpdateTripWidget({
    super.key,
    required this.trip,
  });

  @override
  State<UpdateTripWidget> createState() => _UpdateTripWidgetState();
}

class _UpdateTripWidgetState extends State<UpdateTripWidget> {
  TextEditingController videoUrlController = TextEditingController();
  TextEditingController totalGuests = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController currency = TextEditingController();
  TextEditingController totalDays = TextEditingController();

  _startData() {
    videoUrlController.text = widget.trip.tripVideoUrl;
    totalGuests.text = widget.trip.totalGuests.toString();
    price.text = widget.trip.price.toString();
    totalDays.text = widget.trip.totalDays.toString();
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            Icons.arrow_back_ios,
          ),
        ),
        title: Text(
          widget.trip.tripName.toUpperCase(),
          style: theme.titleLarge!.copyWith(
            color: AppColors.whiteColor,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 0.5.height,
              alignment: Alignment.bottomRight,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                    widget.trip.imageUrl!,
                  ),
                  fit: BoxFit.cover,
                ),
              ),
              child: IconButton(
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    PlayYoutubeVideo.routeName,
                    arguments: widget.trip.tripVideoUrl,
                  );
                },
                style: IconButton.styleFrom(
                  backgroundColor: AppColors.errorColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                icon: Icon(
                  Icons.play_arrow_outlined,
                  color: AppColors.whiteColor,
                ),
              ),
            ),
            0.01.height.hSpace,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                LabelsWidget(
                  label: "ID : ",
                  value: widget.trip.tripId,
                ),
                0.01.height.hSpace,
                LabelsWidget(
                  label: "Source : ",
                  value: widget.trip.source,
                ),
                0.01.height.hSpace,
                LabelsWidget(
                  label: "Destination : ",
                  value: widget.trip.destination,
                ),
                0.01.height.hSpace,
                CustomTextFormField(
                  hintText: widget.trip.tripVideoUrl,
                  controller: videoUrlController,
                ),
                0.02.height.hSpace,
                NumbersTextFormField(
                  hintText: "${widget.trip.totalGuests} Guest",
                  controller: totalGuests,
                ),
                0.02.height.hSpace,
                Row(
                  children: [
                    Expanded(
                      flex: 4,
                      child: NumbersTextFormField(
                        hintText: "${widget.trip.price}",
                        controller: price,
                      ),
                    ),
                    0.01.width.vSpace,
                    Expanded(
                      child: CustomElevatedButton(
                        padding: EdgeInsets.symmetric(vertical: 0.015.height),
                        text: widget.trip.currency,
                        onPressed: () {
                          showCurrencyPicker(
                            context: context,
                            theme: CurrencyPickerThemeData(
                              flagSize: 25,
                              titleTextStyle: TextStyle(fontSize: 17),
                              subtitleTextStyle: TextStyle(
                                  fontSize: 15,
                                  color: Theme.of(context).hintColor),
                              bottomSheetHeight:
                                  MediaQuery.of(context).size.height / 2,
                              inputDecoration: InputDecoration(
                                labelText: 'Search',
                                hintText: widget.trip.currency,
                                prefixIcon: const Icon(Icons.search),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: const Color(0xFF8C98A8)
                                        .withOpacity(0.2),
                                  ),
                                ),
                              ),
                            ),
                            onSelect: (Currency value) {},
                          );
                        },
                      ),
                    )
                  ],
                ),
                0.02.height.hSpace,
                NumbersTextFormField(
                  hintText: "${widget.trip.totalDays} Day",
                  controller: totalDays,
                ),
                0.01.height.hSpace,
                Row(
                  children: [
                    Expanded(
                      child: CustomElevatedButton(
                        text: "OK",
                        onPressed: () {},
                      ),
                    ),
                    0.02.width.vSpace,
                    Expanded(
                      child: CustomElevatedButton(
                        text: "Cancel",
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        btnColor: AppColors.errorColor,
                      ),
                    ),
                  ],
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
