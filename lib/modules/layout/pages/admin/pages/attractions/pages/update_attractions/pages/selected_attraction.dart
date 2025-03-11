import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:latlong2/latlong.dart';
import 'package:travel_go/core/widget/labels_widget.dart';
import '/modules/layout/pages/admin/pages/attractions/pages/update_attractions/widget/set_map_location.dart';
import '/modules/layout/pages/admin/pages/attractions/pages/update_attractions/widget/play_youtube_video.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import '/core/utils/attractions_db.dart';
import '/core/extensions/extensions.dart';
import '/core/theme/app_colors.dart';
import '/core/widget/custom_elevated_button.dart';
import '/core/widget/custom_text_form_field.dart';
import '/models/attractions_model.dart';

class SelectedAttraction extends StatefulWidget {
  static const routeName = '/selected_attraction';

  const SelectedAttraction({super.key});

  @override
  State<SelectedAttraction> createState() => _SelectedAttractionState();
}

class _SelectedAttractionState extends State<SelectedAttraction> {
  TextEditingController titleController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController videoUrlController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  bool isChanged = false;

  _uploadChanges(BuildContext context, AttractionsModel model) async {
    EasyLoading.show();
    AttractionsModel newModel = AttractionsModel(
      id: model.id,
      category: model.category,
      title: titleController.text.isEmpty ? model.title : titleController.text,
      location: model.location,
      description: (descriptionController.text.isEmpty)
          ? model.description
          : descriptionController.text,
      imageUrl: model.imageUrl,
      videoUrl: (videoUrlController.text.isEmpty)
          ? model.videoUrl
          : videoUrlController.text,
    );
    await AttractionsDB.editAttraction(
      model,
      newModel,
    ).then(
      (value) {
        EasyLoading.dismiss();
        (value)
            ? EasyLoading.showSuccess("Attraction Updated Successfully")
            : EasyLoading.showError("Attraction Updated Failed");
      },
    );
    Navigator.pop(context);
  }

  late YoutubePlayerController youTubeController;

  _playVideo(String videoUrl) {
    if (videoUrl == "") {
      EasyLoading.showError("The Url Is Invalid");
      return;
    }
    youTubeController = YoutubePlayerController(initialVideoId: videoUrl);
  }

  @override
  Widget build(BuildContext context) {
    var model = ModalRoute.of(context)!.settings.arguments as AttractionsModel;
    var theme = Theme.of(context);
    _playVideo(model.videoUrl ?? "");
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text(
          model.title,
          style: theme.textTheme.titleLarge!.copyWith(
            color: AppColors.whiteColor,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: 0.5.height,
              alignment: Alignment.bottomRight,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                    model.imageUrl,
                  ),
                  fit: BoxFit.cover,
                ),
              ),
              child: IconButton(
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    PlayYoutubeVideo.routeName,
                    arguments: model.videoUrl,
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
            LabelsWidget(
              label: "ID : ",
              value: model.id,
            ).hPadding(0.03.width),
            0.01.height.hSpace,
            LabelsWidget(
              label: "Location : ",
              value: model.location,
            ).hPadding(0.03.width),
            0.01.height.hSpace,
            CustomTextFormField(
              hintText: model.title,
              controller: titleController,
              onComplete: (value) {
                isChanged = true;
                return null;
              },
            ).hPadding(0.03.width),
            0.01.height.hSpace,
            CustomTextFormField(
              hintText: model.description,
              controller: descriptionController,
              minLine: 5,
              onComplete: (value) {
                isChanged = true;
                return null;
              },
            ).hPadding(0.03.width),
            0.01.height.hSpace,
            CustomTextFormField(
              hintText: model.videoUrl ?? "No Video Url Founded",
              controller: videoUrlController,
              onComplete: (value) {
                isChanged = true;
                return null;
              },
            ).hPadding(0.03.width),
            0.01.height.hSpace,
            SizedBox(
              height: 0.4.height,
              child: SetMapLocation(
                locations: LatLng(model.lat ?? 0, model.long ?? 0),
              ),
            ).hPadding(0.03.width),
            0.01.height.hSpace,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: CustomElevatedButton(
                    text: "OK",
                    onPressed: isChanged
                        ? () {
                            _uploadChanges(context, model);
                          }
                        : null,
                    borderRadius: 10,
                  ),
                ),
                0.01.width.vSpace,
                Expanded(
                  child: CustomElevatedButton(
                    text: "Cancel",
                    btnColor: AppColors.errorColor,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    borderRadius: 10,
                  ),
                ),
              ],
            ).hPadding(0.03.width),
          ],
        ),
      ),
    );
  }
}
