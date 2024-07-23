import 'package:shared_preferences/shared_preferences.dart';

class SettingsService {
  static const String themeKey = 'theme';
  static const String notificationsKey = 'notifications';
  static const String languageKey = 'language';

  Future<void> saveTheme(bool isDarkTheme) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(themeKey, isDarkTheme);
  }

  Future<void> saveNotifications(bool notificationsEnabled) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(notificationsKey, notificationsEnabled);
  }

  Future<void> saveLanguage(String language) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(languageKey, language);
  }

  Future<Map<String, dynamic>> getSettings() async {
    final prefs = await SharedPreferences.getInstance();
    bool isDarkTheme = prefs.getBool(themeKey) ?? false;
    bool notificationsEnabled = prefs.getBool(notificationsKey) ?? true;
    String language = prefs.getString(languageKey) ?? 'en';

    return {
      'isDarkTheme': isDarkTheme,
      'notificationsEnabled': notificationsEnabled,
      'language': language,
    };
  }
}
