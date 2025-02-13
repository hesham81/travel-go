import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import '/core/utils/social_auth_services.dart';
import '/modules/layout/pages/admin/pages/admin_home.dart';
import '/core/services/bot_toast.dart';
import '/core/validations/validations.dart';
import '/modules/forget_password/pages/forget_password.dart';
import '/modules/layout/pages/user/pages/home/pages/home.dart';
import '../../../core/utils/firebase_auth_services.dart';
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
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Form(
        autovalidateMode: AutovalidateMode.onUnfocus,
        key: formKey,
        child: Column(
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
                      validation: (value) {
                        return Validations.isEmailValid(emailController.text);
                      },
                      controller: emailController,
                    ),
                    0.02.height.hSpace,
                    Label(
                      text: 'Password',
                    ).hPadding(0.04.width),
                    0.01.height.hSpace,
                    CustomTextFormField(
                        hintText: "Password",
                        isPassword: true,
                        controller: passwordController,
                        validation: (value) {
                          return Validations.isPasswordValid(
                              passwordController.text);
                        }),
                    CustomTextButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(
                            context, ForgetPassword.routeName);
                      },
                      text: 'Forgot Password?',
                    ).alignRight(),
                    0.01.height.hSpace,
                    SizedBox(
                      height: 0.06.height,
                      child: CustomElevatedButton(
                        textSize: 30,
                        text: "          Sign in          ",
                        onPressed: () async {
                          if (formKey.currentState!.validate()) {
                            EasyLoading.show(status: "Loading...");
                            var role = await FirebaseAuthServices.signIn(
                              emailController.text,
                              passwordController.text,
                            );
                            EasyLoading.dismiss();
                            if (role != null) {
                              BotToastServices.showSuccessMessage(
                                "Sign In Successfully",
                              );
                              (role == 'admin')
                                  ? Navigator.pushNamedAndRemoveUntil(
                                      context,
                                      AdminHome.routeName,
                                      (route) => false,
                                    )
                                  : Navigator.pushNamedAndRemoveUntil(
                                      context,
                                      Home.routeName,
                                      (route) => false,
                                    );
                            } else {
                              BotToastServices.showErrorMessage(
                                "Invalid Credentials",
                              );
                            }
                          }
                        },
                        borderRadius: 20,
                        padding: EdgeInsets.symmetric(
                          horizontal: 0.02.height,
                          vertical: 0,
                        ),
                      ).center,
                    ),
                    0.02.height.hSpace,
                    DividersWord(text: "or sign in with"),
                    0.02.height.hSpace,
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: SocialMediaLogin(
                              onTap: (){
                                SocialAuthServices.loginWithGoogle(context);

                              },
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
      ),
    );
  }
}
