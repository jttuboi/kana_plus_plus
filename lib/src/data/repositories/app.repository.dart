import 'package:kana_plus_plus/src/data/singletons/cache.dart';
import 'package:kana_plus_plus/src/data/utils/consts.dart';
import 'package:kana_plus_plus/src/domain/repositories/app.interface.repository.dart';

class AppRepository implements IAppRepository {
  @override
  bool isFirstTime() {
    // when access the first time, the default is true
    return Cache.getBool(SettingsPref.firstTime, defaultValue: true);
  }

  @override
  void setFirstTime(bool isFirstTime) {
    Cache.setBool(SettingsPref.firstTime, isFirstTime);
  }
}
