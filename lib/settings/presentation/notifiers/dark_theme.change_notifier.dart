import 'package:flutter/foundation.dart';
import 'package:kwriting/settings/settings.dart';

class DarkThemeChangeNotifier extends ChangeNotifier {
  DarkThemeChangeNotifier(this._controller);

  final SettingsController _controller;

  bool get darkTheme => _controller.darkThemeSelected;

  String get iconUrl => _controller.darkThemeIconUrl;

  void updateDarkTheme(bool pIsDarkTheme) {
    _controller.updateDarkThemeSelected(pIsDarkTheme);
    notifyListeners();
  }
}
