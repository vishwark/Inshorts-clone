import 'dart:convert';

class SuggestedTopic {
  String imgUrl;
  String label;
  String nightModeImgUrl;
  String tag;

  SuggestedTopic({
    required this.imgUrl,
    required this.label,
    required this.nightModeImgUrl,
    required this.tag,
  });

  factory SuggestedTopic.fromMap(Map<String, dynamic> map) {
    return SuggestedTopic(
      imgUrl: map['image_url'],
      label: map['label'],
      nightModeImgUrl: map['night_image_url'],
      tag: map['tag'],
    );
  }

  factory SuggestedTopic.fromJson(String source) =>
      SuggestedTopic.fromMap(json.decode(source) as Map<String, dynamic>);
}
