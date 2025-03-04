import 'package:dio/dio.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import '/core/constant/ai_constant.dart';
import '/core/services/bot_toast.dart';

abstract class ChatBotApi {
  static final Dio dio = Dio();

  static Future<String?> data(context) async {
    final dio = Dio();
    final apiKey = AiConstants.chatBotApiKey;
    final url =
        'https://generativelanguage.googleapis.com/v1/models/gemini-pro:generateContent?key=$apiKey';

    try {
      final response = await dio.post(
        url,
        options: Options(headers: {'Content-Type': 'application/json'}),
        data: {
          "contents": [
            {
              "role": "user",
              "parts": [
                {"text": "Hello, how are you?"}
              ]
            }
          ]
        },
      );
      final message =
          response.data['candidates'][0]['content']['parts'][0]['text'];
      return message;
    } catch (e) {
      if (e is DioException) {
        BotToastServices.showErrorMessage(e.response!.data['error']['message']);
        return null;
      } else {
        BotToastServices.showErrorMessage("Error");
        return null;
      }
    }
  }
  static ChatBot()
  {
    Gemini.instance.promptStream(parts: [
      Part.text('Write a story about a magic backpack'),
    ]).listen((value) {
      print(value?.output);
    });
  }
}
