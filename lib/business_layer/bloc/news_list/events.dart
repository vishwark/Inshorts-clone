// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'news_data_bloc.dart';

// events fetchNews with category & offset(same api) - reload, with offset, event for custom select category, event to fetch suggestions
class NewsEvents {}

class FetchNews extends NewsEvents {
  String category;
  String? offset;
  String? addTo;
  bool clearCache;
  FetchNews({
    required this.category,
    required this.offset,
    required this.addTo,
    required this.clearCache,
  });
}

class FetchCustomSelectNews extends NewsEvents {
  String category;
  FetchCustomSelectNews({
    required this.category,
  });
}

class clearAndRefetchNews extends NewsEvents {}
