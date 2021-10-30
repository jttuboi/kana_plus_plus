import 'package:hive/hive.dart';
import 'package:kwriting/core/core.dart';
import 'package:kwriting/features/settings/settings.dart';

class KanaTypeRepository implements IKanaTypeRepository {
  late Box _box;

  Future<void> load() async {
    _box = (Hive.isBoxOpen(BoxTag.settings)) ? Hive.box(BoxTag.settings) : await Hive.openBox(BoxTag.settings);
  }

  @override
  KanaType getKanaType2() {
    final kanaIndex = Database.storage.getInt(DatabaseTag.kanaType, defaultValue: KanaType.both.index);
    return KanaType.values[kanaIndex];
  }

  @override
  void setKanaType(KanaType value) {
    Database.storage.setInt(DatabaseTag.kanaType, value.index);
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
