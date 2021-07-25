import 'package:kana_plus_plus/src/repositories/interface/settings.repository.dart';
import 'package:kana_plus_plus/src/shared/cache_storage.dart';
import 'package:kana_plus_plus/src/shared/writing_hand.dart';

class SettingsRepository implements ISettingsRepository {
  @override
  String getLanguage() {
    return CacheStorage.getString("language", defaultValue: "en");
  }

  @override
  void saveLanguage(String value) {
    CacheStorage.setString("language", value);
  }

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

  @override
  int getWritingHandSelectedKey() {
    return CacheStorage.getInt("writing_hand",
        defaultValue: WritingHand.right.index);
  }

  @override
  void saveWritingHandSelectedKey(int value) {
    CacheStorage.setInt("writing_hand", value);
  }
}
