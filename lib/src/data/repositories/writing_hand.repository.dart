import 'package:kana_plus_plus/src/data/singletons/database.dart';
import 'package:kana_plus_plus/src/data/utils/consts.dart';
import 'package:kana_plus_plus/src/domain/repositories/writing_hand.interface.repository.dart';
import 'package:kana_plus_plus/src/domain/utils/writing_hand.dart';

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
