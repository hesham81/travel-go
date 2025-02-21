import 'package:flutter/material.dart';
import '/core/extensions/alignment.dart';
import '/core/routes/route_names.dart';
import '/core/validations/validations.dart';
import '/core/constant/app_assets.dart';
import '/core/extensions/extensions.dart';
import '/core/theme/app_colors.dart';
import '/core/widget/custom_elevated_button.dart';
import '/core/widget/custom_text_button.dart';
import '/core/widget/custom_text_form_field.dart';
import '/core/widget/dividers_word.dart';
import '/core/widget/social_media_login.dart';

class SignIn extends StatefulWidget {
  static const routeName = '/sign-in';

  SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  var formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      resizeToAvoidBottomInset: false,
      body: Form(
        autovalidateMode: AutovalidateMode.onUnfocus,
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/images/logo2.jpg",
            ),
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
            CustomTextButton(
              onPressed: () {},
              text: "Forget Password",
            ).rightBottomWidget(),
            CustomElevatedButton(
              text: "Login",
              onPressed: () {
                if (formKey.currentState!.validate()) {}
              },
              borderRadius: 10,
              btnColor: Colors.lightBlue,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Don't Have An Account ? ",
                  style: theme.textTheme.titleSmall,
                ),
                0.01.width.vSpace,
                CustomTextButton(
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      RouteNames.signUp,
                    );
                  },
                  text: "Create Account",
                ),
              ],
            ),
            DividersWord(
              text: "Or Sign in With",
            ),
            0.02.height.hSpace,
            Row(
              children: [
                Expanded(
                  child: SocialMediaLogin(
                    text: "Login With Google",
                    imagePath: AppAssets.googleICN,
                    onTap: () {},
                  ),
                ),
              ],
            ),
            0.1.height.hSpace,
          ],
        ).hPadding(0.03.width),
      ),
    );
  }
}
