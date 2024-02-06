import 'package:news_app/model/categories_news_model.dart';
import 'package:news_app/model/news_channel_headlines_model.dart';
import 'package:news_app/repository/news_repository.dart';

class NewsViewModel {
  final repo = NewRepository();

  Future<NewsChannelHeadlines> fetchNewsHeadlines(String channelName) async {
    final response = await repo.fetchNewsHeadlines(channelName);
    print(response.articles![0].author);
    return response;
  }

  Future<CategoriesNewsModel> fetchCategoriesNews(String category) async {
    final response = await repo.fetchCategoriesNews(category);
    print(response.totalResults.toString());
    return response;
  }
}
