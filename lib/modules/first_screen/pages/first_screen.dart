import 'package:flutter/material.dart';
import '/core/constant/app_assets.dart';
import '/core/extensions/extensions.dart';
import '/core/widget/custom_elevated_button.dart';

class FirstScreen extends StatelessWidget {
  static const routeName = '/';

  const FirstScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Image.asset(
            AppAssets.firstScreenIMG,
          ),
          Spacer(),
          CustomElevatedButton(
            text: "Sign Up",
            onPressed: () {},
            padding: EdgeInsets.symmetric(
              horizontal: 0.02.height,
            ),
          ).hPadding(0.07.width),
          0.2.hSpace,
          SafeArea(
            child: CustomElevatedButton(
              text: "Sign in",
              onPressed: () {},
              padding: EdgeInsets.symmetric(
                horizontal: 0.02.height,
              ),
            ).hPadding(0.07.width),
          ),
          0.18.hSpace,
        ],
      ),
    );
  }
}
