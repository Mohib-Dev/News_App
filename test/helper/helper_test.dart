import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:news_app/view_model/news_view_model.dart';

@GenerateMocks(
  [NewsViewModel],
  customMocks: [MockSpec<http.Client>(as: #MockHttpClient)],
)
void main() {}
