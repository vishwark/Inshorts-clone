import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:inshorts_clone/business_layer/bloc/news_list/news_data_bloc.dart';
import 'package:inshorts_clone/business_layer/bloc/suggested_new_category/suggested_topics_bloc.dart';
import 'package:inshorts_clone/business_layer/cubit/current_page_source_cubit.dart';
import 'package:inshorts_clone/business_layer/cubit/fav_category/fav_news_category.dart';
import 'package:inshorts_clone/business_layer/cubit/fav_category/state.dart';
import 'package:inshorts_clone/data_layer/api_repository.dart';
import 'package:inshorts_clone/data_layer/api_services.dart';
import 'package:inshorts_clone/data_layer/data_model/news_category.dart';
import 'package:inshorts_clone/data_layer/data_model/suggested_topic.dart';
import 'package:inshorts_clone/presentation_layer/pages/settings.dart';
import 'package:inshorts_clone/presentation_layer/widgets/category_tile.dart';
import 'package:inshorts_clone/presentation_layer/widgets/suggested_topics_tile.dart';

class Discover extends StatefulWidget {
  const Discover({super.key});

  @override
  State<Discover> createState() => _DiscoverState();
}

class _DiscoverState extends State<Discover> {
  //move to cubit
  String selectedCategory = 'top_stories';

  //move to constant
  List<NewsCategory> categories = [
    NewsCategory(
        imgUrl: 'lib/assets/imgs/cat_top_stories.png',
        isSelected: true,
        label: "TOP STORIES",
        tag: 'top_stories'),
    NewsCategory(
        imgUrl: 'lib/assets/imgs/cat_all_news.png',
        isSelected: false,
        label: "ALL NEWS",
        tag: 'all_news'),
    NewsCategory(
        imgUrl: 'lib/assets/imgs/cat_trending.png',
        isSelected: false,
        label: "TRENDING",
        tag: 'trending'),
    NewsCategory(
        imgUrl: 'lib/assets/imgs/cat_bookmarks.png',
        isSelected: false,
        label: "BOOKMARKS",
        tag: 'bookmarks')
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: SizedBox.shrink(),
        title: Text("Categories and Topics"),
        centerTitle: false,
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => SettingsPage()));
            },
            child: FaIcon(FontAwesomeIcons.gear),
          ),
          SizedBox(
            width: 16,
          ),
          GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: FaIcon(FontAwesomeIcons.arrowRight)),
          SizedBox(
            width: 20,
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 0, vertical: 20),
                child:
                    BlocBuilder<FavoriteCategoryCubit, FavoriteCategoryState>(
                  builder: (context, state) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: List.generate(categories.length, (index) {
                        return GestureDetector(
                          onTap: () {
                            context
                                .read<FavoriteCategoryCubit>()
                                .setFavoriteCategory(categories[index].tag);
                          },
                          child: CategoryTile(
                            imgUrl: categories[index].imgUrl,
                            label: categories[index].label,
                            tag: categories[index].tag,
                            isSelected:
                                state.favoriteCategory == categories[index].tag,
                          ),
                        );
                      }),
                    );
                  },
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "SUGGESTED TOPICS",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.underline,
                  decorationThickness: 2,
                  decorationStyle: TextDecorationStyle.solid,
                ),
              ),
            ),
            Padding(
              // remove this after testing
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 0),
              child: BlocBuilder<NewsDataBloc, NewsState>(
                  builder: (context, state) {
                if (state is NewsLoading) {
                  return CircularProgressIndicator();
                } else if (state is AllNewsLoaded) {
                  return Center(
                      child: Text(state.newsData.newsList.length.toString()));
                } else {
                  print('11111111111111 $state');
                  return Center(child: Text("Some issue!"));
                }
              }),
            ),
            BlocBuilder<SuggestedTopicsBloc, SuggestedTopicsState>(
                builder: (context, state) {
              if (state is SuggestedTopicsLoaded) {
                return Expanded(
                  child: GridView.count(
                    crossAxisCount: 3,
                    children:
                        List.generate(state.suggestedTopics.length, (index) {
                      return SuggestedTopicsTile(
                        nightModeImgUrl:
                            state.suggestedTopics[index].nightModeImgUrl,
                        label: state.suggestedTopics[index].label,
                        imgUrl: state.suggestedTopics[index].imgUrl,
                        tag: state.suggestedTopics[index].tag,
                      );
                    }),
                  ),
                );
              } else if (state is SuggestedTopicsLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is SuggestedTopicsError) {
                return const Center(
                    child: Text("Sorry failed to fetch topics!"));
              } else {
                return const Center(
                    child: Text("Ohh no! this was not expected"));
              }
            }),
          ],
        ),
      ),
    );
  }
}
