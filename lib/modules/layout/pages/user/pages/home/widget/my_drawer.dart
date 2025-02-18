import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '/core/constant/app_constants.dart';
import '/core/extensions/align.dart';
import '/core/extensions/extensions.dart';
import '/core/theme/app_colors.dart';
import '/core/utils/firebase_auth_services.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({super.key});

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  User currentUser = FirebaseAuthServices.getCurrentUserData();

  @override
  Widget build(BuildContext context) {
    var theme = TextTheme.of(context);
    return Container(
      width: 0.7.width,
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SafeArea(
            child: CircleAvatar(
              radius: 60,
              child: Image.network(
                currentUser.photoURL ?? AppConstants.noProfileImageUrl,
                fit: BoxFit.cover,
              ),
            ),
          ),
          0.01.height.hSpace,
          Text(
            currentUser.displayName ?? "No Name",
            style: theme.titleMedium,
          ).center,
          0.01.height.hSpace,
          Text(
            currentUser.email!,
            style: theme.titleMedium,
          ).center,
          0.05.height.hSpace,
          Divider(
            thickness: 1.1,
          ),
          0.02.height.hSpace,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.home_outlined,
              ),
              0.01.width.vSpace,
              Text(
                "Home",
                style: theme.titleMedium,
              ),
            ],
          ),

          0.02.height.hSpace,
          Divider(
            thickness: 1.1,
          ),
          0.02.height.hSpace,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.card_travel_sharp,
              ),
              0.01.width.vSpace,
              Text(
                "Bookings",
                style: theme.titleMedium,
              ),
            ],
          ),

          0.02.height.hSpace,
          Divider(
            thickness: 1.1,
          ),
          0.02.height.hSpace,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.favorite_outline,
              ),
              0.01.width.vSpace,
              Text(
                "Favourite",
                style: theme.titleMedium,
              ),
            ],
          ),
          0.02.height.hSpace,
          Divider(
            thickness: 1.1,
          ),
          0.02.height.hSpace,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.payment,
              ),
              0.01.width.vSpace,
              Text(
                "Payment Methods",
                style: theme.titleMedium,
              ),
            ],
          ),
          0.02.height.hSpace,
          Divider(
            thickness: 1.1,
          ),
          0.02.height.hSpace,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.settings,
              ),
              0.01.width.vSpace,
              Text(
                "Settings",
                style: theme.titleMedium,
              ),
            ],
          ),
          0.02.height.hSpace,
          Divider(
            thickness: 1.1,
          ),
          Spacer(),
          SafeArea(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.help_outline,
                ),
                0.01.width.vSpace,
                Text(
                  "Help",
                  style: theme.titleMedium,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
