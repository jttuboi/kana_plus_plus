import 'package:kwriting/src/domain/repositories/app.interface.repository.dart';
import 'package:kwriting/src/domain/utils/consts.dart';
import 'package:kwriting/src/infrastructure/singletons/database.dart';
import 'package:kwriting/src/infrastructure/utils/consts.dart';

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
