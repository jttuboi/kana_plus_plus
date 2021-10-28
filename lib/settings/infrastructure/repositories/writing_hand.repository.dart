import 'package:kwriting/core/core.dart';
import 'package:kwriting/settings/settings.dart';
import 'package:kwriting/src/infrastructure/singletons/database.dart';

class WritingHandRepository implements IWritingHandRepository {
  @override
  WritingHand getWritingHandSelected() {
    final writingHandIndex = Database.getInt(DatabaseTag.writingHand, defaultValue: WritingHand.right.index);
    return WritingHand.values[writingHandIndex];
  }

  @override
  void setWritingHandSelected(WritingHand value) {
    Database.setInt(DatabaseTag.writingHand, value.index);
  }
}
