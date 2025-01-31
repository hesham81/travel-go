import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:travel_go/core/extensions/align.dart';
import 'package:travel_go/core/extensions/extensions.dart';
import 'package:travel_go/core/utils/firebase_services.dart';
import 'package:travel_go/modules/sign_in/pages/sign_in.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/validations/validations.dart';
import '../../../core/widget/back_leading_widget.dart';
import '../../../core/widget/custom_elevated_button.dart';
import '../../../core/widget/custom_text_form_field.dart';
import '../../../core/widget/label.dart';

class NewPassword extends StatefulWidget {
  static const routeName = '/new-password';

  const NewPassword({super.key});

  @override
  State<NewPassword> createState() => _NewPasswordState();
}

class _NewPasswordState extends State<NewPassword> {
  var formKey = GlobalKey<FormState>();
  var passwordController = TextEditingController();
  var confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Form(
        autovalidateMode: AutovalidateMode.onUnfocus,
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            0.18.height.hSpace,
            Text(
              "New Password",
              style: TextStyle(
                fontSize: 35,
                fontWeight: FontWeight.w700,
                color: AppColors.azureBlueColor,
              ),
            ).center.center,
            0.1.height.hSpace,
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
                      text: 'Password',
                    ).hPadding(0.04.width),
                    0.01.height.hSpace,
                    CustomTextFormField(
                      isPassword: true,
                      controller: passwordController,
                      hintText: 'Password',
                      validation: (value) {
                        return Validations.isPasswordValid(
                          passwordController.text,
                        );
                      },
                    ),
                    0.04.height.hSpace,
                    Label(
                      text: 'confirm Password',
                    ).hPadding(0.04.width),
                    0.01.height.hSpace,
                    CustomTextFormField(
                        hintText: "confirm Password",
                        isPassword: true,
                        controller: confirmPasswordController,
                        validation: (value) {
                          return Validations.rePasswordValid(
                            passwordController.text,
                            confirmPasswordController.text,
                          );
                        }),
                    0.04.height.hSpace,
                    SizedBox(
                      height: 0.06.height,
                      child: CustomElevatedButton(
                        textSize: 30,
                        text: "          Submit          ",
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            Navigator.pushNamedAndRemoveUntil(
                              context,
                              SignIn.routeName,
                              (_) => false,
                            );
                          }
                        },
                        borderRadius: 20,
                        padding: EdgeInsets.symmetric(
                          horizontal: 0.02.height,
                          vertical: 0,
                        ),
                      ).center,
                    ),
                  ],
                ).hPadding(0.08.width),
              ),
            )
          ],
        ),
      ),
    );
  }
}
