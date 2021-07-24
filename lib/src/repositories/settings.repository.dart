import 'package:kana_plus_plus/src/repositories/interface/settings.repository.dart';
import 'package:kana_plus_plus/src/shared/cache_storage.dart';

class SettingsRepository implements ISettingsRepository {
  @override
  bool getDarkMode() {
    return CacheStorage.getBool("dark_mode");
  }

  @override
  void saveDarkMode(bool value) {
    CacheStorage.setBool("dark_mode", value);
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
