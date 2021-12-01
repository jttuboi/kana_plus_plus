import 'package:flutter_test/flutter_test.dart';
import 'package:kwriting/domain/domain.dart';

void main() {
  group('WordStats', () {
    test('must initiate properly values', () {
      expect(wordStats.id, 'word stats id');
      expect(wordStats.correct, isFalse);
      expect(wordStats.kanas, const [
        KanaStats(id: '1', correct: true, strokes: []),
        KanaStats(id: '2', correct: false, strokes: []),
      ]);
    });
  });
}

const wordStats = WordStats(
  id: 'word stats id',
  correct: false,
  kanas: [
    KanaStats(id: '1', correct: true, strokes: []),
    KanaStats(id: '2', correct: false, strokes: []),
  ],
);
