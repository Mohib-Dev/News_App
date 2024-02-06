import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:news_app/model/categories_news_model.dart';
import 'package:news_app/model/news_channel_headlines_model.dart';
import 'package:news_app/repository/news_repository.dart';

class MockClient extends Mock implements http.Client {}

void main() {
  group('NewRepository Tests', () {
    late NewRepository repository;
    late MockClient mockClient;

    setUp(() {
      mockClient = MockClient();
      repository = NewRepository();
    });

    group("News Repository Tests", () {
      test('Returns News Headlines', () async {
        final headlines = await repository.fetchNewsHeadlines("bbc-news");
        expect(headlines, isA<NewsChannelHeadlines>());
      });

      test('Returns News Categories', () async {
        final categoryNews = await repository.fetchCategoriesNews("General");
        expect(categoryNews, isA<CategoriesNewsModel>());
      });
    });
    test('Throws Exception on Invalid Channel Name', () async {
      expect(() => repository.fetchNewsHeadlines(""), throwsException);
    });

    test('Throws Exception on Invalid Category', () async {
      expect(() => repository.fetchCategoriesNews(""), throwsException);
    });

    test('Throws Exception on Invalid API Key', () async {
      when(mockClient.get(Uri.parse(
              "https://newsapi.org/v2/top-headlines?sources=bbc-news&apiKey=ab85ed543b794e99a48bbcf56b642add")))
          .thenAnswer((_) async => http.Response('Unauthorized', 401));

      final repositoryWithMockClient = NewRepository();
      expect(() => repositoryWithMockClient.fetchNewsHeadlines("bbc-news"),
          throwsException);
    });

    test('Throws Exception on Server Error', () async {
      when(mockClient.get(Uri.parse(
              "https://newsapi.org/v2/top-headlines?sources=bbc-news&apiKey=ab85ed543b794e99a48bbcf56b642add")))
          .thenAnswer((_) async => http.Response('Server Error', 500));

      final repositoryWithMockClient = NewRepository();
      expect(() => repositoryWithMockClient.fetchCategoriesNews("General"),
          throwsException);
    });

    test('Handles Empty Response', () async {
      when(mockClient.get(Uri.parse(
              "https://newsapi.org/v2/top-headlines?sources=bbc-news&apiKey=ab85ed543b794e99a48bbcf56b642add")))
          .thenAnswer((_) async => http.Response('', 200));

      final repositoryWithMockClient = NewRepository();
      final categoryNews =
          await repositoryWithMockClient.fetchCategoriesNews("General");
      expect(categoryNews.articles, isEmpty);
    });
  });
}
