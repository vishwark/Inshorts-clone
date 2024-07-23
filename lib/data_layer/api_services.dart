import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiServices {
  Future<http.Response> fetchSuggestedTopics({required String language}) async {
    try {
      String url = 'https://inshorts.com/api/$language/search/trending_topics';
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        return response;
      } else {
        throw Exception('Failed to load suggested topics');
      }
    } catch (e) {
      throw Exception('Failed to load suggested topics: $e');
    }
  }

  Future<http.Response> fetchNews(
      {required String category,
      required String? offset,
      required String language}) async {
    String url =
        'https://inshorts.com/api/in/$language/news?category=$category&max_limit=10&include_card_data=true${offset == null ? '' : '&news_offset=${offset}'}';
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        return response;
      } else {
        throw Exception('Failed to load news');
      }
    } catch (e) {
      throw Exception('Failed to load news: $e');
    }
  }

  Future<http.Response> fetchCustomSelectNews(
      {required String category, required String language}) async {
    String url =
        "https://inshorts.com/api/$language/search/trending_topics/$category?page=1&type=CUSTOM_CATEGORY";
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        return response;
      } else {
        throw Exception('Failed to load selct news');
      }
    } catch (e) {
      throw Exception('Failed to load select news');
    }
  }
}
