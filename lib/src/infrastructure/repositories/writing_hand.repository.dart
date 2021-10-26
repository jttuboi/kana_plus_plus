import 'package:kwriting/src/domain/repositories/writing_hand.interface.repository.dart';
import 'package:kwriting/src/domain/utils/writing_hand.dart';
import 'package:kwriting/src/infrastructure/singletons/database.dart';
import 'package:kwriting/src/infrastructure/utils/consts.dart';

class WritingHandRepository implements IWritingHandRepository {
  @override
  WritingHand getWritingHandSelected() {
    final int writingHandIndex = Database.getInt(DatabaseTag.writingHand, defaultValue: WritingHand.right.index);
    return WritingHand.values[writingHandIndex];
  }

  @override
  void setWritingHandSelected(WritingHand value) {
    Database.setInt(DatabaseTag.writingHand, value.index);
  }
}
