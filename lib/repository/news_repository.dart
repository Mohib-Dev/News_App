import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:news_app/model/categories_news_model.dart';
import 'package:news_app/model/news_channel_headlines_model.dart';

class NewRepository {
  //final http.Client? client;

  //NewRepository(this.client);

  Future<NewsChannelHeadlines> fetchNewsHeadlines(String channelName) async {
    String url =
        "https://newsapi.org/v2/top-headlines?sources=$channelName&apiKey=ab85ed543b794e99a48bbcf56b642add";

    final response = await http.get(Uri.parse(url));
    print(response.body.toString());

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);

      return NewsChannelHeadlines.fromJson(body);
    }
    throw Exception("Error");
  }

  Future<CategoriesNewsModel> fetchCategoriesNews(String category) async {
    String url =
        "https://newsapi.org/v2/everything?q=$category&apiKey=ab85ed543b794e99a48bbcf56b642add";

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body.toString());

      return CategoriesNewsModel.fromJson(data);
    }
    throw Exception("Error");
  }
}
