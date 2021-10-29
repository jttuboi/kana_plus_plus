import 'package:kwriting/core/core.dart';
import 'package:kwriting/features/menu/menu.dart';

class AppRepository implements IAppRepository {
  @override
  bool isFirstTime() {
    // when access the first time, the default is true
    return Database.storage.getBool(DatabaseTag.firstTime, defaultValue: Default.firstTime);
  }

  @override
  void setFirstTime(bool isFirstTime) {
    Database.storage.setBool(DatabaseTag.firstTime, isFirstTime);
  }
}
