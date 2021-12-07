import 'package:flutter_test/flutter_test.dart';
import 'package:kwriting/presentation/training/training.dart';

void main() {
  group('WriterInitial', () {
    test('sets properly', () {
      const state = WriterInitial();

      expect(state.strokesForDraw, []);
      expect(state.userStrokes, []);
      expect(state.corrects, []);
    });
  });

  group('WriterWait', () {
    test('sets properly', () {
      const state = WriterWait(
        kanaId: 'id',
        currentIndexStroke: 2,
        strokesForDraw: ['stroke 1', 'stroke 2', 'stroke 3'],
        userStrokes: [
          [Offset(1, 1)],
          [Offset(2, 2), Offset(3, 3)],
          [Offset(4, 4), Offset(5, 5), Offset(6, 6)],
        ],
        corrects: [true, false, true],
      );

      expect(state.kanaId, 'id');
      expect(state.currentIndexStroke, 2);
      expect(state.strokesForDraw, ['stroke 1', 'stroke 2', 'stroke 3']);
      expect(state.userStrokes, const [
        [Offset(1, 1)],
        [Offset(2, 2), Offset(3, 3)],
        [Offset(4, 4), Offset(5, 5), Offset(6, 6)],
      ]);
      expect(state.corrects, [true, false, true]);
    });

    test('copies when uses copyWith', () {
      const state = WriterWait(
        kanaId: 'id',
        currentIndexStroke: 2,
        strokesForDraw: ['stroke 1', 'stroke 2', 'stroke 3'],
        userStrokes: [
          [Offset(1, 1)],
          [Offset(2, 2), Offset(3, 3)],
          [Offset(4, 4), Offset(5, 5), Offset(6, 6)],
        ],
        corrects: [true, false, true],
      );

      expect(
        state.copyWith(currentIndexStroke: 10, corrects: [false, false, false]),
        const WriterWait(kanaId: 'id', currentIndexStroke: 10, strokesForDraw: [
          'stroke 1',
          'stroke 2',
          'stroke 3'
        ], userStrokes: [
          [Offset(1, 1)],
          [Offset(2, 2), Offset(3, 3)],
          [Offset(4, 4), Offset(5, 5), Offset(6, 6)],
        ], corrects: [
          false,
          false,
          false
        ]),
      );
      expect(
        state.copyWith(userStrokes: const [
          [Offset(11, 11)],
          [Offset(22, 22), Offset(33, 33)],
          [Offset(44, 44), Offset(55, 55), Offset(66, 66)],
        ]),
        const WriterWait(
          kanaId: 'id',
          currentIndexStroke: 2,
          strokesForDraw: ['stroke 1', 'stroke 2', 'stroke 3'],
          userStrokes: [
            [Offset(11, 11)],
            [Offset(22, 22), Offset(33, 33)],
            [Offset(44, 44), Offset(55, 55), Offset(66, 66)],
          ],
          corrects: [true, false, true],
        ),
      );
    });

    test('checks if is last stroke', () {
      const state = WriterWait(
        currentIndexStroke: 1,
        strokesForDraw: ['stroke 1', 'stroke 2', 'stroke 3'],
      );

      expect(state.isLastStroke, isFalse);
      expect(state.copyWith(currentIndexStroke: 2).isLastStroke, isTrue);
    });
  });

  group('WriterEnd', () {
    test('sets properly', () {
      const state = WriterEnd(
        kanaId: 'id',
        strokesForDraw: ['stroke 1', 'stroke 2', 'stroke 3'],
        userStrokes: [
          [Offset(1, 1)],
          [Offset(2, 2), Offset(3, 3)],
          [Offset(4, 4), Offset(5, 5), Offset(6, 6)],
        ],
        corrects: [true, false, true],
      );

      expect(state.kanaId, 'id');
      expect(state.strokesForDraw, ['stroke 1', 'stroke 2', 'stroke 3']);
      expect(state.userStrokes, const [
        [Offset(1, 1)],
        [Offset(2, 2), Offset(3, 3)],
        [Offset(4, 4), Offset(5, 5), Offset(6, 6)],
      ]);
      expect(state.corrects, [true, false, true]);
    });
  });
}
