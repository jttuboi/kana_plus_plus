import 'package:flutter_test/flutter_test.dart';
import 'package:kwriting/presentation/training/training.dart';

void main() {
  group('WriterStarted', () {
    test('sets properly', () {
      const state = WriterStarted(
        kanaId: 'id',
        strokesForDraw: ['stroke 1', 'stroke 2', 'stroke 3'],
      );

      expect(state.kanaId, 'id');
      expect(state.strokesForDraw, ['stroke 1', 'stroke 2', 'stroke 3']);
    });
  });

  group('StrokeWritten', () {
    test('sets properly', () {
      const state = StrokeWritten([Offset(1, 1), Offset(2, 2), Offset(3, 3), Offset(4, 4), Offset(5, 5), Offset(6, 6)], 20);

      expect(state.stroke, const [Offset(1, 1), Offset(2, 2), Offset(3, 3), Offset(4, 4), Offset(5, 5), Offset(6, 6)]);
      expect(state.maxSize, 20);
    });
  });

  group('WriterReseted', () {
    test('sets properly', () {
      const state = WriterReseted();

      expect(state, const WriterReseted());
    });
  });
}
