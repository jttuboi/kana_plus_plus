import 'package:kwriting/core/core.dart';

abstract class IWritingHandRepository {
  Future<WritingHand> getWritingHand();

  Future<void> updateWritingHand(WritingHand writingHand);
}
