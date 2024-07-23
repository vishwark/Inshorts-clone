import 'package:bloc/bloc.dart';

class OffsetState {
  String offset = '';

  OffsetState({required this.offset});
}

class OffsetCubit extends Cubit<OffsetState> {
  OffsetCubit() : super(OffsetState(offset: ''));
  void updateOffset(String offset) {
    emit(OffsetState(offset: offset));
  }
}
