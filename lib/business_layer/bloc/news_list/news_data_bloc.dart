import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inshorts_clone/business_layer/bloc/settings/settings_bloc.dart';
import 'package:inshorts_clone/data_layer/api_repository.dart';
import 'package:inshorts_clone/data_layer/api_services.dart';
import 'package:inshorts_clone/data_layer/data_model/news_data.dart';
import 'package:inshorts_clone/data_layer/data_model/news_list.dart';
import 'package:inshorts_clone/utility/connectvity_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'events.dart';
part 'state.dart';

class NewsDataBloc extends Bloc<NewsEvents, NewsState> {
  late ApiRepository apiRepository;
  late Connectivity _connectivity;
  StreamSubscription<String>? _languageSubscription;
  NewsDataBloc(SettingsBloc settingsBloc) : super(NewsLoading()) {
    apiRepository = ApiRepository();
    _connectivity = Connectivity();
    _languageSubscription = settingsBloc.languageStream.listen((language) {
      add(clearAndRefetchNews());
    });

    on<FetchNews>((event, emit) => fetchData(event, emit));
    on<clearAndRefetchNews>((event, emit) => refetch(emit));
    on<FetchCustomSelectNews>(
        (event, emit) => fetchCustomSelectNews(event, emit));
    // Dispatch the initial FetchNews event during initialization
    add(FetchNews(
      offset: null,
      category: 'all_news',
      addTo: 'bottom',
      clearCache: false,
    ));
  }

  Future<bool> isDisConnected() async {
    var connectivityResult = await _connectivity.checkConnectivity();
    return connectivityResult[0] == ConnectivityResult.none;
  }

  fetchData(FetchNews event, Emitter<NewsState> emit) async {
    bool networkDisconnected = await isDisConnected();
    if (networkDisconnected) return emit(NewsNetworkError());
    final prefs = await SharedPreferences.getInstance();
    String language = prefs.getString('language') ?? 'en';
    try {
      // to store current data
      NewsList currentData = NewsList(newsList: [], offsetId: '');
      if (state is AllNewsLoaded &&
          (event.category == 'all_news' || event.category == 'bookmarks')) {
        currentData = (state as AllNewsLoaded).newsData;
      } else if (state is TrendingNewsLoaded && event.category == 'trending') {
        currentData = (state as TrendingNewsLoaded).newsData;
      } else if (state is TopStoriesNewsLoaded &&
          event.category == 'top_stories') {
        currentData = (state as TopStoriesNewsLoaded).newsData;
      }
      emit(NewsLoading());
      //fetch new data
      NewsList data = await apiRepository.getsNewsData(
          event.offset,
          event.category == 'bookmarks' ? 'all_news' : event.category,
          language);

      //udpate the array based on request
      List<NewsData> updatedData;
      if (event.clearCache) {
        updatedData = data.newsList;
      } else if (event.addTo == 'top') {
        updatedData = [...data.newsList, ...currentData.newsList];
      } else {
        updatedData = [...currentData.newsList, ...data.newsList];
      }

      if (event.category == 'all_news') {
        emit(AllNewsLoaded(
            category: 'all_news',
            newsData:
                NewsList(newsList: updatedData, offsetId: data.offsetId)));
      } else if (event.category == 'trending') {
        emit(TrendingNewsLoaded(
            category: 'trending',
            newsData:
                NewsList(newsList: updatedData, offsetId: data.offsetId)));
      } else if (event.category == 'top_stories') {
        emit(TopStoriesNewsLoaded(
            category: 'top_stories',
            newsData:
                NewsList(newsList: updatedData, offsetId: data.offsetId)));
      }
    } catch (e) {
      emit(Error());
    }
  }

  fetchCustomSelectNews(
      FetchCustomSelectNews event, Emitter<NewsState> emit) async {
    try {
      //check for netwok & show proper msg before api calls
      bool networkDisconnected = await isDisConnected();
      if (networkDisconnected) return emit(NewsNetworkError());
      final prefs = await SharedPreferences.getInstance();
      String language = prefs.getString('language') ?? 'en';

      NewsList currentData = NewsList(newsList: [], offsetId: '');
      if (state is CustomSelectNewsLoaded) {
        currentData = (state as CustomSelectNewsLoaded).newsData;
      }
      emit(NewsLoading());
      final NewsList data = await apiRepository.getCustomSelectNews(
          event.category, language, event.offset);

      //udpate the array based on request
      List<NewsData> updatedData;
      if (event.clearCache) {
        updatedData = data.newsList;
      } else if (event.addTo == 'top') {
        updatedData = [...data.newsList, ...currentData.newsList];
      } else {
        updatedData = [...currentData.newsList, ...data.newsList];
      }

      emit(CustomSelectNewsLoaded(
          category: event.category,
          newsData: NewsList(newsList: updatedData, offsetId: data.offsetId)));
    } catch (e) {
      emit(Error());
    }
  }

  refetch(Emitter<NewsState> emit) async {
    final prefs = await SharedPreferences.getInstance();
    String category =
        'all_news'; // Fetch the last selected category from prefs or state
    String language = prefs.getString('language') ?? 'en';
    add(FetchNews(
      offset: null,
      category: category,
      addTo: 'bottom',
      clearCache: true,
    ));
  }

  @override
  Future<void> close() {
    _languageSubscription?.cancel();
    return super.close();
  }
}
