import 'package:kana_plus_plus/src/repositories/interface/local_storage.dart';
import 'package:kana_plus_plus/src/repositories/interface/settings.repository.dart';
import 'package:kana_plus_plus/src/repositories/shared_preferences_local_storage.dart';

class SettingsRepository implements ISettingsRepository {
  ILocalStorage localStorage = SharedPreferencesLocalStorage();

  @override
  Future<bool> getShowHint() {
    return localStorage.getBool("show_hint");
  }

  @override
  Future<void> saveShowHint(bool value) async {
    localStorage.setBool("show_hint", value);
  }
}
