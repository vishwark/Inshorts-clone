// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_bloc/flutter_bloc.dart';

class CurrentPageUriState {
  String uri;
  CurrentPageUriState({
    required this.uri,
  });
}

class CurrentPageSourceCubit extends Cubit<CurrentPageUriState> {
  CurrentPageSourceCubit()
      : super(CurrentPageUriState(
            uri: 'https://www.geeksforgeeks.org/pageview-widget-in-flutter/'));
  void updateCurrentPageSourceUrl({required String url}) {
    print("11111111111111---$url");
    emit(CurrentPageUriState(uri: url));
  }
}
