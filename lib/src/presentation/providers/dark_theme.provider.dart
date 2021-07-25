import 'package:flutter/foundation.dart';
import 'package:kana_plus_plus/src/domain/repositories/settings.interface.dart';

class DarkThemeProvider extends ChangeNotifier {
  DarkThemeProvider(this._repository) {
    isDarkTheme = _repository.isDarkTheme();
    notifyListeners();
  }

  final ISettingsRepository _repository;

  late bool isDarkTheme;

  String get iconUrl => _repository.getDarkThemeIconUrl(isDarkTheme);

  void updateDarkTheme(bool pIsDarkTheme) {
    isDarkTheme = pIsDarkTheme;
    _repository.saveDarkTheme(pIsDarkTheme);
    notifyListeners();
  }
}
