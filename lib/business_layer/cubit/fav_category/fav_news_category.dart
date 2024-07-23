import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inshorts_clone/business_layer/cubit/fav_category/state.dart';

class FavoriteCategoryCubit extends Cubit<FavoriteCategoryState> {
  FavoriteCategoryCubit()
      : super(FavoriteCategoryState(favoriteCategory: 'top_stories'));

  void setFavoriteCategory(String category) {
    emit(FavoriteCategoryState(favoriteCategory: category));
  }
}
