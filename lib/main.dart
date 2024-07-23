import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inshorts_clone/business_layer/bloc/news_list/news_data_bloc.dart';
import 'package:inshorts_clone/business_layer/bloc/settings/settings_bloc.dart';
import 'package:inshorts_clone/business_layer/bloc/suggested_new_category/suggested_topics_bloc.dart';
import 'package:inshorts_clone/business_layer/cubit/offset_cubit.dart';
import 'package:inshorts_clone/business_layer/cubit/current_page_source_cubit.dart';
import 'package:inshorts_clone/business_layer/cubit/fav_category/fav_news_category.dart';
import 'package:inshorts_clone/presentation_layer/pages/discover.dart';
import 'package:inshorts_clone/presentation_layer/pages/index.dart';
import 'package:inshorts_clone/presentation_layer/pages/news.dart';
import 'package:inshorts_clone/presentation_layer/pages/settings.dart';
import 'package:inshorts_clone/presentation_layer/widgets/settings.dart';
import 'package:inshorts_clone/presentation_layer/widgets/sign_in_options.dart';

void main() {
  HttpOverrides.global = MyHttpOverrides();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SettingsBloc(),
      child: BlocConsumer<SettingsBloc, SettingsState>(
        listener: (context, state) {
          if (state is SettingsLoaded) {
            print("11111111111111----settings updated");
            // You can add additional logic here if needed when SettingsUpdated state is emitted
          }
        },
        builder: (context, state) {
          // Ensure BlocProvider recreates the blocs on language or theme change
          return _buildApp(context, state);
        },
      ),
    );
  }

  Widget _buildApp(BuildContext context, SettingsState state) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => OffsetCubit()),
        BlocProvider(create: (context) => CurrentPageSourceCubit()),
        BlocProvider(create: (context) => FavoriteCategoryCubit()),
        BlocProvider(
            create: (context) =>
                NewsDataBloc()), // New instance of NewsDataBloc
        BlocProvider(
            create: (context) =>
                SuggestedTopicsBloc()), // New instance of SuggestedTopicsBloc
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightBlue),
          useMaterial3: true,
        ),
        home: PageContainer(), // Replace with your home page
      ),
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    final client = super.createHttpClient(context);
    client.badCertificateCallback =
        (X509Certificate cert, String host, int port) => true;
    return client;
  }
}
