import 'package:kwriting/domain/domain.dart';
import 'package:kwriting/infra/infra.dart';

class AppRepository implements IAppRepository {
  AppRepository(this.database);

  IDatabase database;

  @override
  Future<bool> isFirstTime() async {
    // when access the first time, the default is true
    await database.load(BoxTag.app);
    return database.get(DatabaseTag.firstTime, defaultValue: Default.firstTime);
  }

  @override
  Future<void> setFirstTime(bool isFirstTime) async {
    await database.load(BoxTag.app);
    await database.put(DatabaseTag.firstTime, isFirstTime);
  }
}
