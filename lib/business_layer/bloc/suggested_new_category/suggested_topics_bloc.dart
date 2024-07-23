import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inshorts_clone/data_layer/api_repository.dart';
import 'package:inshorts_clone/data_layer/api_services.dart';
import 'package:inshorts_clone/data_layer/data_model/suggested_topic.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'state.dart';
part 'events.dart';

class SuggestedTopicsBloc
    extends Bloc<SuggestedTopicsEvents, SuggestedTopicsState> {
  late ApiRepository apiRepository;
  SuggestedTopicsBloc() : super(SuggestedTopicsInitial()) {
    apiRepository = ApiRepository();
    on<FetchSuggestedTopics>((event, emit) async {
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
