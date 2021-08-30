import 'package:kana_plus_plus/src/data/singletons/cache.dart';
import 'package:kana_plus_plus/src/data/utils/consts.dart';
import 'package:kana_plus_plus/src/domain/repositories/dark_theme.interface.repository.dart';

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
