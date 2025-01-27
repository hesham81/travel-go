import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '/core/extensions/alignment.dart';
import '/core/extensions/extensions.dart';

abstract class BotToastServices {
  static showSuccessMessage(String msg) {
    BotToast.showCustomNotification(
      toastBuilder: (builder) {
        return Container(
          width: double.maxFinite,
          height: 0.1.height,
          padding: const EdgeInsets.all(10),
          margin: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.green,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Expanded(
            child: Row(
              children: [
                Lottie.asset(
                  "assets/icons/smile.json",
                  reverse: true,
                ),
                VerticalDivider(),
                SizedBox(
                  width: 20,
                ),
                Text(
                  msg,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ).centerRightWidget(),
              ],
            ),
          ),
        ).centerTopWidget();
      },
      duration: Duration(seconds: 3),
      dismissDirections: [
        DismissDirection.endToStart,
      ],
    );
  }

  static showErrorMessage(String msg) {
    BotToast.showCustomNotification(
      toastBuilder: (builder) {
        return Container(
          width: double.maxFinite,
          height: 0.1.height,
          padding: const EdgeInsets.all(10),
          margin: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.redAccent.withAlpha(180),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Expanded(
            child: Row(
              children: [
                Lottie.asset(
                  "assets/icons/sad.json",
                  reverse: true,
                ),
                VerticalDivider(),
                SizedBox(
                  width: 20,
                ),
                Text(
                  msg,
                  style: TextStyle(
                      color: Colors.white, overflow: TextOverflow.ellipsis),
                ).centerRightWidget(),
              ],
            ),
          ),
        ).centerTopWidget();
      },
      duration: Duration(seconds: 3),
      dismissDirections: [
        DismissDirection.endToStart,
      ],
    );
  }
}
