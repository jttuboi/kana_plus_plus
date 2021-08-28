import 'package:kana_plus_plus/src/data/datasources/cache.singleton.dart';
import 'package:kana_plus_plus/src/data/utils/consts.dart';
import 'package:kana_plus_plus/src/domain/entities/writing_hand.dart';
import 'package:kana_plus_plus/src/domain/repositories/writing_hand.interface.repository.dart';

class WritingHandRepository implements IWritingHandRepository {
  @override
  WritingHand getWritingHandSelected() {
    final int writingHandIndex = Cache.getInt(SettingsPref.writingHand, defaultValue: WritingHand.right.index);
    return WritingHand.values[writingHandIndex];
  }

  @override
  void setWritingHandSelected(WritingHand value) {
    Cache.setInt(SettingsPref.writingHand, value.index);
  }
}
