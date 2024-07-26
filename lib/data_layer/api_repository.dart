import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inshorts_clone/business_layer/cubit/offset_cubit.dart';
import 'package:inshorts_clone/data_layer/api_services.dart';
import 'package:inshorts_clone/data_layer/data_model/news_data.dart';
import 'package:inshorts_clone/data_layer/data_model/news_list.dart';
import 'package:inshorts_clone/data_layer/data_model/suggested_topic.dart';

class ApiRepository {
  final ApiServices apiServices = ApiServices();

  ApiRepository();

  Future<List<SuggestedTopic>> getSuggestedTopics(String language) async {
    try {
      final response =
          await apiServices.fetchSuggestedTopics(language: language);
      final Map<String, dynamic> dataMap = json.decode(response.body);
      final List<dynamic> trendingTags = dataMap['data']['trending_tags'];

      return trendingTags.map((tag) => SuggestedTopic.fromMap(tag)).toList();
    } catch (e) {
      throw Exception('Failed to parse suggested topics: $e');
    }
  }

  Future<NewsList> getsNewsData(
      String? offset, String category, String language) async {
    try {
      final response = await apiServices.fetchNews(
          category: category, offset: offset, language: language);
      final Map<String, dynamic> dataMap = json.decode(response.body);
      final List<dynamic> newsList = dataMap['data']['news_list'];
      final offsetId = dataMap['data']?['min_news_id'] ?? '';

      // BlocProvider.of<OffsetCubit>(context).updateOffset(offsetId);
      // todo : update the offset value in cubit used for pagination
      final List<NewsData> newsArray =
          newsList.map((news) => NewsData.fromMap(news)).toList();

      return NewsList(newsList: newsArray, offsetId: offsetId);
    } catch (e) {
      throw Exception('Failed to parse news: $e');
    }
  }

  Future<NewsList> getCustomSelectNews(
      String category, String language, String offset) async {
    try {
      final response = await apiServices.fetchCustomSelectNews(
          category: category, language: language, offset: offset);
      final Map<String, dynamic> dataMap = json.decode(response.body);
      final List<dynamic> newsList = dataMap['data']['news_list'];
      // Filter only the news items with type "NEWS"
      final List<dynamic> filteredNewsList =
          newsList.where((news) => news['type'] == 'NEWS').toList();
      final newsArray =
          filteredNewsList.map((news) => NewsData.fromMap(news)).toList();
      var offsetId = dataMap['data']?['page_num'] ?? '';

      return NewsList(newsList: newsArray, offsetId: (offsetId + 1).toString());
    } catch (e) {
      throw Exception('Failed to parse custom select news: $e');
    }
  }
}
