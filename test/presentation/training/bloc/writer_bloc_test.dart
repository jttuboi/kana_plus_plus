import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kwriting/presentation/training/training.dart';
import 'package:mocktail/mocktail.dart';

import '../../../utils/mocks.dart';

void main() {
  group('WriterBloc', () {
    final mockStrokeReducer = MockStrokeReducer();
    final mockKanaChecker = MockKanaChecker();

    blocTest<WriterBloc, WriterState>(
      'emits [WriterWait] when WriterStarted is added',
      setUp: () => when(mockKanaChecker.initialize).thenAnswer((_) => Future.value()),
      build: () => WriterBloc(strokeReducer: mockStrokeReducer, kanaChecker: mockKanaChecker),
      act: (bloc) => bloc.add(const WriterStarted(kanaId: 'a', strokesForDraw: ['stroke a'])),
      expect: () => const <WriterState>[
        WriterWait(kanaId: 'a', strokesForDraw: ['stroke a'])
      ],
    );

    blocTest<WriterBloc, WriterState>(
      'emits [WriterWait] when StrokeWritten is added and is not the last stroke',
      setUp: () {
        when(mockKanaChecker.initialize).thenAnswer((_) => Future.value());

        const offsetsOfStrokeWritten = [Offset.zero, Offset(25, 25), Offset(50, 50), Offset(75, 75), Offset(100, 100)];
        when(() => mockStrokeReducer.reduce(offsetsOfStrokeWritten)).thenReturn(offsetsOfStrokeWritten);
        const offsetsOfStrokeWrittenNormalized = [Offset.zero, Offset(0.25, 0.25), Offset(0.5, 0.5), Offset(0.75, 0.75), Offset(1, 1)];
        when(() => mockKanaChecker.checkKana('a', 1, offsetsOfStrokeWrittenNormalized)).thenReturn(false);
      },
      seed: () => const WriterWait(currentIndexStroke: 1, kanaId: 'a', strokesForDraw: [
        'stroke a',
        'stroke b',
        'stroke c'
      ], userStrokes: [
        [Offset.zero, Offset(0.1, 0.1)]
      ], corrects: [
        true
      ]),
      build: () => WriterBloc(strokeReducer: mockStrokeReducer, kanaChecker: mockKanaChecker),
      act: (bloc) => bloc.add(const StrokeWritten([Offset.zero, Offset(25, 25), Offset(50, 50), Offset(75, 75), Offset(100, 100)], 100)),
      expect: () => const <WriterState>[
        WriterWait(currentIndexStroke: 2, kanaId: 'a', strokesForDraw: [
          'stroke a',
          'stroke b',
          'stroke c'
        ], userStrokes: [
          [Offset.zero, Offset(0.1, 0.1)],
          [Offset.zero, Offset(0.25, 0.25), Offset(0.5, 0.5), Offset(0.75, 0.75), Offset(1, 1)]
        ], corrects: [
          true,
          false
        ])
      ],
    );

    blocTest<WriterBloc, WriterState>(
      'emits [WriterEnd] when StrokeWritten is added and is the last stroke',
      setUp: () {
        when(mockKanaChecker.initialize).thenAnswer((_) => Future.value());

        const offsetsOfStrokeWritten = [Offset.zero, Offset(50, 50), Offset(100, 100)];
        when(() => mockStrokeReducer.reduce(offsetsOfStrokeWritten)).thenReturn(offsetsOfStrokeWritten);
        const offsetsOfStrokeWrittenNormalized = [Offset.zero, Offset(0.5, 0.5), Offset(1, 1)];
        when(() => mockKanaChecker.checkKana('a', 2, offsetsOfStrokeWrittenNormalized)).thenReturn(true);
      },
      seed: () => const WriterWait(currentIndexStroke: 2, kanaId: 'a', strokesForDraw: [
        'stroke a',
        'stroke b',
        'stroke c'
      ], userStrokes: [
        [Offset.zero, Offset(0.1, 0.1)],
        [Offset.zero, Offset(0.25, 0.25), Offset(0.5, 0.5), Offset(0.75, 0.75), Offset(1, 1)]
      ], corrects: [
        true,
        false
      ]),
      build: () => WriterBloc(strokeReducer: mockStrokeReducer, kanaChecker: mockKanaChecker),
      act: (bloc) => bloc.add(const StrokeWritten([Offset.zero, Offset(50, 50), Offset(100, 100)], 100)),
      expect: () => const <WriterState>[
        WriterEnd(kanaId: 'a', strokesForDraw: [
          'stroke a',
          'stroke b',
          'stroke c'
        ], userStrokes: [
          [Offset.zero, Offset(0.1, 0.1)],
          [Offset.zero, Offset(0.25, 0.25), Offset(0.5, 0.5), Offset(0.75, 0.75), Offset(1, 1)],
          [Offset.zero, Offset(0.5, 0.5), Offset(1, 1)]
        ], corrects: [
          true,
          false,
          true
        ])
      ],
    );
  });

  group('ListOffsetExtension', () {
    test('normalizes all offset to start and end canvas limit', () {
      const listNotNormalized = <Offset>[Offset.zero, Offset(25, 25), Offset(50, 50), Offset(75, 75), Offset(100, 100)];
      const startCanvasLimit = 0.0;
      const endCanvasLimit = 100.0;
      expect(listNotNormalized.toNormalizedList(startCanvasLimit, endCanvasLimit),
          const [Offset.zero, Offset(0.25, 0.25), Offset(0.5, 0.5), Offset(0.75, 0.75), Offset(1, 1)]);
    });
  });
}
