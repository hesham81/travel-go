import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:phone_form_field/phone_form_field.dart';
import '/core/extensions/center.dart';
import '/core/extensions/extensions.dart';
import '/core/theme/app_colors.dart';
import '/core/utils/firebase_auth_services.dart';
import '/core/widget/custom_text_form_field.dart';
import '/core/widget/label.dart';

class AdminProfile extends StatefulWidget {
  static const routeName = '/profile';

  const AdminProfile({super.key});

  @override
  State<AdminProfile> createState() => _AdminProfileState();
}

class _AdminProfileState extends State<AdminProfile> {
  User? user = FirebaseAuthServices.getCurrentUserData();
  PhoneController phoneController = PhoneController();

  @override
  Widget build(BuildContext context) {
    var imageUrl = user!.photoURL;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Profile",
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            GestureDetector(
              child: CircleAvatar(
                radius: 55,
                backgroundImage: imageUrl != null
                    ? NetworkImage(
                        imageUrl,
                      )
                    : NetworkImage(
                        "https://invisiblechildren.com/wp-content/uploads/2012/07/facebook-profile-picture-no-pic-avatar-300x188.jpg",
                      ),
              ).centerWidget(),
            ),
            0.01.height.hSpace,
            Label(
              text: "${user!.email}",
            ),
            0.01.height.hSpace,
            CustomTextFormField(
              hintText: user!.displayName ?? "No Name",
            ),
            0.03.height.hSpace,
            PhoneFormField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(
                    color: AppColors.blackColor,
                    width: 1.05,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(
                    color: AppColors.blackColor,
                    width: 1.05,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(
                    color: AppColors.blackColor,
                    width: 1.05,
                  ),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(
                    color: AppColors.errorColor,
                    width: 1.05,
                  ),
                ),
                hintText: "Phone Number ",
              ),
              initialValue: PhoneNumber.parse('+20'),
              countrySelectorNavigator: const CountrySelectorNavigator.page(),
              enabled: true,
              isCountrySelectionEnabled: true,
              isCountryButtonPersistent: true,
              onSaved: (phone)=>log("Phone Number ${phone!.nsn}"),
              countryButtonStyle: const CountryButtonStyle(
                showDialCode: true,
                showIsoCode: true,
                showFlag: true,
                flagSize: 16,
              ),
            ),
          ],
        ).hPadding(0.018.width),
      ),
    );
  }
}
