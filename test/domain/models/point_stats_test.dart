import 'package:flutter_test/flutter_test.dart';
import 'package:kwriting/domain/domain.dart';

void main() {
  group('PointStats', () {
    test('must initiate properly values', () {
      expect(pointStats.x, 3);
      expect(pointStats.y, 2);
    });

    test('fromOffset creates PointStats from offset', () {
      final result = PointStats.fromOffset(const Offset(3, 2));
      expect(result, pointStats);
    });
  });
}

const pointStats = PointStats(x: 3, y: 2);
