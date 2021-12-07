import 'package:flutter_test/flutter_test.dart';
import 'package:kwriting/domain/domain.dart';
import 'package:kwriting/presentation/training/training.dart';

void main() {
  group('ListStarted', () {
    test('sets properly', () {
      const state = ListStarted(
        TrainingSettings(showHint: true, kanaType: KanaType.hiragana, quantityOfWords: 12, languageCode: 'pt'),
      );

      expect(
        state.trainingSettings,
        const TrainingSettings(showHint: true, kanaType: KanaType.hiragana, quantityOfWords: 12, languageCode: 'pt'),
      );
    });
  });

  group('ListUpdated', () {
    test('sets properly', () {
      const state = ListUpdated(
        wordIndex: 5,
        kanaIndex: 10,
        words: [
          WordViewModel(id: 'id 1', imageUrl: 'imageUrl 1', translate: 'translate 1', kanas: [
            KanaViewModel(id: 'id 2', status: KanaViewerStatus.normal, kanaType: KanaType.both, romaji: 'romaji 2', strokes: ['strokes 2'])
          ]),
        ],
      );

      expect(state.wordIndex, 5);
      expect(state.kanaIndex, 10);
      expect(state.words, const [
        WordViewModel(id: 'id 1', imageUrl: 'imageUrl 1', translate: 'translate 1', kanas: [
          KanaViewModel(id: 'id 2', status: KanaViewerStatus.normal, kanaType: KanaType.both, romaji: 'romaji 2', strokes: ['strokes 2'])
        ]),
      ]);
    });
  });

  group('ListPreUpdated', () {
    test('sets properly', () {
      const state = ListPreUpdated(
        wordIndex: 5,
        kanaIndex: 10,
        words: [
          WordViewModel(id: 'id 1', imageUrl: 'imageUrl 1', translate: 'translate 1', kanas: [
            KanaViewModel(id: 'id 2', status: KanaViewerStatus.normal, kanaType: KanaType.both, romaji: 'romaji 2', strokes: ['strokes 2'])
          ]),
        ],
      );

      expect(state.wordIndex, 5);
      expect(state.kanaIndex, 10);
      expect(state.words, const [
        WordViewModel(id: 'id 1', imageUrl: 'imageUrl 1', translate: 'translate 1', kanas: [
          KanaViewModel(id: 'id 2', status: KanaViewerStatus.normal, kanaType: KanaType.both, romaji: 'romaji 2', strokes: ['strokes 2'])
        ]),
      ]);
    });
  });

  group('ListKanaChanged', () {
    test('sets properly', () {
      const state = ListKanaChanged(
        wordIndex: 5,
        kanaIndex: 10,
        words: [
          WordViewModel(id: 'id 1', imageUrl: 'imageUrl 1', translate: 'translate 1', kanas: [
            KanaViewModel(id: 'id 2', status: KanaViewerStatus.normal, kanaType: KanaType.both, romaji: 'romaji 2', strokes: ['strokes 2'])
          ]),
        ],
      );

      expect(state.wordIndex, 5);
      expect(state.kanaIndex, 10);
      expect(state.words, const [
        WordViewModel(id: 'id 1', imageUrl: 'imageUrl 1', translate: 'translate 1', kanas: [
          KanaViewModel(id: 'id 2', status: KanaViewerStatus.normal, kanaType: KanaType.both, romaji: 'romaji 2', strokes: ['strokes 2'])
        ]),
      ]);
    });
  });

  group('ListWordChanged', () {
    test('sets properly', () {
      const state = ListWordChanged(
        wordIndex: 5,
        words: [
          WordViewModel(id: 'id 1', imageUrl: 'imageUrl 1', translate: 'translate 1', kanas: [
            KanaViewModel(id: 'id 2', status: KanaViewerStatus.normal, kanaType: KanaType.both, romaji: 'romaji 2', strokes: ['strokes 2'])
          ]),
        ],
      );

      expect(state.wordIndex, 5);
      expect(state.kanaIndex, 0);
      expect(state.words, const [
        WordViewModel(id: 'id 1', imageUrl: 'imageUrl 1', translate: 'translate 1', kanas: [
          KanaViewModel(id: 'id 2', status: KanaViewerStatus.normal, kanaType: KanaType.both, romaji: 'romaji 2', strokes: ['strokes 2'])
        ]),
      ]);
    });
  });

  group('ListPageAnimationChanged', () {
    test('sets properly', () {
      const state = ListPageAnimationChanged(
        changePageDurationInMilliseconds: 15,
        wordIndex: 5,
        kanaIndex: 10,
        words: [
          WordViewModel(id: 'id 1', imageUrl: 'imageUrl 1', translate: 'translate 1', kanas: [
            KanaViewModel(id: 'id 2', status: KanaViewerStatus.normal, kanaType: KanaType.both, romaji: 'romaji 2', strokes: ['strokes 2'])
          ]),
        ],
      );

      expect(state.changePageDurationInMilliseconds, 15);
      expect(state.wordIndex, 5);
      expect(state.kanaIndex, 10);
      expect(state.words, const [
        WordViewModel(id: 'id 1', imageUrl: 'imageUrl 1', translate: 'translate 1', kanas: [
          KanaViewModel(id: 'id 2', status: KanaViewerStatus.normal, kanaType: KanaType.both, romaji: 'romaji 2', strokes: ['strokes 2'])
        ]),
      ]);
    });
  });

  group('ListTrainingEnded', () {
    test('sets properly', () {
      const state = ListTrainingEnded([
        WordViewModel(id: 'id 1', imageUrl: 'imageUrl 1', translate: 'translate 1', kanas: [
          KanaViewModel(id: 'id 2', status: KanaViewerStatus.normal, kanaType: KanaType.both, romaji: 'romaji 2', strokes: ['strokes 2'])
        ]),
      ]);

      expect(state.words, const [
        WordViewModel(id: 'id 1', imageUrl: 'imageUrl 1', translate: 'translate 1', kanas: [
          KanaViewModel(id: 'id 2', status: KanaViewerStatus.normal, kanaType: KanaType.both, romaji: 'romaji 2', strokes: ['strokes 2'])
        ]),
      ]);
    });
  });
}
