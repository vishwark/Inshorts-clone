import 'package:flutter/widgets.dart';
import 'package:inshorts_clone/data_layer/data_model/news_data.dart';
import 'package:inshorts_clone/presentation_layer/pages/discover.dart';
import 'package:inshorts_clone/presentation_layer/widgets/news_screen.dart';
import 'package:inshorts_clone/presentation_layer/widgets/web_view.dart';

class CombinedPages extends StatelessWidget {
  final NewsData newsData;
  CombinedPages({super.key, required this.newsData});
  PageController controller = PageController(initialPage: 1);

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: controller,
      children: [
        Discover(),
        NewsScreen(newsData: newsData),
        WebViewContainer()
      ],
    );
  }
}
