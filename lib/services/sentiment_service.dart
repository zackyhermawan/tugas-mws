// import 'dart:convert';
// import '../model/sentiment_response.dart';

// class SentimentService {
//   Future<SentimentResponse> analyzeSentiment(String review) async {

//     await Future.delayed(const Duration(seconds: 1));

//     String sentiment;

//     final text = review.toLowerCase();

//     if (text.contains("bagus") ||
//         text.contains("baik") ||
//         text.contains("mantap") ||
//         text.contains("cepat")) {
//       sentiment = "Positif";
//     } else if (text.contains("buruk") ||
//         text.contains("lambat") ||
//         text.contains("error") ||
//         text.contains("jelek")) {
//       sentiment = "Negatif";
//     } else {
//       sentiment = "Netral";
//     }

//     final jsonResponse = jsonEncode({
//       "review": review,
//       "sentiment": sentiment,
//     });

//     return SentimentResponse.fromJson(jsonDecode(jsonResponse));
//   }
// }

import 'package:google_generative_ai/google_generative_ai.dart';
import '../model/sentiment_response.dart';

class SentimentService {
  final String _apiKey = "AIzaSyDEK_4iBfgCEeWUpBtqzInsoEeag-f7uBc";


  Future<SentimentResponse> analyzeSentiment(String review) async {
    try {
      final model = GenerativeModel(
        model: 'gemini-2.5-flash', 
        apiKey: _apiKey,
      );

      final prompt = "Analisis sentimen ulasan berikut. Jawab hanya dengan satu kata: Positif, Negatif, atau Netral. Ulasan: \"$review\"";
      
      final content = [Content.text(prompt)];
      final response = await model.generateContent(content);
      
      final String sentimentResult = response.text?.trim() ?? "Netral";

      return SentimentResponse(
        review: review,
        sentiment: sentimentResult,
      );
    } catch (e) {
      return SentimentResponse(
        review: review,
        sentiment: "Error: Model tidak didukung atau API Key salah.",
      );
    }
  }
}