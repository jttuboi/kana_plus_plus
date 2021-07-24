import 'package:flutter/foundation.dart';
import 'package:kana_plus_plus/src/controllers/settings.controller.dart';

class DarkThemeProvider extends ChangeNotifier {
  DarkThemeProvider(this.controller) {
    isDarkTheme = controller.isDarkTheme();
    notifyListeners();
  }

  SettingsController controller;

  late bool isDarkTheme;

  String get darkThemeIconUrl {
    return controller.getDarkThemeIconUrl(isDarkTheme);
  }

  void changeDarkTheme(bool pDarkTheme) {
    isDarkTheme = pDarkTheme;
    controller.updateDarkTheme(pDarkTheme);
    notifyListeners();
  }
}
