import 'package:kwriting/domain/domain.dart';

abstract class IWritingHandRepository {
  Future<WritingHand> getWritingHand();

  Future<void> updateWritingHand(WritingHand writingHand);
}
