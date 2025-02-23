import 'package:flutter/material.dart';
import '/modules/layout/pages/user/pages/home/pages/chat_bot_home/widget/build_ui.dart';
import '/core/extensions/extensions.dart';
import '/core/widget/custom_text_form_field.dart';
import '/modules/layout/pages/user/pages/home/pages/chat_bot_home/widget/message.dart';
import '/core/theme/app_colors.dart';
import '/modules/layout/pages/user/widget/app_bar.dart';

class ChatBotHome extends StatefulWidget {
  const ChatBotHome({super.key});

  @override
  State<ChatBotHome> createState() => _ChatBotHomeState();
}

class _ChatBotHomeState extends State<ChatBotHome> {
  List<String> request = [
    "Hi",
  ];
  List<String> response = [];
  TextEditingController messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      // body: SingleChildScrollView(
      //   child: SafeArea(
      //     child: Column(
      //       children: [
      //         AppBarWidget(),
      //         Container(
      //           width: double.maxFinite,
      //           height: 0.05.height,
      //           alignment: Alignment.center,
      //           decoration: BoxDecoration(
      //             color: AppColors.newBlueColor,
      //           ),
      //           child: Text(
      //             "Chat Bot",
      //             style: theme.textTheme.titleLarge!.copyWith(
      //               color: AppColors.whiteColor,
      //             ),
      //           ),
      //         ),
      //         0.01.height.hSpace,
      //         Column(
      //           children: [
      //             Message(
      //               message: "How Can I Help You ?",
      //               isSender: true,
      //             ),
      //             0.62.height.hSpace,
      //             CustomTextFormField(
      //               hintText: "Write Any Thing ",
      //               suffixIcon: Icons.send,
      //               controller: messageController,
      //             ),
      //           ],
      //         ).hPadding(0.03.width)
      //       ],
      //     ),
      //   ),
      // ),
      body: Scaffold(
        backgroundColor: Colors.transparent,
        body: BuildUi(),
      ),
    );
  }
}
