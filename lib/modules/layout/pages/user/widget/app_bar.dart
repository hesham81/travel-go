import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/core/providers/trip_admin_provider.dart';
import '/modules/layout/pages/user/pages/profile/pages/user_profile.dart';
import '/core/extensions/extensions.dart';
import '/core/constant/app_assets.dart';
import '/core/theme/app_colors.dart';
import '/core/utils/firebase_auth_services.dart';

class AppBarWidget extends StatefulWidget {
  const AppBarWidget({super.key});

  @override
  State<AppBarWidget> createState() => _AppBarWidgetState();
}

class _AppBarWidgetState extends State<AppBarWidget> {
  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuthServices.getCurrentUserData();
    var theme = Theme.of(context);
    return Row(
      children: [
        Image.asset(
          AppAssets.logo,
          height: 60,
          width: 60,
          fit: BoxFit.cover,
        ),
        Text(
          "Travel System ",
          style: theme.textTheme.titleMedium!.copyWith(
            color: AppColors.newBlueColor,
            fontWeight: FontWeight.bold,
          ),
        ).hPadding(0.03.width),
        Spacer(),
        user?.photoURL == null
            ? GestureDetector(
                onTap: () => Navigator.pushNamed(
                  context,
                  UserProfile.routeName,
                  arguments: user,
                ),
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                        AppAssets.noProfileImage,
                      ),
                    ),
                    shape: BoxShape.circle,
                  ),
                  height: 70,
                  width: 70,
                ),
              )
            : GestureDetector(
                onTap: () => Navigator.pushNamed(
                  context,
                  UserProfile.routeName,
                  arguments: user,
                ),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: AppColors.newBlueColor,
                      width: 4,
                    ),
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: CircleAvatar(
                    radius: 30,
                    backgroundImage: CachedNetworkImageProvider(
                      user!.photoURL!,
                    ),
                  ),
                ).allPadding(10),
              ),
        0.01.width.vSpace,
      ],
    );
  }
}
