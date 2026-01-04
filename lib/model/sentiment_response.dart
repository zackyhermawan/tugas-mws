class SentimentResponse {
  final String review;
  final String sentiment;

  SentimentResponse({
    required this.review,
    required this.sentiment,
  });

  factory SentimentResponse.fromJson(Map<String, dynamic> json) {
    return SentimentResponse(
      review: json['review'],
      sentiment: json['sentiment'],
    );
  }
}
