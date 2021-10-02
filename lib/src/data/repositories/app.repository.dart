import 'package:kana_plus_plus/src/data/singletons/database.dart';
import 'package:kana_plus_plus/src/data/utils/consts.dart';
import 'package:kana_plus_plus/src/domain/repositories/app.interface.repository.dart';
import 'package:kana_plus_plus/src/domain/utils/consts.dart';

class AppRepository implements IAppRepository {
  @override
  bool isFirstTime() {
    // when access the first time, the default is true
    return Database.getBool(DatabaseTag.firstTime, defaultValue: Default.firstTime);
  }

  @override
  void setFirstTime(bool isFirstTime) {
    Database.setBool(DatabaseTag.firstTime, isFirstTime);
  }
}
