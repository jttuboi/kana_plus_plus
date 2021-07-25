import 'package:flutter/foundation.dart';
import 'package:kana_plus_plus/src/controllers/settings.controller.dart';

class DarkThemeProvider extends ChangeNotifier {
  DarkThemeProvider(this._controller) {
    isDarkTheme = _controller.isDarkTheme();
    notifyListeners();
  }

  final SettingsController _controller;

  late bool isDarkTheme;

  String get iconUrl => _controller.getDarkThemeIconUrl(isDarkTheme);

  void updateDarkTheme(bool pIsDarkTheme) {
    isDarkTheme = pIsDarkTheme;
    _controller.updateDarkTheme(pIsDarkTheme);
    notifyListeners();
  }
}
