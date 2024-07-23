part of 'settings_bloc.dart';

class SettingsState {}

class SettingsInitial extends SettingsState {}

class SettingsLoaded extends SettingsState {
  final bool isDarkTheme;
  final bool notificationsEnabled;
  final String language;

  SettingsLoaded({
    required this.isDarkTheme,
    required this.notificationsEnabled,
    required this.language,
  });
}
