import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inshorts_clone/business_layer/cubit/fav_category/state.dart';

class FavoriteCategoryCubit extends Cubit<FavoriteCategoryState> {
  FavoriteCategoryCubit()
      : super(FavoriteCategoryState(
            favoriteCategory: 'top_stories',
            favoriteCategoryLabel: 'Top Stories'));

  void setFavoriteCategory(String category, String categoryLabel) {
    emit(FavoriteCategoryState(
        favoriteCategory: category, favoriteCategoryLabel: categoryLabel));
  }
}
