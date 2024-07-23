import 'package:flutter/material.dart';

class ToggleData {
  String tag;
  String title;
  String? subTitle;
  IconData iconData;
  bool value;
  ToggleData({
    required this.tag,
    required this.title,
    required this.subTitle,
    required this.iconData,
    required this.value,
  });
}
