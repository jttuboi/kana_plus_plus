import 'package:flutter_test/flutter_test.dart';
import 'package:kwriting/domain/domain.dart';

void main() {
  group('TrainingStats', () {
    test('must initiate properly values', () {
      expect(trainingStats.showHint, isFalse);
      expect(trainingStats.type, KanaType.katakana);
      expect(trainingStats.wordsQuantity, 12);
      expect(trainingStats.words, const [
        WordStats(id: 'word id 1', correct: true, kanas: []),
        WordStats(id: 'word id 2', correct: false, kanas: []),
      ]);
    });
  });
}

const trainingStats = TrainingStats(
  showHint: false,
  type: KanaType.katakana,
  wordsQuantity: 12,
  words: [
    WordStats(id: 'word id 1', correct: true, kanas: []),
    WordStats(id: 'word id 2', correct: false, kanas: []),
  ],
);
