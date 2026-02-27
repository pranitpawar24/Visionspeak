import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class GeminiService {
  static String get _apiKey =>
      dotenv.env['GEMINI_API_KEY'] ?? '';


  static const String _endpoint =
      "https://generativelanguage.googleapis.com/v1beta/models/gemini-2.5-flash:generateContent?key=$_apiKey";
  static Future<String> describeImage(File imageFile) async {
    try {
      // Convert image to base64
      final bytes = await imageFile.readAsBytes();
      final base64Image = base64Encode(bytes);

      final response = await http.post(
        Uri.parse(_endpoint),
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode({
          "contents": [
            {
              "parts": [
                {
                  "text":
                      "Describe this image clearly for a visually impaired person in one short paragraph. Be concise and accurate."
                },
                {
                  "inlineData": {
                    "mimeType": "image/jpeg",
                    "data": base64Image
                  }
                }
              ]
            }
          ]
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        if (data["candidates"] != null &&
            data["candidates"].isNotEmpty) {
          final text =
              data["candidates"][0]["content"]["parts"][0]["text"];
          return text;
        } else {
          return "I could not generate a description for this image.";
        }
      } else {
        print("Gemini ERROR STATUS: ${response.statusCode}");
        print("Gemini ERROR BODY: ${response.body}");
        return "Unable to describe the image at the moment.";
      }
    } catch (e) {
      print("Gemini EXCEPTION: $e");
      return "An error occurred while analyzing the image.";
    }
  }
}