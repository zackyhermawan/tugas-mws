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

import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/sentiment_response.dart';

class SentimentService {
  final String _baseUrl = "http://localhost:3000/api/sentiment"; 

  Future<SentimentResponse> analyzeSentiment(String review) async {
    final response = await http.post(
      Uri.parse(_baseUrl),
      headers: {
        "Content-Type": "application/json"
      },
      body: jsonEncode({
        "review": review
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return SentimentResponse.fromJson(data);
    } else {
      return SentimentResponse(
        review: review,
        sentiment: "Error"
      );
    }
  }
}
