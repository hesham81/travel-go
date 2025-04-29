import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';import '../../../core/utils/social_auth_services.dart';

import '/core/widget/social_media_login.dart';
import '/core/constant/app_assets.dart';
import '/core/utils/firebase_auth_services.dart';
import '/core/widget/custom_elevated_button.dart';
import '/core/widget/custom_text_button.dart';
import '/core/widget/custom_text_form_field.dart';
import '/core/widget/dividers_word.dart';
import '/core/validations/validations.dart';
import '/core/extensions/extensions.dart';
import '/core/theme/app_colors.dart';

class SignUp extends StatefulWidget {
  static const routeName = '/sign-up';

  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var confirmPasswordController = TextEditingController();
  var nationalIdController = TextEditingController();
  var key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        title: Text(
          "Create Account",
          style: theme.textTheme.titleLarge!.copyWith(
            color: AppColors.whiteColor,
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: AppColors.whiteColor,
          ),
        ),
        backgroundColor: AppColors.newBlueColor,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.asset(
              AppAssets.logo,
            ),
            CustomTextFormField(
              hintText: "Name",
              suffixIcon: Icons.person_outline,
              controller: nameController,
            ),
            0.03.height.hSpace,
            CustomTextFormField(
              hintText: "National Id",
              controller: nationalIdController,
              suffixIcon: Icons.credit_card_rounded,
            ),
            0.03.height.hSpace,
            CustomTextFormField(
              hintText: "Email",
              suffixIcon: Icons.email_outlined,
              controller: emailController,
              validation: (value) {
                return Validations.isEmailValid(emailController.text);
              },
            ),
            0.03.height.hSpace,
            CustomTextFormField(
              hintText: "Password",
              isPassword: true,
              controller: passwordController,
              validation: (value) {
                return Validations.isPasswordValid(passwordController.text);
              },
            ),
            0.03.height.hSpace,
            CustomTextFormField(
              hintText: "Re Password",
              isPassword: true,
              controller: confirmPasswordController,
              validation: (value) {
                return Validations.rePasswordValid(
                  passwordController.text,
                  confirmPasswordController.text,
                );
              },
            ),
            0.03.height.hSpace,
            CustomElevatedButton(
              text: "Create Account",
              onPressed: () async {
                EasyLoading.show();
                await FirebaseAuthServices.signUp(
                  context,
                  emailController.text,
                  passwordController.text,
                  nameController.text,
                  nationalIdController.text,
                );
                EasyLoading.dismiss();
                Navigator.pop(context);
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Already Have An Account ?",
                  style: theme.textTheme.titleSmall,
                ),
                CustomTextButton(
                  textColor: AppColors.newBlueColor,
                  textSize: 14,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  text: "Login",
                ),
              ],
            ),
            0.01.height.hSpace,
            DividersWord(
              text: "Or",
            ),
            0.02.height.hSpace,
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: IconButton(
                    onPressed: () =>
                        SocialAuthServices.loginWithGoogle(context),
                    style: IconButton.styleFrom(),
                    icon: Image.asset(
                      AppAssets.googleICN,
                      height: 30,
                      width: 30,
                    ),
                  ),
                ),
              ],
            ),
            0.02.height.hSpace,
          ],
        ).hPadding(0.03.width),
      ),
    );
  }
}
