import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:news_app/model/news_channel_headlines_model.dart';

class NewRepository {
  Future<NewsChannelHeadlines> fetchNewsHeadlines() async {
    String url =
        "https://newsapi.org/v2/top-headlines?country=us&apiKey=ab85ed543b794e99a48bbcf56b642add";

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body.toString());

      return NewsChannelHeadlines.fromJson(body);
    }
    throw Exception("Error");
  }
}
