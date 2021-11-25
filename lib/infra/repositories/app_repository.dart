import 'package:hive/hive.dart';
import 'package:kwriting/domain/domain.dart';

class AppRepository implements IAppRepository {
  late Box _box;

  Future<void> load() async {
    _box = (Hive.isBoxOpen(BoxTag.app)) ? Hive.box(BoxTag.app) : await Hive.openBox(BoxTag.app);
  }

  @override
  Future<bool> isFirstTime() async {
    // when access the first time, the default is true
    await load();
    return _box.get(DatabaseTag.firstTime, defaultValue: Default.firstTime);
  }

  @override
  Future<void> setFirstTime(bool isFirstTime) async {
    await load();
    await _box.put(DatabaseTag.firstTime, isFirstTime);
  }
}
