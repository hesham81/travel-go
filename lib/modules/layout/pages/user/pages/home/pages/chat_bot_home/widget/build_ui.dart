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

      // Send the user's message to Gemini API
      gemini.prompt(
        parts: [
          Part.text(question), // Use the user's message as the prompt
        ],
      ).then((response) {
        if (response != null && response.output != null) {
          // Parse the response and update the UI
          String botResponse = response.output!;

          setState(() {
            // Add the bot's response to the messages list
            ChatMessage message = ChatMessage(
              user: chatBot,
              createdAt: DateTime.now(),
              text: botResponse,
            );
            messages = [message, ...messages];
          });
        } else {
          // Handle empty response
          print("No response from Gemini API");
        }
      }).catchError((e) {
        // Handle API errors
        print("Error: $e");
        setState(() {
          // Add an error message to the UI
          ChatMessage errorMessage = ChatMessage(
            user: chatBot,
            createdAt: DateTime.now(),
            text: "Failed to generate response. Please try again.",
          );
          messages = [errorMessage, ...messages];
        });
      });
    } catch (e) {
      // Handle any exceptions
      print("Exception: $e");
      setState(() {
        // Add an error message to the UI
        ChatMessage errorMessage = ChatMessage(
          user: chatBot,
          createdAt: DateTime.now(),
          text: "An error occurred. Please try again.",
        );
        messages = [errorMessage, ...messages];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chat with Atom"),
        backgroundColor: AppColors.newBlueColor,
      ),
      body: DashChat(
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
    );
  }
}