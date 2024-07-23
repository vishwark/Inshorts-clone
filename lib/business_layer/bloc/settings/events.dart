part of 'settings_bloc.dart';

class SettingsEvent {}

class LoadSettings extends SettingsEvent {}

class UpdateTheme extends SettingsEvent {
  final bool isDarkTheme;
  UpdateTheme(this.isDarkTheme);
}

class UpdateNotifications extends SettingsEvent {
  final bool notificationsEnabled;
  UpdateNotifications(this.notificationsEnabled);
}

class UpdateLanguage extends SettingsEvent {
  final String language;
  UpdateLanguage(this.language);
}
