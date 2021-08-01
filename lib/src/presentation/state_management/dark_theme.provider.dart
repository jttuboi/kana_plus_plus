import 'package:flutter/foundation.dart';
import 'package:kana_plus_plus/src/domain/usecases/settings.controller.dart';

class DarkThemeProvider extends ChangeNotifier {
  DarkThemeProvider(this._controller);

  final SettingsController _controller;

  bool get darkTheme => _controller.isDarkTheme();

  String get iconUrl => _controller.getDarkThemeIconUrl();

  void updateDarkTheme(bool pIsDarkTheme) {
    _controller.updateDarkTheme(pIsDarkTheme);
    notifyListeners();
  }
}
