import 'package:flutter/foundation.dart';
import 'package:kana_plus_plus/src/controllers/settings.controller.dart';

class DarkModeProvider extends ChangeNotifier {
  DarkModeProvider(this.controller) {
    darkMode = controller.getDarkMode();
    notifyListeners();
  }

  SettingsController controller;

  late bool darkMode;

  String get darkModeIconUrl {
    return controller.getDarkModeIconUrl(darkMode);
  }

  void changeDarkMode(bool pDarkMode) {
    darkMode = pDarkMode;
    controller.updateDarkMode(pDarkMode);
    notifyListeners();
  }
}
