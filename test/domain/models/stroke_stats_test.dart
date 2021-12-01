import 'package:flutter_test/flutter_test.dart';
import 'package:kwriting/domain/domain.dart';

void main() {
  group('StrokeStats', () {
    test('must initiate properly values', () {
      expect(strokeStats.points[0], const PointStats(x: 1, y: 2));
      expect(strokeStats.points[1], const PointStats(x: 3, y: 4));
    });

    test('fromListOffset creates from list offset', () {
      final result = StrokeStats.fromListOffset(const [Offset(1, 2), Offset(3, 4)]);
      expect(result, strokeStats);
    });
  });
}

const strokeStats = StrokeStats(points: [
  PointStats(x: 1, y: 2),
  PointStats(x: 3, y: 4),
]);
