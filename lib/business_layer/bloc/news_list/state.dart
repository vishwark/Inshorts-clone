part of 'news_data_bloc.dart';

class NewsState {}

// all_news, trending, top_stories
class AllNewsLoaded extends NewsState {
  String category = "all_news";
  NewsList newsData;
  AllNewsLoaded({
    required this.category,
    required this.newsData,
  });
}

class TrendingNewsLoaded extends NewsState {
  String category = "trending";
  NewsList newsData;
  TrendingNewsLoaded({
    required this.category,
    required this.newsData,
  });
}

class TopStoriesNewsLoaded extends NewsState {
  String category = "top_stories";
  NewsList newsData;
  TopStoriesNewsLoaded({
    required this.category,
    required this.newsData,
  });
}

class CustomSelectNewsLoaded extends NewsState {
  String category;
  NewsList newsData;
  CustomSelectNewsLoaded({
    required this.category,
    required this.newsData,
  });
}

class NewsLoading extends NewsState {}

class Error extends NewsState {}

class NewsNetworkError extends NewsState {}
