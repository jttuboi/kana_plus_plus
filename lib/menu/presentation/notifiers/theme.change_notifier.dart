import 'package:flutter/material.dart';

class ThemeChangeNotifier extends ChangeNotifier {
  ThemeChangeNotifier(bool isDarkTheme) {
    updateThemeMode(isDarkTheme);
  }

  ThemeMode _mode = ThemeMode.system;

  ThemeMode get mode => _mode;

  void updateThemeMode(bool isDarkTheme) {
    if (isDarkTheme) {
      _mode = ThemeMode.dark;
    } else {
      _mode = ThemeMode.light;
    }
    notifyListeners();
  }
}
