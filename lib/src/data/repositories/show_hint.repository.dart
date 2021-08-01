import 'package:kana_plus_plus/src/data/datasources/cache.singleton.dart';
import 'package:kana_plus_plus/src/data/utils/consts.dart';
import 'package:kana_plus_plus/src/domain/repositories/show_hint.interface.dart';

class ShowHintRepository implements IShowHintRepository {
  @override
  bool isShowHint() {
    return Cache.getBool(SettingsPref.showHint, defaultValue: true);
  }

  @override
  void setShowHint(bool value) {
    Cache.setBool(SettingsPref.showHint, value);
  }
}
