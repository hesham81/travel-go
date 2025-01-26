import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '/core/extensions/extensions.dart';
import '/core/constant/app_assets.dart';
import '/core/theme/app_colors.dart';

abstract class BotToastServices {
  static void showSuccessMessage(String message) {
    BotToast.showCustomNotification(
      toastBuilder: (context) {
        return Container(
          alignment: Alignment.topCenter,
          width: double.maxFinite,
          height: 180,
          decoration: BoxDecoration(
            color: AppColors.successColor,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Expanded(
            child: Row(
              children: [
                Lottie.asset(
                  AppAssets.smaileSucessLottieFile,
                ),
                15.vSpace,
                VerticalDivider(
                  thickness: 1,
                  color: AppColors.errorColor,
                ),
                Text(
                  "Account Created Succefully",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ).vPadding(0.3.height).hPadding(0.3.width),
          ),
        ).hPadding(0.01.height).vPadding(0.03.width);
      },
      duration: Duration(seconds: 4),
      dismissDirections: [DismissDirection.endToStart],
    );
  }

  static void showErrorMessage(String message) {
    BotToast.showCustomNotification(
      toastBuilder: (context) {
        return Container(
          alignment: Alignment.topCenter,
          width: double.maxFinite,
          height: 180,
          decoration: BoxDecoration(
            color: AppColors.errorColor,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            children: [
              Lottie.asset(
                AppAssets.smaileSucessLottieFile,
              ),
              15.vSpace,
              VerticalDivider(
                thickness: 1,
                color: AppColors.errorColor,
              ),
              Text(
                message,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ).vPadding(0.3.height).hPadding(0.3.width),
        );
      },
      duration: Duration(seconds: 4),
      dismissDirections: [DismissDirection.endToStart],
    );
  }
}
