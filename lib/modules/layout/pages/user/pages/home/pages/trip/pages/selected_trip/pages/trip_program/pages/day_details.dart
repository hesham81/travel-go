import 'package:flutter/material.dart';
import 'package:rich_readmore/rich_readmore.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '/core/widget/dividers_word.dart';
import '/core/extensions/align.dart';
import '/core/widget/labels_widget.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import '/core/extensions/extensions.dart';
import '/core/theme/app_colors.dart';
import '/core/widget/loading_image_network_widget.dart';
import '/models/program_model.dart';

class DayDetails extends StatefulWidget {
  final ProgramModel model;
  final int index;

  const DayDetails({
    super.key,
    required this.model,
    required this.index,
  });

  @override
  State<DayDetails> createState() => _DayDetailsState();
}

class _DayDetailsState extends State<DayDetails> {
  int currentIndex = 0;

  PageController controller = PageController();

  @override
  Widget build(BuildContext context) {
    YoutubePlayerController _controller = YoutubePlayerController(
      initialVideoId: YoutubePlayer.convertUrlToId(
            widget.model.attractions.first.videoUrl ?? "",
          ) ??
          "",
    );
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
          widget.model.programTitle,
          style: theme.titleLarge!.copyWith(
            color: AppColors.whiteColor,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 0.5.height,
              child: LoadingImageNetworkWidget(
                imageUrl: widget.model.images.first,
              ),
            ),
            0.01.height.hSpace,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Description : ",
                  style: theme.titleMedium!.copyWith(
                    color: AppColors.newBlueColor,
                  ),
                ),
                0.01.height.hSpace,
                RichReadMoreText(
                  TextSpan(
                    text: widget.model.programDetails,
                    style: theme.labelLarge!.copyWith(
                      color: AppColors.blackColor,
                    ),
                  ),
                  settings: LineModeSettings(
                    trimLines: 3,
                    trimCollapsedText: 'More',
                    trimExpandedText: 'Less',
                    moreStyle: theme.labelLarge!.copyWith(
                      color: AppColors.newBlueColor,
                    ),
                    lessStyle: theme.labelLarge!.copyWith(
                      color: AppColors.newBlueColor,
                    ),
                    onPressReadMore: () {},
                    onPressReadLess: () {},
                  ),
                ),
                0.01.height.hSpace,
                LabelsWidget(
                  label: "From : ",
                  value: widget.model.from.format(context),
                ),
                0.01.height.hSpace,
                LabelsWidget(
                  label: "To : ",
                  value: widget.model.to.format(context),
                ),
                0.01.height.hSpace,
                LabelsWidget(
                  label: "Duration : ",
                  value:
                      "${widget.model.to.hour - widget.model.from.hour} Hours",
                ),
                Divider(),
                Text(
                  "Gallery",
                  style: theme.titleMedium!.copyWith(
                    color: AppColors.newBlueColor,
                  ),
                ),
                0.01.height.hSpace,
                ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: SizedBox(
                    height: 0.3.height, // Use MediaQuery for height
                    child: PageView(
                      onPageChanged: (value) {
                        currentIndex = value;
                        setState(() {});
                      },
                      controller: controller,
                      children: [
                        for (var image in widget.model.images)
                          LoadingImageNetworkWidget(
                            imageUrl: image,
                          ),
                      ],
                    ),
                  ),
                ),
                0.01.height.hSpace,
                SmoothPageIndicator(
                  controller: controller,
                  count: widget.model.images.length,
                  axisDirection: Axis.horizontal,
                  effect: WormEffect(
                    activeDotColor: AppColors.newBlueColor,
                    dotWidth: 10,
                    dotHeight: 10,
                  ),
                ).center,
                0.02.height.hSpace,
                SizedBox(
                  height: 0.3.height,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: YoutubePlayer(
                      controller: _controller,
                      showVideoProgressIndicator: true,
                      progressIndicatorColor: AppColors.newBlueColor,
                      progressColors: const ProgressBarColors(
                        playedColor: AppColors.newBlueColor,
                        handleColor: AppColors.newBlueColor,
                      ),
                    ),
                  ),
                ),
                0.01.height.hSpace,
                DividersWord(
                  text: "Attractions",
                ),
                0.01.height.hSpace,
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    LabelsWidget(
                      label: "Name : ",
                      value: widget.model.attractions.first.title,
                    ),
                    0.01.height.hSpace,
                    Text(
                      'Description : ',
                      style: theme.labelLarge!.copyWith(
                        color: AppColors.newBlueColor,
                      ),
                    ),
                    0.01.height.hSpace,
                    RichReadMoreText(
                      TextSpan(
                        text: widget.model.attractions.first.description,
                        style: theme.labelLarge!.copyWith(
                          color: AppColors.blackColor,
                        ),
                      ),
                      settings: LineModeSettings(
                        trimLines: 3,
                        trimCollapsedText: 'More',
                        trimExpandedText: 'Less',
                        moreStyle: theme.labelLarge!.copyWith(
                          color: AppColors.newBlueColor,
                        ),
                        lessStyle: theme.labelLarge!.copyWith(
                          color: AppColors.newBlueColor,
                        ),
                        onPressReadMore: () {},
                        onPressReadLess: () {},
                      ),
                    ),
                    0.01.height.hSpace,
                  ],
                ),
                0.01.height.hSpace,
              ],
            ).hPadding(0.03.width)
          ],
        ),
      ),
    );
  }
}
