import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:travel_go/core/constant/app_assets.dart';
import '/core/services/bot_toast.dart';
import '/core/utils/email_services.dart';
import '/modules/new_password/pages/new_password.dart';
import '/core/extensions/extensions.dart';
import '/core/widget/label.dart';
import '/modules/otp/widget/otp_form_widget.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widget/custom_elevated_button.dart';

class Otp extends StatefulWidget {
  static const routeName = '/otp';

  Otp({super.key});

  @override
  State<Otp> createState() => _OtpState();
}

class _OtpState extends State<Otp> {
  var controller1 = TextEditingController();

  var controller2 = TextEditingController();

  var controller3 = TextEditingController();

  var controller4 = TextEditingController();

  var controller5 = TextEditingController();

  var controller6 = TextEditingController();

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          "Verification Code",
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
        physics: BouncingScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            0.03.height.hSpace,
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Image.asset(
                  AppAssets.otpImage,
                ),
                0.02.height.hSpace,
                Label(
                  text:
                      "We have sent the verification \ncode to your email address",
                  textColor: AppColors.blackColor,
                  textSize: 18,
                  textWeight: FontWeight.w500,
                ),
              ],
            ).hPadding(0.08.width),
            0.08.height.hSpace,
            Form(
              key: formKey,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  OtpFormWidget(
                    controller: controller1,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "";
                      }
                      return null;
                    },
                  ),
                  OtpFormWidget(
                    controller: controller2,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "";
                      }
                      return null;
                    },
                  ),
                  OtpFormWidget(
                    controller: controller3,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "";
                      }
                      return null;
                    },
                  ),
                  OtpFormWidget(
                    controller: controller4,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "";
                      }
                      return null;
                    },
                  ),
                  OtpFormWidget(
                    controller: controller5,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "";
                      }
                      return null;
                    },
                  ),
                  OtpFormWidget(
                    controller: controller6,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "";
                      }
                      return null;
                    },
                  ),
                ],
              ).hPadding(0.03.width),
            ),
            0.08.height.hSpace,
            CustomElevatedButton(
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  EasyLoading.show();
                  String otpCode =
                      "${controller1.text}${controller2.text}${controller3.text}${controller4.text}${controller5.text}${controller6.text}";
                  var result = EmailServices.verifyOTP(otpCode);
                  EasyLoading.dismiss();
                  if (result == true) {
                    Navigator.pushNamedAndRemoveUntil(
                        context, NewPassword.routeName, (_) => false);
                  }
                } else {
                  BotToastServices.showErrorMessage("Otp is not valid");
                  Navigator.pop(context);
                }
              },
              text: "Confirm",
              borderRadius: 12,
              padding: EdgeInsets.symmetric(
                horizontal: 0.02.height,
                vertical: 0,
              ),
              textWeight: FontWeight.w500,
              textSize: 32,
            ),
          ],
        ).hPadding(0.03.width),
      ),
    );
  }
}
