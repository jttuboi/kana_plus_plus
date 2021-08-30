import 'package:kana_plus_plus/src/data/singletons/cache.dart';
import 'package:kana_plus_plus/src/data/utils/consts.dart';
import 'package:kana_plus_plus/src/domain/core/consts.dart';
import 'package:kana_plus_plus/src/domain/repositories/language.interface.repository.dart';

class LanguageRepository implements ILanguageRepository {
  @override
  String getLanguageSelected() {
    return Cache.getString(SettingsPref.language, defaultValue: Default.locale);
  }

  @override
  void setLanguageSelected(String value) {
    Cache.setString(SettingsPref.language, value);
  }
}
