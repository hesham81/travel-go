import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import '/core/extensions/align.dart';
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

  bool _isLoading = false; // Track loading state

  void _sendMessage(ChatMessage chatMessage) {
    setState(() {
      messages = [chatMessage, ...messages];
      _isLoading = true; // Start loading
    });

    try {
      String question = chatMessage.text;
      gemini.prompt(
        parts: [
          Part.text(question),
        ],
      ).then((response) {
        if (response != null && response.output != null) {
          String botResponse = response.output!;

          setState(() {
            ChatMessage message = ChatMessage(
              user: chatBot,
              createdAt: DateTime.now(),
              text: botResponse,
            );
            messages = [message, ...messages];
            _isLoading = false; // Stop loading
          });
        } else {
          print("No response from Gemini API");
          setState(() {
            _isLoading = false; // Stop loading
          });
        }
      }).catchError((e) {
        print("Error: $e");
        setState(() {
          ChatMessage errorMessage = ChatMessage(
            user: chatBot,
            createdAt: DateTime.now(),
            text: "Failed to generate response. Please try again.",
          );
          messages = [errorMessage, ...messages];
          _isLoading = false; // Stop loading
        });
      });
    } catch (e) {
      print("Exception: $e");
      setState(() {
        ChatMessage errorMessage = ChatMessage(
          user: chatBot,
          createdAt: DateTime.now(),
          text: "An error occurred. Please try again.",
        );
        messages = [errorMessage, ...messages];
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Chat with Atom",
          style: theme.titleLarge!.copyWith(
            color: AppColors.whiteColor,
          ),
        ),
      ),
      body: Stack(
        children: [
          DashChat(
            currentUser: currentUser,
            onSend: _sendMessage,
            messages: messages,
            inputOptions: InputOptions(
              inputDecoration: InputDecoration(
                hintText: "Ask Atom Anything",
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(
                    color: AppColors.newBlueColor,
                  ),
                ),
                disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(
                    color: AppColors.newBlueColor,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(
                    color: AppColors.newBlueColor,
                  ),
                ),
              ),
            ),
          ),
          if (_isLoading)
            Positioned(
              bottom: 80, // Adjust position as needed
              left: 0,
              right: 0,
              child: CircularProgressIndicator(
                color: AppColors.newBlueColor,
              ).alignBottomLeft(),
            ),
        ],
      ),
    );
  }
}