import 'package:hive/hive.dart';
import 'package:kwriting/domain/domain.dart';

class WritingHandRepository implements IWritingHandRepository {
  late Box _box;

  Future<void> load() async {
    _box = (Hive.isBoxOpen(BoxTag.settings)) ? Hive.box(BoxTag.settings) : await Hive.openBox(BoxTag.settings);
  }

  @override
  Future<WritingHand> getWritingHand() async {
    await load();
    return _box.get(DatabaseTag.writingHand, defaultValue: WritingHand.right);
  }

  @override
  Future<void> updateWritingHand(WritingHand writingHand) async {
    await load();
    await _box.put(DatabaseTag.writingHand, writingHand);
  }
}
