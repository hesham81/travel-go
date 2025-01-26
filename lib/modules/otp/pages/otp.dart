import 'package:flutter/material.dart';
import 'package:travel_go/core/extensions/extensions.dart';
import 'package:travel_go/core/widget/label.dart';
import 'package:travel_go/modules/layout/pages/user/pages/home.dart';
import 'package:travel_go/modules/otp/widget/otp_form_widget.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/widget/custom_elevated_button.dart';

class Otp extends StatelessWidget {
  static const routeName = '/otp';
  var controller1 = TextEditingController();
  var controller2 = TextEditingController();
  var controller3 = TextEditingController();
  var controller4 = TextEditingController();
  var controller5 = TextEditingController();
  var controller6 = TextEditingController();
  var formKey = GlobalKey<FormState>();

  Otp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          0.03.height.vSpace,
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Label(text: "Verification Code"),
              0.02.height.vSpace,
              Label(
                text:
                    "We have sent the verification \ncode to your email address",
                textColor: AppColors.dodgurBlueColor,
                textSize: 18,
                textWeight: FontWeight.w500,
              ),
            ],
          ).hPadding(0.08.width),
          0.08.height.vSpace,
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
          0.08.height.vSpace,
          CustomElevatedButton(
            onPressed: () {
              if (formKey.currentState!.validate()) {
                Navigator.pushNamed(
                  context,
                  Home.routeName,
                );
              }
            },
            text: "Confirm",
            padding: EdgeInsets.symmetric(
              horizontal: 0.2.width,
              vertical: 0.01.height,
            ),
            textWeight: FontWeight.w500,
            textSize: 32,
          ),
        ],
      ),
    );
  }
}
