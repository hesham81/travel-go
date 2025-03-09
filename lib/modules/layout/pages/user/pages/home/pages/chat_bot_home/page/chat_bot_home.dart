import 'package:flutter/material.dart';
import '/modules/layout/pages/user/pages/home/pages/chat_bot_home/widget/build_ui.dart';

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
      body: Scaffold(
        backgroundColor: Colors.transparent,
        body: BuildUi(),
      ),
    );
  }
}
