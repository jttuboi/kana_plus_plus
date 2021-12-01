import 'package:flutter_test/flutter_test.dart';
import 'package:kwriting/domain/domain.dart';

void main() {
  group('KanaStats', () {
    test('must initiate properly values', () {
      expect(kanaStats.id, 'id 1');
      expect(kanaStats.correct, false);
      expect(kanaStats.strokes, [
        const StrokeStats(points: [PointStats(x: 1, y: 1)])
      ]);
    });
  });
}

const kanaStats = KanaStats(
  id: 'id 1',
  correct: false,
  strokes: [
    StrokeStats(points: [PointStats(x: 1, y: 1)])
  ],
);
