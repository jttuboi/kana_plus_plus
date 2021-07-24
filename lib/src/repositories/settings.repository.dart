import 'package:kana_plus_plus/src/repositories/interface/settings.repository.dart';
import 'package:kana_plus_plus/src/shared/cache_storage.dart';

class SettingsRepository implements ISettingsRepository {
  @override
  bool getDarkTheme() {
    return CacheStorage.getBool("dark_theme");
  }

  @override
  void saveDarkTheme(bool value) {
    CacheStorage.setBool("dark_theme", value);
  }

  @override
  bool getShowHint() {
    return CacheStorage.getBool("show_hint", defaultValue: true);
  }

  @override
  void saveShowHint(bool value) {
    CacheStorage.setBool("show_hint", value);
  }
}
