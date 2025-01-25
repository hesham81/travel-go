import 'package:flutter/material.dart';
import '/core/constant/app_assets.dart';
import '/core/extensions/align.dart';
import '/core/extensions/extensions.dart';
import '/core/theme/app_colors.dart';
import '/core/widget/back_leading_widget.dart';
import '/core/widget/custom_elevated_button.dart';
import '/core/widget/custom_text_button.dart';
import '/core/widget/custom_text_form_field.dart';
import '/core/widget/dividers_word.dart';
import '/core/widget/label.dart';
import '/core/widget/social_media_login.dart';

class SignIn extends StatelessWidget {
  static const routeName = '/sign-in';

  const SignIn({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SafeArea(
            child: Row(
              children: [
                BackLeadingWidget(),
                0.035.width.vSpace,
                Text(
                  "Sign in",
                  style: TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.w700,
                    color: AppColors.azureBlueColor,
                  ),
                ),
              ],
            ),
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  0.05.height.hSpace,
                  Label(
                    text: 'Email',
                  ).hPadding(0.04.width),
                  0.01.height.hSpace,
                  CustomTextFormField(
                    hintText: 'email',
                    suffixIcon: Icons.email_outlined,
                  ),
                  0.02.height.hSpace,
                  Label(
                    text: 'Password',
                  ).hPadding(0.04.width),
                  0.01.height.hSpace,
                  CustomTextFormField(
                    hintText: "Password",
                    isPassword: true,
                  ),
                  CustomTextButton(
                    onPressed: () {},
                    text: 'Forgot Password?',
                  ).alignRight(),
                  0.01.height.hSpace,
                  CustomElevatedButton(
                    text: "Sign in",
                    onPressed: () {},
                    padding: EdgeInsets.symmetric(
                      vertical: 0.002.height,
                      horizontal: 0.15.width,
                    ),
                  ).center,
                  0.02.height.hSpace,
                  DividersWord(text: "or sign in with"),
                  0.02.height.hSpace,
                  Expanded(
                    child: Column(
                      children: [
                        Expanded(
                          child: SocialMediaLogin(
                            text: 'Continue With Google',
                            imagePath: AppAssets.googleICN,
                          ),
                        ),
                        0.02.height.hSpace,
                        Expanded(
                          child: SocialMediaLogin(
                            text: 'Continue With Twitter',
                            imagePath: AppAssets.twitterICN,
                          ),
                        ),
                        0.02.height.hSpace,
                        Expanded(
                          child: SocialMediaLogin(
                            text: 'Continue With Facebook',
                            imagePath: AppAssets.facebookICN,
                          ),
                        ),
                        0.04.height.hSpace,
                      ],
                    ),
                  )
                ],
              ).hPadding(0.08.width),
            ),
          )
        ],
      ),
    );
  }
}
