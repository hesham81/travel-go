import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:travel_go/core/extensions/align.dart';
import 'package:travel_go/core/extensions/extensions.dart';
import 'package:travel_go/core/widget/custom_elevated_button.dart';
import 'package:travel_go/core/widget/labels_widget.dart';

import '../../../../../../../core/theme/app_colors.dart';

class MyProfile extends StatefulWidget {
  const MyProfile({super.key});

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  var user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "My Profile",
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: AppColors.whiteColor,
              ),
        ),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            Icons.arrow_back_ios,
            color: AppColors.whiteColor,
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          0.01.height.hSpace,
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: AppColors.newBlueColor,
                width: 4,
              ),
              borderRadius: BorderRadius.circular(50),
            ),
            child: CircleAvatar(
              radius: 40,
              backgroundImage: CachedNetworkImageProvider(
                user!.photoURL!,
              ),
            ),
          ).center,
          0.03.height.hSpace,
          Text(
            user!.displayName!,
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  color: AppColors.blackColor,
                ),
          ),
          0.03.height.hSpace,
          LabelsWidget(
            label: "Name : ",
            value: user?.displayName ?? "No Name",
          ),
          0.03.height.hSpace,
          LabelsWidget(
            label: "Email : ",
            value: user?.providerData.first.email ?? "No Email",
          ),
          0.03.height.hSpace,
          LabelsWidget(
            label: "Phone : ",
            value: user?.providerData.first.phoneNumber ?? "No Phone",
          ),
          0.03.height.hSpace,
          LabelsWidget(
            label: "National ID : ",
            value: "01284152478123",
          ),
          0.03.height.hSpace,
          LabelsWidget(
            label: "Address : ",
            value: "Cairo",
          ),
          0.03.height.hSpace,
          Spacer(),
          CustomElevatedButton(
            text: "Delete Account",
            onPressed: () {},
            borderRadius: 10,
            btnColor: AppColors.errorColor,
          ),
          0.01.height.hSpace,
        ],
      ).hPadding(0.03.width),
    );
  }
}
