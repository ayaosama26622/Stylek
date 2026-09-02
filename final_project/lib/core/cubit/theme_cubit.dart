// Manages the app's light/dark theme mode and persists the choice locally.
import 'package:final_project/core/services/local/shared_pref.dart';
import 'package:flutter/material.dart';

class ThemeCubit extends ChangeNotifier {
  ThemeCubit._internal() {
    _loadSavedThemeMode();
  }

  static final ThemeCubit instance = ThemeCubit._internal();

  ThemeMode _themeMode = ThemeMode.light;

  ThemeMode get themeMode => _themeMode;

  bool get isDarkMode => _themeMode == ThemeMode.dark;

  void _loadSavedThemeMode() {
    final saved = SharedPref.pref.getString(SharedPref.kThemeMode);
    if (saved == 'dark') {
      _themeMode = ThemeMode.dark;
    } else if (saved == 'light') {
      _themeMode = ThemeMode.light;
    }
    notifyListeners();
  }

  Future<void> setDarkMode(bool enabled) async {
    _themeMode = enabled ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
    await SharedPref.pref.setString(
      SharedPref.kThemeMode,
      enabled ? 'dark' : 'light',
    );
  }

  Future<void> toggleTheme() => setDarkMode(!isDarkMode);
}
