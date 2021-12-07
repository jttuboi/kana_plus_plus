import 'package:flutter_test/flutter_test.dart';
import 'package:kwriting/presentation/training/training.dart';

void main() {
  group('KanaViewerStatus', () {
    test('returns comparison', () {
      const statusSelect = KanaViewerStatus.select;
      expect(statusSelect.isSelect, isTrue);
      expect(statusSelect.isNormal, isFalse);
      expect(statusSelect.isCorrect, isFalse);
      expect(statusSelect.isWrong, isFalse);

      const statusNormal = KanaViewerStatus.normal;
      expect(statusNormal.isSelect, isFalse);
      expect(statusNormal.isNormal, isTrue);
      expect(statusNormal.isCorrect, isFalse);
      expect(statusNormal.isWrong, isFalse);

      const statusCorrect = KanaViewerStatus.correct;
      expect(statusCorrect.isSelect, isFalse);
      expect(statusCorrect.isNormal, isFalse);
      expect(statusCorrect.isCorrect, isTrue);
      expect(statusCorrect.isWrong, isFalse);

      const statusWrong = KanaViewerStatus.wrong;
      expect(statusWrong.isSelect, isFalse);
      expect(statusWrong.isNormal, isFalse);
      expect(statusWrong.isCorrect, isFalse);
      expect(statusWrong.isWrong, isTrue);
    });
  });
}
