import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import '/core/utils/firebase_auth_services.dart';
import '/modules/sign_in/pages/sign_in.dart';
import '/core/widget/loading_image_network_widget.dart';
import '/core/extensions/extensions.dart';
import '/core/theme/app_colors.dart';
import '/core/constant/app_assets.dart';

class UserProfile extends StatelessWidget {
  static const routeName = '/user-profile';

  const UserProfile({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    final user = ModalRoute.of(context)?.settings.arguments as User;
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                Image.asset(
                  AppAssets.logo,
                  height: 60,
                  width: 60,
                  fit: BoxFit.cover,
                ),
                Text(
                  "Tour And Travel",
                  style: theme.textTheme.titleSmall!.copyWith(
                    color: AppColors.newBlueColor,
                  ),
                ).hPadding(0.03.width),
                Spacer(),
                IconButton(
                  onPressed: () async {
                    EasyLoading.show();
                    await FirebaseAuthServices.logout();
                    EasyLoading.dismiss();
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      SignIn.routeName,
                      (route) => false,
                    );
                  },
                  icon: Icon(
                    Icons.logout,
                    color: AppColors.errorColor,
                  ),
                )
              ],
            ),
            0.03.height.hSpace,
            user.photoURL == null
                ? GestureDetector(
                    child: Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(
                            AppAssets.noProfileImage,
                          ),
                        ),
                        shape: BoxShape.circle,
                      ),
                      height: 120,
                      width: 120,
                    ),
                  )
                : CircleAvatar(
                  radius: 80,
                  backgroundImage: NetworkImage(
                    user.photoURL!,
                  ),
                ).allPadding(10),
            0.01.height.hSpace,
            Text(
              user.displayName!,
              style: theme.textTheme.titleLarge!.copyWith(
                color: AppColors.blackColor,
              ),
            ),
            0.01.height.hSpace,
            Text(
              user.email!,
              style: theme.textTheme.titleSmall!.copyWith(
                color: AppColors.newBlueColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
