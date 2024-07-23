import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:inshorts_clone/presentation_layer/pages/news.dart';

class PageContainer extends StatefulWidget {
  const PageContainer({super.key});

  @override
  State<PageContainer> createState() => _PageContainerState();
}

class _PageContainerState extends State<PageContainer> {
  PageController controller = PageController(initialPage: 0);
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return NewsPage();
  }
}
