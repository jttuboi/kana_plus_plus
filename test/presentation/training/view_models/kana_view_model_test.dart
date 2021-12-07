import 'package:flutter_test/flutter_test.dart';
import 'package:kwriting/domain/domain.dart';
import 'package:kwriting/presentation/training/training.dart';

void main() {
  group('KanaViewModel', () {
    test('sets properly', () {
      const viewModel = KanaViewModel(
        id: 'id',
        status: KanaViewerStatus.correct,
        kanaType: KanaType.katakana,
        romaji: 'romaji',
        strokes: ['strokes'],
        userStrokes: [
          [Offset(1, 1)],
          [Offset(2, 2)],
        ],
      );

      expect(viewModel.id, 'id');
      expect(viewModel.status, KanaViewerStatus.correct);
      expect(viewModel.kanaType, KanaType.katakana);
      expect(viewModel.romaji, 'romaji');
      expect(viewModel.strokes, ['strokes']);
      expect(viewModel.userStrokes, const [
        [Offset(1, 1)],
        [Offset(2, 2)],
      ]);
    });

    test('gets KanaViewModel from word model when uses fromKanaModel (first kana = true)', () {
      expect(
        KanaViewModel.fromKanaModel(const KanaModel(id: 'kana', kanaType: KanaType.hiragana, romaji: 'romaji', strokes: ['strokes']), true),
        const KanaViewModel(id: 'kana', status: KanaViewerStatus.select, kanaType: KanaType.hiragana, romaji: 'romaji', strokes: ['strokes']),
      );
    });

    test('gets KanaViewModel from word model when uses fromKanaModel (first kana = false)', () {
      expect(
        KanaViewModel.fromKanaModel(const KanaModel(id: 'kana', kanaType: KanaType.hiragana, romaji: 'romaji', strokes: ['strokes']), false),
        const KanaViewModel(id: 'kana', status: KanaViewerStatus.normal, kanaType: KanaType.hiragana, romaji: 'romaji', strokes: ['strokes']),
      );
    });

    test('copies when uses copyWith', () {
      const viewModel = KanaViewModel(
        id: 'id',
        status: KanaViewerStatus.correct,
        kanaType: KanaType.both,
        romaji: 'romaji',
        strokes: ['strokes'],
        userStrokes: [
          [Offset(1, 1)]
        ],
      );

      expect(
        viewModel.copyWith(id: 'new id', kanaType: KanaType.hiragana, strokes: ['new strokes']),
        const KanaViewModel(
          id: 'new id',
          status: KanaViewerStatus.correct,
          kanaType: KanaType.hiragana,
          romaji: 'romaji',
          strokes: ['new strokes'],
          userStrokes: [
            [Offset(1, 1)]
          ],
        ),
      );
      expect(
        viewModel.copyWith(status: KanaViewerStatus.wrong, romaji: 'new romaji', userStrokes: const [
          [Offset(2, 2)]
        ]),
        const KanaViewModel(
          id: 'id',
          status: KanaViewerStatus.wrong,
          kanaType: KanaType.both,
          romaji: 'new romaji',
          strokes: ['strokes'],
          userStrokes: [
            [Offset(2, 2)]
          ],
        ),
      );
    });

    test('converts to KanaStats when uses toKanaStats', () {
      const viewModelStatusCorrect = KanaViewModel(
        id: 'kana id',
        status: KanaViewerStatus.correct,
        kanaType: KanaType.both,
        romaji: '',
        strokes: [],
        userStrokes: [
          [Offset(123, 345)]
        ],
      );

      expect(
        viewModelStatusCorrect.toKanaStats(),
        const KanaStats(
          id: 'kana id',
          correct: true,
          strokes: [
            StrokeStats(points: [PointStats(x: 123, y: 345)])
          ],
        ),
      );

      const viewModelStatusWrong = KanaViewModel(
        id: 'kana id',
        status: KanaViewerStatus.wrong,
        kanaType: KanaType.both,
        romaji: '',
        strokes: [],
        userStrokes: [
          [Offset(123, 345)]
        ],
      );

      expect(
        viewModelStatusWrong.toKanaStats(),
        const KanaStats(
          id: 'kana id',
          correct: false,
          strokes: [
            StrokeStats(points: [PointStats(x: 123, y: 345)])
          ],
        ),
      );
    });
  });
}
