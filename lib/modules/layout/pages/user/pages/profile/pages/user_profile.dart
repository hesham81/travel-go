import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import '/core/constant/local_storage.dart';
import '/core/constant/shared_preferences_keys.dart';
import '/core/routes/route_names.dart';
import '/core/utils/firebase_auth_services.dart';
import '/core/widget/custom_elevated_button.dart';
import '/modules/layout/pages/user/pages/profile/widget/choose_profile_index.dart';
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
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  Row(
                    children: [
                      IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: Icon(
                          Icons.arrow_back_ios,
                          color: AppColors.blackColor,
                        ),
                      ),
                      Text(
                        "Profile",
                        style: theme.textTheme.titleMedium!.copyWith(
                            color: AppColors.blackColor,
                            fontWeight: FontWeight.w800,
                            fontStyle: FontStyle.normal),
                      ),
                    ],
                  ),
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
                      backgroundImage: CachedNetworkImageProvider(
                        user.photoURL!,
                        cacheKey: user.uid,
                        errorListener: (p0) =>
                            Image.asset(AppAssets.noProfileImage),
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
                  color: AppColors.blackColor.withAlpha(130),
                ),
              ),
              0.05.height.hSpace,
              Column(
                children: [
                  ChooseProfileIndex(
                    icon: Icons.person,
                    title: "Edit Profile",
                    button: IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.arrow_forward_ios,
                        color: AppColors.blackColor,
                      ),
                    ),
                  ),
                  0.01.height.hSpace,
                  ChooseProfileIndex(
                    icon: Icons.person_4_sharp,
                    title: "Friends",
                    button: IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.arrow_forward_ios,
                        color: AppColors.blackColor,
                      ),
                    ),
                  ),
                  0.01.height.hSpace,
                  ChooseProfileIndex(
                    icon: Icons.wallet,
                    title: "Payment Methods",
                    button: IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.arrow_forward_ios,
                        color: AppColors.blackColor,
                      ),
                    ),
                  ),
                  0.01.height.hSpace,
                  ChooseProfileIndex(
                    icon: Icons.credit_card_outlined,
                    title: "Reservations",
                    button: IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.arrow_forward_ios,
                        color: AppColors.blackColor,
                      ),
                    ),
                  ),
                  0.01.height.hSpace,
                  ChooseProfileIndex(
                    icon: Icons.location_on_outlined,
                    title: "Locations",
                    button: IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.arrow_forward_ios,
                        color: AppColors.blackColor,
                      ),
                    ),
                  ),
                  0.01.height.hSpace,
                  ChooseProfileIndex(
                    icon: Icons.settings,
                    title: "Settings",
                    button: IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.arrow_forward_ios,
                        color: AppColors.blackColor,
                      ),
                    ),
                  ),
                  0.01.height.hSpace,
                  ChooseProfileIndex(
                    icon: Icons.help,
                    title: "Help",
                    button: IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.arrow_forward_ios,
                        color: AppColors.blackColor,
                      ),
                    ),
                  ),
                  0.01.height.hSpace,
                  SizedBox(
                    width: double.maxFinite,
                    child: CustomElevatedButton(
                      text: "LogOut",
                      onPressed: () async {
                        EasyLoading.show();
                        await FirebaseAuthServices.logout().then(
                          (value) {
                            Navigator.pushNamedAndRemoveUntil(
                              context,
                              RouteNames.signIn,
                              (route) => false,
                            );
                            LocalStorageData.remove(SharedPreferencesKey.login);
                            EasyLoading.dismiss();
                          },
                        );
                      },
                      btnColor: AppColors.errorColor,
                    ),
                  ),
                  0.03.height.hSpace,
                ],
              ).hPadding(0.05.width)
            ],
          ),
        ),
      ),
    );
  }
}
