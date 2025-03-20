import 'dart:convert';
import 'package:http/http.dart' as http;
import 'ai_api_key.dart';

class AiApiService {
  static const String apiUrl = "https://api.openai.com/v1/chat/completions";

  static Future<String> sendMessage(String message) async {
    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $apiKey",
        },
        body: jsonEncode({
          "model": "gpt-4o-mini",
          "messages": [
            {"role": "system", "content": "You are a helpful assistant."},
            {"role": "user", "content": message}
          ],
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data["choices"][0]["message"]["content"];
      } else {
        return "Error: ${response.statusCode}";
      }
    } catch (e) {
      return "Failed to connect: $e";
    }
  }
}
