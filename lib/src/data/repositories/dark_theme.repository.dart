import 'package:kana_plus_plus/src/data/datasources/cache.singleton.dart';
import 'package:kana_plus_plus/src/data/utils/consts.dart';
import 'package:kana_plus_plus/src/domain/repositories/dark_theme.interface.dart';

class DarkThemeRepository implements IDarkThemeRepository {
  @override
  bool isDarkTheme() {
    return Cache.getBool(SettingsPref.darkTheme);
  }

  @override
  void setDarkTheme(bool value) {
    Cache.setBool(SettingsPref.darkTheme, value);
  }
}