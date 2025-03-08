import 'package:flutter/material.dart';
import 'package:rich_readmore/rich_readmore.dart';
import '/core/extensions/extensions.dart';
import '/core/theme/app_colors.dart';
import '/core/widget/custom_text_button.dart';
import '/core/widget/dividers_word.dart';
import '/core/widget/labels_widget.dart';
import '/models/trip_data_model.dart';

class TripInfo extends StatelessWidget {
  final TripDataModel model;

  const TripInfo({
    super.key,
    required this.model,
  });

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        0.01.height.hSpace,
        DividersWord(
          text: "Company Details ",
        ),
        0.01.height.hSpace,
        LabelsWidget(
          label: "Name : ",
          value: model.organizedBy.companyName,
        ),
        0.02.height.hSpace,
        Row(
          children: [
            Icon(
              Icons.phone_outlined,
              color: AppColors.newBlueColor,
            ),
            0.08.width.vSpace,
            Text(
              model.organizedBy.phoneNumber,
              style: theme.labelLarge!.copyWith(
                color: Colors.black,
              ),
            ),
          ],
        ),
        0.01.height.hSpace,
        LabelsWidget(
          label: "Since : ",
          value: model.organizedBy.companyStartFrom,
        ),
        CustomTextButton(
          onPressed: () {},
          text: model.organizedBy.companyWebsite,
          textSize: 12,
        ),
        DividersWord(
          text: "Travel Requirements",
        ),
        0.01.height.hSpace,
        LabelsWidget(
          label: "Visa Requirements : ",
          value: "",
        ),
        0.01.height.hSpace,
        RichReadMoreText(
          TextSpan(
            text: "Whether a visa is needed and how to obtain it",
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
          label: "Vaccinations : ",
          value: "",
        ),
        RichReadMoreText(
          TextSpan(
            text: "Any required or recommended vaccinations",
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
        0.02.height.hSpace,
        LabelsWidget(
          label: "Packing List : ",
          value: "",
        ),
        RichReadMoreText(
          TextSpan(
            text:
                "A list of items to pack (e.g., \"Warm clothes for winter trips\")",
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
        0.02.height.hSpace,
        LabelsWidget(
          label: "Travel Insurance : ",
          value: "",
        ),
        RichReadMoreText(
          TextSpan(
            text: "Whether travel insurance is required or recommended.",
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
        0.02.height.hSpace,
        DividersWord(
          text: "Contact Information",
        ),
        0.01.height.hSpace,
        LabelsWidget(
          label: "Tour Operator Contact : ",
          value: "",
        ),
        RichReadMoreText(
          TextSpan(
            text:
                "The name, phone number, and email of the tour operator or organizer.",
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
          label: "Emergency Contact : ",
          value: "",
        ),
        RichReadMoreText(
          TextSpan(
            text:
                "A local emergency contact number for the destination.",
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
    );
  }
}
