import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inshorts_clone/business_layer/bloc/news_list/news_data_bloc.dart';
import 'package:inshorts_clone/business_layer/bloc/settings/settings_bloc.dart';
import 'package:inshorts_clone/business_layer/bloc/suggested_new_category/suggested_topics_bloc.dart';
import 'package:inshorts_clone/business_layer/cubit/offset_cubit.dart';
import 'package:inshorts_clone/business_layer/cubit/current_page_source_cubit.dart';
import 'package:inshorts_clone/business_layer/cubit/fav_category/fav_news_category.dart';
import 'package:inshorts_clone/presentation_layer/pages/index.dart';
import 'package:inshorts_clone/utility/theme/theme_data.dart';

void main() {
  HttpOverrides.global = MyHttpOverrides();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SettingsBloc(),
      //if something changes in setting(Language, theme), rebuild the app
      child: BlocBuilder<SettingsBloc, SettingsState>(
        builder: (context, state) {
          return _buildApp(context, state);
        },
      ),
    );
  }

  Widget _buildApp(BuildContext context, SettingsState state) {
    final settingsBloc =
        context.read<SettingsBloc>(); // Get the instance of SettingsBloc
    bool darkMode = false;
    if (state is SettingsLoaded) {
      darkMode = state.isDarkTheme;
    }
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => OffsetCubit()),
        BlocProvider(create: (context) => CurrentPageSourceCubit()),
        BlocProvider(create: (context) => FavoriteCategoryCubit()),
        BlocProvider(
            create: (context) => NewsDataBloc(
                settingsBloc)), // padding settings bloc to access the theme/language while fetching data
        BlocProvider(
            create: (context) => SuggestedTopicsBloc(
                settingsBloc)), // New instance of SuggestedTopicsBloc
      ],
      child: MaterialApp(
        title: 'inshorts',
        theme: MyThemeData().lightTheme(), // Light theme
        darkTheme: MyThemeData().darkTheme(),
        themeMode: darkMode ? ThemeMode.dark : ThemeMode.light,
        home: PageContainer(), // Replace with your home page
      ),
    );
  }
}

// uncomment this if Network image not loading due to certificate issue
class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    final client = super.createHttpClient(context);
    client.badCertificateCallback =
        (X509Certificate cert, String host, int port) => true;
    return client;
  }
}
