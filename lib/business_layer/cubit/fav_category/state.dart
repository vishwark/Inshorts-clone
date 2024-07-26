import 'package:flutter_bloc/flutter_bloc.dart';

class FavoriteCategoryState {
  final String favoriteCategory;
  final String favoriteCategoryLabel;

  FavoriteCategoryState(
      {required this.favoriteCategory, required this.favoriteCategoryLabel});
}
