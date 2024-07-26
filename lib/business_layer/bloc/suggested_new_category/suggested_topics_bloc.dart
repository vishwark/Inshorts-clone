import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inshorts_clone/business_layer/bloc/settings/settings_bloc.dart';
import 'package:inshorts_clone/data_layer/api_repository.dart';
import 'package:inshorts_clone/data_layer/api_services.dart';
import 'package:inshorts_clone/data_layer/data_model/suggested_topic.dart';
import 'package:inshorts_clone/utility/connectvity_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'state.dart';
part 'events.dart';

class SuggestedTopicsBloc
    extends Bloc<SuggestedTopicsEvents, SuggestedTopicsState> {
  StreamSubscription<String>? _languageSubscription;
  late Connectivity _connectivity;
  late ApiRepository apiRepository;
  SuggestedTopicsBloc(SettingsBloc settingsBloc)
      : super(SuggestedTopicsInitial()) {
    _languageSubscription = settingsBloc.languageStream.listen((language) {
      add(FetchSuggestedTopics());
    });
    _connectivity = Connectivity();
    apiRepository = ApiRepository();
    on<FetchSuggestedTopics>((event, emit) async {
      var connectivityResult = await _connectivity.checkConnectivity();
      bool networkDisconnected =
          connectivityResult[0] == ConnectivityResult.none;
      if (networkDisconnected) return emit(SuggestedTopicsNetworkError());
      final prefs = await SharedPreferences.getInstance();
      String language = prefs.getString('language') ?? 'en';
      try {
        emit(SuggestedTopicsLoading());
        final topics = await apiRepository.getSuggestedTopics(language);
        emit(SuggestedTopicsLoaded(suggestedTopics: topics));
      } catch (e) {
        emit(SuggestedTopicsError());
      }
    });
    add(FetchSuggestedTopics());
  }
}
