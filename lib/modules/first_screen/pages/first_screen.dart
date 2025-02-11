import 'package:flutter/material.dart';
import 'package:travel_go/modules/sign_up/pages/sign_up.dart';
import '/modules/sign_in/pages/sign_in.dart';
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
          SizedBox(
            height: 0.064.height,
            child: CustomElevatedButton(
              text: "Sign Up",
              textSize: 30,
              onPressed: () {
                Navigator.pushNamed(context, SignUp.routeName);
              },
              padding: EdgeInsets.symmetric(
                horizontal: 0.008.width,
                vertical: 0.001.height,
              ),
            ).hPadding(0.07.width),
          ),
          0.05.height.hSpace,
          SizedBox(
            height: 0.064.height,
            child: CustomElevatedButton(
              text: "Sign in",
              textSize: 30,
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  SignIn.routeName,
                );
              },
              padding: EdgeInsets.symmetric(
                horizontal: 0.008.width,
                vertical: 0.001.height,
              ),
            ).hPadding(0.07.width),
          ),
          0.08.height.hSpace,
        ],
      ),
    );
  }
}
