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
            {
              "role": "system",
              "content":
                  "Ești MyMoneyFlow, un asistent financiar virtual care ajută cu sfaturi financiare. Tu răspunzi la mesajul persoanei, iar dacă mesajul nu are legatură cu domeniul financiar nu raspunzi și vi cu un mesaj adecvat. Acesta este mesajul persoanei:"
            },
            {"role": "user", "content": message}
          ],
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(utf8.decode(response.bodyBytes));
        String content = data["choices"][0]["message"]["content"];
        return content.replaceAll('**', '');
      } else {
        return "Error: ${response.statusCode}";
      }
    } catch (e) {
      return "Failed to connect: $e";
    }
  }
}
