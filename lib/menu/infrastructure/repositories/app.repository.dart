import 'package:kwriting/core/core.dart';
import 'package:kwriting/menu/menu.dart';
import 'package:kwriting/src/infrastructure/singletons/database.dart';

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
