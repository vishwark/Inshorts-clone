import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inshorts_clone/business_layer/bloc/news_list/news_data_bloc.dart';
import 'package:inshorts_clone/business_layer/cubit/fav_category/fav_news_category.dart';
import 'package:inshorts_clone/business_layer/cubit/offset_cubit.dart';
import 'package:inshorts_clone/business_layer/cubit/current_page_source_cubit.dart';
import 'package:inshorts_clone/data_layer/data_model/news_data.dart';
import 'package:inshorts_clone/data_layer/data_model/news_list.dart';
import 'package:inshorts_clone/presentation_layer/pages/discover.dart';
import 'package:inshorts_clone/presentation_layer/pages/settings.dart';
import 'package:inshorts_clone/presentation_layer/widgets/loader.dart';
import 'package:inshorts_clone/presentation_layer/widgets/news_screen.dart';
import 'package:inshorts_clone/presentation_layer/widgets/web_view.dart';

class NewsPage extends StatefulWidget {
  NewsPage({super.key});

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  late String offset;
  PageController controller = PageController();
  final ScrollController _scrollController = ScrollController();
  Future<void> onRefresh(String offset) {
    return Future.delayed(Duration(microseconds: 1000), () {
      fetchNext10News(offset: offset, position: 'top');
    });
  }

  void onPressedTopIcon() {
    String category =
        BlocProvider.of<FavoriteCategoryCubit>(context).state.favoriteCategory;
    if (controller.page == 0) {
      BlocProvider.of<NewsDataBloc>(context).add(FetchNews(
        offset: offset,
        category: category,
        addTo: 'top',
        clearCache: false,
      ));
    } else {
      controller.jumpToPage(0);
    }
  }

  @override
  void initState() {
    super.initState();
  }

  void fetchNext10News({required String offset, required String position}) {
    String category =
        BlocProvider.of<FavoriteCategoryCubit>(context).state.favoriteCategory;
    if (category == 'all_news' ||
        category == 'trending' ||
        category == 'top_stories' ||
        category == 'bookmarks') {
      context.read<NewsDataBloc>().add(FetchNews(
            category: category,
            addTo: position,
            offset: offset,
            clearCache: false,
          ));
    } else {
      context.read<NewsDataBloc>().add(FetchCustomSelectNews(
            category: category,
            addTo: position,
            offset: offset,
            clearCache: false,
          ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocBuilder<NewsDataBloc, NewsState>(builder: (context, state) {
        if (state is NewsLoading) {
          return Loader();
        } else if (state is AllNewsLoaded) {
          print("new data udpated33333333333 ${state.newsData.offsetId}");
          offset = state.newsData.offsetId;
          BlocProvider.of<CurrentPageSourceCubit>(context)
              .updateCurrentPageSourceUrl(
                  url: state.newsData.newsList[0].sourceUrl);
          return loadedStateWidget(state.newsData);
        } else if (state is TrendingNewsLoaded) {
          offset = state.newsData.offsetId;
          BlocProvider.of<CurrentPageSourceCubit>(context)
              .updateCurrentPageSourceUrl(
                  url: state.newsData.newsList[0].sourceUrl);
          return loadedStateWidget(state.newsData);
        } else if (state is TopStoriesNewsLoaded) {
          offset = state.newsData.offsetId;
          BlocProvider.of<CurrentPageSourceCubit>(context)
              .updateCurrentPageSourceUrl(
                  url: state.newsData.newsList[0].sourceUrl);
          return loadedStateWidget(state.newsData);
        } else if (state is CustomSelectNewsLoaded) {
          offset = state.newsData.offsetId;
          BlocProvider.of<CurrentPageSourceCubit>(context)
              .updateCurrentPageSourceUrl(
                  url: state.newsData.newsList[0].sourceUrl);
          return loadedStateWidget(state.newsData);
        } else {
          return Center(child: Text("Some issue!"));
        }
      }),
    );
  }

  Widget loadedStateWidget(NewsList state) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () => onRefresh(state.offsetId),
        child: PageView(
          scrollDirection: Axis.vertical,
          controller: controller,
          physics: ClampingScrollPhysics(),
          onPageChanged: (num) {
            BlocProvider.of<CurrentPageSourceCubit>(context)
                .updateCurrentPageSourceUrl(url: state.newsList[num].sourceUrl);
            if (num > state.newsList.length - 2) {
              fetchNext10News(offset: state.offsetId, position: 'bottom');
            }
          },
          children: List.generate(state.newsList.length, (index) {
            return GestureDetector(
                onHorizontalDragEnd: (details) {
                  // Detect swipe direction
                  if (details.primaryVelocity! > 0) {
                    // Swiped left
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => Discover()));
                  } else if (details.primaryVelocity! < 0) {
                    // Swiped right
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => WebViewContainer()));
                  }
                },
                child: NewsScreen(
                  newsData: state.newsList[index],
                  isFirstPage: index == 0,
                  onPressedTopIcon: onPressedTopIcon,
                ));
          }),
        ),
      ),
    );
  }
}
