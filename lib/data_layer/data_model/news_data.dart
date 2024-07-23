// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:timeago/timeago.dart' as timeago;

class NewsData {
  String imageUrl;
  String title;
  String content;
  String? createdAt; // Nullable string for time ago string representation

  String byline1;
  String byline2;

  String bottomHeadline;
  String bottomText;
  String bottomPanelLink;

  String shortenedUrl;
  String sourceUrl;

  bool? isYoutubeVideo;

  NewsData({
    required this.imageUrl,
    required this.title,
    required this.content,
    this.createdAt,
    required this.byline1,
    required this.byline2,
    required this.bottomHeadline,
    required this.bottomText,
    required this.bottomPanelLink,
    required this.shortenedUrl,
    required this.sourceUrl,
    this.isYoutubeVideo,
  });

  factory NewsData.fromMap(Map<String, dynamic> data) {
    final map = data['news_obj'];
    final dateTime = DateTime.fromMillisecondsSinceEpoch(map['created_at']);
    final timeAgo = timeago.format(dateTime).toString();

    String byline1 = '';
    String byline2 = '';
    if (map['byline_1'] is List && map['byline_1'].isNotEmpty) {
      byline1 = '${map['byline_1'][0]['text']} $timeAgo';
    }
    if (map['byline_2'] is List && map['byline_2'].isNotEmpty) {
      byline2 = '${map['byline_2'][0]['text']} ${map['byline_2'][1]['text']}';
    }

    return NewsData(
        imageUrl: map['image_url'] as String,
        title: map['title'] as String,
        content: map['content'] as String,
        createdAt: timeAgo, // Use the formatted time ago string
        bottomHeadline: map['bottom_headline'] as String,
        bottomText: map['bottom_text'] as String,
        bottomPanelLink: map['bottom_panel_link'] as String,
        shortenedUrl: map['shortened_url'] as String,
        isYoutubeVideo: map['is_youtube_video'] as bool?,
        byline1: byline1,
        byline2: byline2,
        sourceUrl: map['source_url']);
  }

  factory NewsData.fromJson(String source) =>
      NewsData.fromMap(json.decode(source) as Map<String, dynamic>);
}
