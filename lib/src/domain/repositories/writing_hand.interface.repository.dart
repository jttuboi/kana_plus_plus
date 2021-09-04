import 'package:kana_plus_plus/src/domain/core/writing_hand.dart';

abstract class IWritingHandRepository {
  WritingHand getWritingHandSelected();

  void setWritingHandSelected(WritingHand value);
}
