import 'package:hive/hive.dart';
import 'package:kwriting/core/core.dart';
import 'package:kwriting/domain/domain.dart';

class ShowHintRepository implements IShowHintRepository {
  late Box _box;

  Future<void> load() async {
    _box = (Hive.isBoxOpen(BoxTag.settings)) ? Hive.box(BoxTag.settings) : await Hive.openBox(BoxTag.settings);
  }

  @override
  Future<bool> getShowHint() async {
    await load();
    return _box.get(DatabaseTag.showHint, defaultValue: Default.showHint);
  }

  @override
  Future<void> updateShowHint(bool showHint) async {
    await load();
    await _box.put(DatabaseTag.showHint, showHint);
  }
}
