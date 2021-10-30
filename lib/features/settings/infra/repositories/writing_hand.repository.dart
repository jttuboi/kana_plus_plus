import 'package:hive/hive.dart';
import 'package:kwriting/core/core.dart';
import 'package:kwriting/features/settings/settings.dart';

class WritingHandRepository implements IWritingHandRepository {
  late Box _box;

  Future<void> load() async {
    _box = (Hive.isBoxOpen(BoxTag.settings)) ? Hive.box(BoxTag.settings) : await Hive.openBox(BoxTag.settings);
  }

  @override
  WritingHand getWritingHandSelected() {
    final writingHandIndex = Database.storage.getInt(DatabaseTag.writingHand, defaultValue: WritingHand.right.index);
    return WritingHand.values[writingHandIndex];
  }

  @override
  void setWritingHandSelected(WritingHand value) {
    Database.storage.setInt(DatabaseTag.writingHand, value.index);
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
