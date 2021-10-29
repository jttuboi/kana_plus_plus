import 'package:kwriting/core/core.dart';
import 'package:kwriting/features/settings/settings.dart';

class WritingHandRepository implements IWritingHandRepository {
  @override
  WritingHand getWritingHandSelected() {
    final writingHandIndex = Database.storage.getInt(DatabaseTag.writingHand, defaultValue: WritingHand.right.index);
    return WritingHand.values[writingHandIndex];
  }

  @override
  void setWritingHandSelected(WritingHand value) {
    Database.storage.setInt(DatabaseTag.writingHand, value.index);
  }
}
