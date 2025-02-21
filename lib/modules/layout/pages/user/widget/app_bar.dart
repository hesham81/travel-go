import 'package:flutter/material.dart';
import '/modules/layout/pages/user/pages/profile/pages/user_profile.dart';
import '/core/extensions/extensions.dart';
import '/core/constant/app_assets.dart';
import '/core/theme/app_colors.dart';
import '/core/utils/firebase_auth_services.dart';
import '/core/widget/loading_image_network_widget.dart';

class AppBarWidget extends StatefulWidget {
  const AppBarWidget({super.key});

  @override
  State<AppBarWidget> createState() => _AppBarWidgetState();
}

class _AppBarWidgetState extends State<AppBarWidget> {
  var user = FirebaseAuthServices.getCurrentUserData();
  @override
  Widget build(BuildContext context) {
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
          "Travel Go",
          style: theme.textTheme.titleSmall!.copyWith(
            color: AppColors.newBlueColor,
          ),
        ).hPadding(0.03.width),
        Spacer(),
        user.photoURL == null
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
          child: ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: LoadingImageNetworkWidget(
              imageUrl: user.photoURL!,
            ),
          ),
        ),
        0.01.width.vSpace,
      ],
    );
  }
}
