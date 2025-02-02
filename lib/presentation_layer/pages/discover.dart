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
import 'package:inshorts_clone/presentation_layer/widgets/network_disconnected.dart';
import 'package:inshorts_clone/presentation_layer/widgets/suggested_topics_tile.dart';

class Discover extends StatefulWidget {
  const Discover({super.key});

  @override
  State<Discover> createState() => _DiscoverState();
}

class _DiscoverState extends State<Discover> {
  String selectedCategory = 'top_stories';
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
      tag: 'bookmarks',
    )
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
                                .setFavoriteCategory(categories[index].tag,
                                    categories[index].label);
                            context.read<NewsDataBloc>().add(FetchNews(
                                  category: categories[index].tag,
                                  offset: null,
                                  addTo: 'bottom',
                                  clearCache: true,
                                ));
                            Navigator.of(context).pop();
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
            BlocBuilder<SuggestedTopicsBloc, SuggestedTopicsState>(
                builder: (context, state) {
              if (state is SuggestedTopicsLoaded) {
                return Expanded(
                  child: GridView.count(
                    crossAxisCount: 3,
                    children:
                        List.generate(state.suggestedTopics.length, (index) {
                      return GestureDetector(
                        onTap: () {
                          context
                              .read<FavoriteCategoryCubit>()
                              .setFavoriteCategory(
                                state.suggestedTopics[index].tag,
                                state.suggestedTopics[index].label,
                              );
                          context
                              .read<NewsDataBloc>()
                              .add(FetchCustomSelectNews(
                                category: state.suggestedTopics[index].tag,
                                offset: '1',
                                addTo: 'bottom',
                                clearCache: true,
                              ));
                          Navigator.of(context).pop();
                        },
                        child: SuggestedTopicsTile(
                          nightModeImgUrl:
                              state.suggestedTopics[index].nightModeImgUrl,
                          label: state.suggestedTopics[index].label,
                          imgUrl: state.suggestedTopics[index].imgUrl,
                          tag: state.suggestedTopics[index].tag,
                        ),
                      );
                    }),
                  ),
                );
              } else if (state is SuggestedTopicsLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is SuggestedTopicsError) {
                return const Center(
                    child: Text("Sorry failed to fetch topics!"));
              } else if (state is SuggestedTopicsNetworkError) {
                return NetworkDisconnected();
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
