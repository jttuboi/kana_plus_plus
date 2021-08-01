import 'package:kana_plus_plus/src/domain/entities/writing_hand.dart';
import 'package:kana_plus_plus/src/domain/entities/writing_hand_data.entity.dart';

abstract class IWritingHandRepository {
  WritingHand getWritingHandSelected();

  void setWritingHandSelected(WritingHand value);

  List<WritingHandData> getWritingHandData();
}
