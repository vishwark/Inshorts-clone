// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_bloc/flutter_bloc.dart';

class CurrentPageUriState {
  String uri;
  CurrentPageUriState({
    required this.uri,
  });
}

// This is used to store the current news page source website link.
class CurrentPageSourceCubit extends Cubit<CurrentPageUriState> {
  CurrentPageSourceCubit() : super(CurrentPageUriState(uri: ''));
  void updateCurrentPageSourceUrl({required String url}) {
    emit(CurrentPageUriState(uri: url));
  }
}
