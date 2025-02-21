import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:travel_go/core/utils/social_auth_services.dart';
import '/core/constant/app_assets.dart';
import '/core/services/bot_toast.dart';
import '/core/utils/firebase_auth_services.dart';
import '/core/widget/custom_elevated_button.dart';
import '/core/widget/custom_text_button.dart';
import '/core/widget/custom_text_form_field.dart';
import '/core/widget/dividers_word.dart';
import '/modules/first_screen/widget/check_widget.dart';
import '../../../core/validations/validations.dart';
import '../../../core/widget/label.dart';
import '../../sign_in/pages/sign_in.dart';
import '/core/extensions/extensions.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widget/back_leading_widget.dart';

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
  var key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      // body: SafeArea(
      //   bottom: false,
      //   child: Column(
      //     children: [
      //       Row(
      //         children: [
      //           BackLeadingWidget(),
      //           0.035.width.vSpace,
      //           Text(
      //             "Sign Up",
      //             style: TextStyle(
      //               fontSize: 48,
      //               fontWeight: FontWeight.w700,
      //               color: AppColors.azureBlueColor,
      //             ),
      //           ),
      //         ],
      //       ),
      //       CustomTextButton(
      //         onPressed: () {
      //           Navigator.pushNamed(context, SignIn.routeName);
      //         },
      //         text: "Already have an account? log in",
      //         textColor: AppColors.blackColor,
      //         textWeight: FontWeight.w500,
      //         textSize: 16,
      //       ),
      //       0.05.height.hSpace,
      //       Expanded(
      //         child: Container(
      //           decoration: BoxDecoration(
      //             color: AppColors.whiteColor,
      //             borderRadius: BorderRadius.only(
      //               topLeft: Radius.circular(30),
      //               topRight: Radius.circular(30),
      //             ),
      //           ),
      //           child: SingleChildScrollView(
      //             physics: BouncingScrollPhysics(),
      //             child: Form(
      //               key: key,
      //               child: Column(
      //                 crossAxisAlignment: CrossAxisAlignment.stretch,
      //                 children: [
      //                   Label(
      //                     text: 'Full Name',
      //                   ).hPadding(0.03.width),
      //                   0.01.height.hSpace,
      //                   CustomTextFormField(
      //                     hintText: "Enter Full Name",
      //                     controller: nameController,
      //                     validation: (value) {
      //                       return Validations.isNameValid(nameController.text);
      //                     },
      //                   ),
      //                   0.02.height.hSpace,
      //                   Label(
      //                     text: 'Email',
      //                   ).hPadding(0.03.width),
      //                   0.01.height.hSpace,
      //                   CustomTextFormField(
      //                     hintText: "Enter Email",
      //                     controller: emailController,
      //                     validation: (value) {
      //                       return Validations.isEmailValid(
      //                         emailController.text,
      //                       );
      //                     },
      //                   ),
      //                   0.02.height.hSpace,
      //                   Label(
      //                     text: 'Password',
      //                   ).hPadding(0.03.width),
      //                   0.01.height.hSpace,
      //                   CustomTextFormField(
      //                     hintText: "Enter Password",
      //                     isPassword: true,
      //                     controller: passwordController,
      //                     validation: (value) {
      //                       return Validations.isPasswordValid(
      //                           passwordController.text);
      //                     },
      //                   ),
      //                   0.02.height.hSpace,
      //                   Label(
      //                     text: 'Confirm Password',
      //                   ).hPadding(0.03.width),
      //                   0.01.height.hSpace,
      //                   CustomTextFormField(
      //                     hintText: "Confirm Password",
      //                     isPassword: true,
      //                     controller: confirmPasswordController,
      //                     validation: (value) {
      //                       return Validations.rePasswordValid(
      //                         confirmPasswordController.text,
      //                         passwordController.text,
      //                       );
      //                     },
      //                   ),
      //                   0.005.height.hSpace,
      //                   CheckWidget(),
      //                   0.02.height.hSpace,
      //                   SizedBox(
      //                     height: 0.06.height,
      //                     child: CustomElevatedButton(
      //                       textSize: 30,
      //                       text: "Sign Up",
      //                       onPressed: () async {
      //                         if (key.currentState!.validate()) {
      //                           EasyLoading.show();
      //                           var user = await FirebaseAuthServices.signUp(
      //                             emailController.text,
      //                             passwordController.text,
      //                             nameController.text,
      //                           );
      //                           EasyLoading.dismiss();
      //                           if (user != null) {
      //                             BotToastServices.showSuccessMessage(
      //                               "Sign Up Successfully",
      //                             );
      //                           } else {
      //                             BotToastServices.showErrorMessage("Error");
      //                           }
      //                         }
      //                         //   SuperPassword1!
      //                       },
      //                       borderRadius: 20,
      //                       padding: EdgeInsets.symmetric(
      //                         horizontal: 0.02.height,
      //                         vertical: 0,
      //                       ),
      //                     ),
      //                   ),
      //                   0.02.height.hSpace,
      //                   DividersWord(text: ' or sign up with'),
      //                   0.02.height.hSpace,
      //                   Row(
      //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //                     crossAxisAlignment: CrossAxisAlignment.center,
      //                     children: [
      //                       GestureDetector(
      //                         onTap: (){
      //                           SocialAuthServices.loginWithGoogle(context);
      //                         },
      //                         child: Image.asset(
      //                           AppAssets.googleICN,
      //                           height: 35,
      //                           width: 35,
      //                         ),
      //                       ),
      //                       Image.asset(
      //                         AppAssets.twitterICN,
      //                         height: 35,
      //                         width: 35,
      //                       ),
      //                       Image.asset(
      //                         AppAssets.facebookICN,
      //                         height: 35,
      //                         width: 35,
      //                       ),
      //                     ],
      //                   ).hPadding(0.08.width)
      //                 ],
      //               ).hPadding(0.07.width).vPadding(0.02.height),
      //             ),
      //           ),
      //         ),
      //       ),
      //     ],
      //   ),
      // ),
    );
  }
}
