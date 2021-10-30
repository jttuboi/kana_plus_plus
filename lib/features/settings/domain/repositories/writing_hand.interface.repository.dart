import 'package:kwriting/core/core.dart';

abstract class IWritingHandRepository {
  WritingHand getWritingHandSelected();

  void setWritingHandSelected(WritingHand value);

  Future<WritingHand> getWritingHand();

  Future<void> updateWritingHand(WritingHand writingHand);
}
