import 'package:news_app/model/news_channel_headlines_model.dart';
import 'package:news_app/repository/news_repository.dart';

class NewsViewModel {
  final repo = NewRepository();

  Future<NewsChannelHeadlines> fetchNewsHeadlines() async {
    final response = await repo.fetchNewsHeadlines();
    return response;
  }
}
