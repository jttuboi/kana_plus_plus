import 'package:flutter/foundation.dart';
import 'package:kwriting/settings/domain/use_cases/settings.controller.dart';

class DarkThemeProvider extends ChangeNotifier {
  DarkThemeProvider(this._controller);

  final SettingsController _controller;

  bool get darkTheme => _controller.darkThemeSelected;

  String get iconUrl => _controller.darkThemeIconUrl;

  void updateDarkTheme(bool pIsDarkTheme) {
    _controller.updateDarkThemeSelected(pIsDarkTheme);
    notifyListeners();
  }
}
