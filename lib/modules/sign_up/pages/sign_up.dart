import 'package:flutter/material.dart';
import 'package:travel_go/core/constant/app_assets.dart';
import 'package:travel_go/core/widget/custom_elevated_button.dart';
import 'package:travel_go/core/widget/custom_text_button.dart';
import 'package:travel_go/core/widget/custom_text_form_field.dart';
import 'package:travel_go/core/widget/dividers_word.dart';
import 'package:travel_go/modules/first_screen/widget/check_widget.dart';
import '../../../core/widget/label.dart';
import '../../../core/widget/social_media_login.dart';
import '../../sign_in/pages/sign_in.dart';
import '/core/extensions/extensions.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/widget/back_leading_widget.dart';

class SignUp extends StatelessWidget {
  static const routeName = '/sign-up';

  const SignUp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            Row(
              children: [
                BackLeadingWidget(),
                0.035.width.vSpace,
                Text(
                  "Sign Up",
                  style: TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.w700,
                    color: AppColors.azureBlueColor,
                  ),
                ),
              ],
            ),
            CustomTextButton(
              onPressed: () {
                Navigator.pushNamed(context, SignIn.routeName);
              },
              text: "Already have an account? log in",
              textColor: AppColors.blackColor,
              textWeight: FontWeight.w500,
              textSize: 16,
            ),
            0.05.height.hSpace,
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.whiteColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Label(
                        text: 'Full Name',
                      ).hPadding(0.03.width),
                      0.01.height.hSpace,
                      CustomTextFormField(hintText: "Enter Full Name"),
                      0.02.height.hSpace,
                      Label(
                        text: 'Email',
                      ).hPadding(0.03.width),
                      0.01.height.hSpace,
                      CustomTextFormField(hintText: "Enter Email"),
                      0.02.height.hSpace,
                      Label(
                        text: 'Password',
                      ).hPadding(0.03.width),
                      0.01.height.hSpace,
                      CustomTextFormField(
                        hintText: "Enter Password",
                        isPassword: true,
                      ),
                      0.02.height.hSpace,
                      Label(
                        text: 'Confirm Password',
                      ).hPadding(0.03.width),
                      0.01.height.hSpace,
                      CustomTextFormField(
                        hintText: "Confirm Password",
                        isPassword: true,
                      ),
                      0.005.height.hSpace,
                      CheckWidget(),
                      0.02.height.hSpace,
                      CustomElevatedButton(
                        text: "Sign Up",
                        onPressed: () {},
                        borderRadius: 20,
                        padding: EdgeInsets.symmetric(
                          horizontal: 0.02.height,
                          vertical: 0,
                        ),
                      ),
                      0.02.height.hSpace,
                      DividersWord(text: ' or sign up with'),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            AppAssets.googleICN,
                            height: 35,
                            width: 35,
                          ),
                          Image.asset(
                            AppAssets.twitterICN,
                            height: 35,
                            width: 35,
                          ),
                          Image.asset(
                            AppAssets.facebookICN,
                            height: 35,
                            width: 35,
                          ),
                        ],
                      ).hPadding(0.08.width)
                    ],
                  ).hPadding(0.07.width).vPadding(0.02.height),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
