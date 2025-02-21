import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import '/core/utils/email_services.dart';
import '/core/constant/app_assets.dart';
import '/core/extensions/extensions.dart';
import '/core/theme/app_colors.dart';
import '/core/widget/custom_elevated_button.dart';
import '/core/widget/custom_text_form_field.dart';
import '/core/widget/label.dart';
import '/modules/otp/pages/otp.dart';

import '../../../core/validations/validations.dart';

class ForgetPassword extends StatefulWidget {
  static const routeName = '/forget-password';

  ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  var emailController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        title: Text(
          "Forget Password",
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
      body: Expanded(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image.asset(
                AppAssets.forgetPassword,
              ),
              0.07.height.hSpace,
              Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Label(
                      text:
                          "Enter email and phone number to \nsend one time Password",
                      textColor: AppColors.blackColor,
                      textWeight: FontWeight.w500,
                    ),
                    0.04.height.hSpace,
                    CustomTextFormField(
                      hintText: "Email",
                      suffixIcon: Icons.email_outlined,
                      controller: emailController,
                      validation: (value) {
                        return Validations.isEmailValid(emailController.text);
                      },
                    ),
                    0.04.height.hSpace,
                    SizedBox(
                      height: 0.057.height,
                      child: CustomElevatedButton(
                        text: "Continue",
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            EasyLoading.show();
                            EmailServices.init();
                            EmailServices.sendOTP(emailController.text);
                            EasyLoading.dismiss();

                            Navigator.pushNamed(context, Otp.routeName);
                          }
                        },
                        borderRadius: 20,
                        padding: EdgeInsets.symmetric(
                          horizontal: 0.02.height,
                          vertical: 0,
                        ),
                        textWeight: FontWeight.w600,
                        textSize: 28,
                      ),
                    ),
                  ],
                ).hPadding(0.08.width),
              )
            ],
          ),
        ),
      ),
    );
  }
}
