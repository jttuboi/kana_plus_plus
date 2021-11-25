import 'package:hive/hive.dart';
import 'package:kwriting/core/core.dart';
import 'package:kwriting/domain/domain.dart';

class KanaTypeRepository implements IKanaTypeRepository {
  late Box _box;

  Future<void> load() async {
    _box = (Hive.isBoxOpen(BoxTag.settings)) ? Hive.box(BoxTag.settings) : await Hive.openBox(BoxTag.settings);
  }

  @override
  Future<KanaType> getKanaType() async {
    await load();
    return _box.get(DatabaseTag.kanaType, defaultValue: KanaType.both);
  }

  @override
  Future<void> updateKanaType(KanaType kanaType) async {
    await load();
    await _box.put(DatabaseTag.kanaType, kanaType);
  }
}
