import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import '/core/theme/app_colors.dart';

class BuildUi extends StatefulWidget {
  const BuildUi({super.key});

  @override
  State<BuildUi> createState() => _BuildUiState();
}

class _BuildUiState extends State<BuildUi> {
  final Gemini gemini = Gemini.instance;
  List<ChatMessage> messages = [];
  ChatUser currentUser = ChatUser(id: "0", firstName: "User");
  ChatUser chatBot = ChatUser(
    id: "1",
    firstName: "Atom",
    profileImage:
        "https://i.pinimg.com/474x/e6/26/19/e62619dea4058f5ea546f39e66604d01.jpg",
  );

  void _sendMessage(ChatMessage chatMessage) {
    setState(() {
      messages = [chatMessage, ...messages];
    });

    try {
      String question = chatMessage.text;
      gemini.streamGenerateContent(question).listen(
        (event) {
          String response = event.content?.parts?.fold(
                "",
                (previousValue, element) =>
                    "$previousValue${element.toString()}",
              ) ??
              "";

          setState(() {
            if (messages.isNotEmpty && messages.first.user == chatBot) {
              messages.first.text = response;
            } else {
              ChatMessage message = ChatMessage(
                user: chatBot,
                createdAt: DateTime.now(),
                text: response,
              );
              messages = [message, ...messages];
            }
          });
        },
        onError: (error) {
          print("Error: $error");
        },
      );
    } catch (e) {
      print("Exception: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return DashChat(
      currentUser: currentUser,
      onSend: _sendMessage,
      messages: messages,
      inputOptions: InputOptions(
        inputDecoration: InputDecoration(
          hintText: "Ask Atom Any Thing ",
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(
                color: AppColors.newBlueColor,
              )),
          disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(
                color: AppColors.newBlueColor,
              )),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(
              color: AppColors.newBlueColor,
            ),
          ),
        ),
      ),
    );
  }
}
