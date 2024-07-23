import 'package:inshorts_clone/data_layer/data_model/news_data.dart';

class NewsList {
  final List<NewsData> newsList;
  final String offsetId;
  NewsList({required this.newsList, required this.offsetId});
}
