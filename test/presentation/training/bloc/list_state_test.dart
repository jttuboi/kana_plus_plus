import 'package:flutter_test/flutter_test.dart';
import 'package:kwriting/domain/domain.dart';
import 'package:kwriting/presentation/training/training.dart';

void main() {
  group('ListInitial', () {
    test('sets properly', () {
      const state = ListInitial();

      expect(state, const ListInitial());
    });
  });

  group('ListReady', () {
    test('sets properly', () {
      const state = ListReady(
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

  group('ListPreReady', () {
    test('sets properly', () {
      const state = ListPreReady(
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

  group('ListKanaReady', () {
    test('sets properly', () {
      const state = ListKanaReady(
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

  group('ListWordReady', () {
    test('sets properly', () {
      const state = ListWordReady(
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

  group('ListPageReady', () {
    test('sets properly', () {
      const state = ListPageReady(
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

  group('TrainingEnded', () {
    test('sets properly', () {
      const state = TrainingEnded(
        words: [
          WordViewModel(id: 'id 1', imageUrl: 'imageUrl 1', translate: 'translate 1', kanas: [
            KanaViewModel(id: 'id 2', status: KanaViewerStatus.normal, kanaType: KanaType.both, romaji: 'romaji 2', strokes: ['strokes 2'])
          ]),
        ],
      );

      expect(state.words, const [
        WordViewModel(id: 'id 1', imageUrl: 'imageUrl 1', translate: 'translate 1', kanas: [
          KanaViewModel(id: 'id 2', status: KanaViewerStatus.normal, kanaType: KanaType.both, romaji: 'romaji 2', strokes: ['strokes 2'])
        ]),
      ]);
    });
  });
}
