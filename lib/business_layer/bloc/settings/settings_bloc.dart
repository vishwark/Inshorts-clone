import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
part 'events.dart';
part 'state.dart';

// SettingsBloc
class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  final _languageStreamController = StreamController<String>.broadcast();
  Stream<String> get languageStream => _languageStreamController.stream;
  SettingsBloc() : super(SettingsInitial()) {
    on<LoadSettings>(_onLoadSettings);
    on<UpdateTheme>(_onUpdateTheme);
    on<UpdateNotifications>(_onUpdateNotifications);
    on<UpdateLanguage>(_onUpdateLanguage);
    _initializeSettings();
  }

  Future<void> _initializeSettings() async {
    final prefs = await SharedPreferences.getInstance();

    bool isDarkTheme = prefs.getBool('theme') ?? false;
    bool notificationsEnabled = prefs.getBool('notifications') ?? true;
    String language = prefs.getString('language') ?? 'en';

    // If settings are not set, initialize with default values
    if (!prefs.containsKey('theme')) {
      await prefs.setBool('theme', isDarkTheme);
    }
    if (!prefs.containsKey('notifications')) {
      await prefs.setBool('notifications', notificationsEnabled);
    }
    if (!prefs.containsKey('language')) {
      await prefs.setString('language', language);
    }

    add(LoadSettings()); // Load settings after initialization
  }

  Future<void> _onLoadSettings(
      LoadSettings event, Emitter<SettingsState> emit) async {
    final prefs = await SharedPreferences.getInstance();
    bool isDarkTheme = prefs.getBool('theme') ?? false;
    bool notificationsEnabled = prefs.getBool('notifications') ?? true;
    String language = prefs.getString('language') ?? 'en';

    emit(SettingsLoaded(
      isDarkTheme: isDarkTheme,
      notificationsEnabled: notificationsEnabled,
      language: language,
    ));
  }

  Future<void> _onUpdateTheme(
      UpdateTheme event, Emitter<SettingsState> emit) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('theme', event.isDarkTheme);

    final currentState = state as SettingsLoaded;
    emit(SettingsLoaded(
      isDarkTheme: event.isDarkTheme,
      notificationsEnabled: currentState.notificationsEnabled,
      language: currentState.language,
    ));
  }

  Future<void> _onUpdateNotifications(
      UpdateNotifications event, Emitter<SettingsState> emit) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('notifications', event.notificationsEnabled);

    final currentState = state as SettingsLoaded;
    emit(SettingsLoaded(
      isDarkTheme: currentState.isDarkTheme,
      notificationsEnabled: event.notificationsEnabled,
      language: currentState.language,
    ));
  }

  Future<void> _onUpdateLanguage(
      UpdateLanguage event, Emitter<SettingsState> emit) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('language', event.language);
    _languageStreamController.add(event.language); // Notify listeners
    final currentState = state as SettingsLoaded;
    emit(SettingsLoaded(
      isDarkTheme: currentState.isDarkTheme,
      notificationsEnabled: currentState.notificationsEnabled,
      language: event.language,
    ));
  }

  @override
  Future<void> close() {
    _languageStreamController.close();
    return super.close();
  }
}
