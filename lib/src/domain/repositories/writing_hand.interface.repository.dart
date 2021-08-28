import 'package:kana_plus_plus/src/domain/entities/writing_hand.dart';

abstract class IWritingHandRepository {
  WritingHand getWritingHandSelected();

  void setWritingHandSelected(WritingHand value);
}
