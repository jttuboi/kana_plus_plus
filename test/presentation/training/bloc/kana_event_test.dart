import 'package:flutter_test/flutter_test.dart';
import 'package:kwriting/domain/domain.dart';
import 'package:kwriting/presentation/training/training.dart';

void main() {
  group('KanaUpdated', () {
    test('sets properly', () {
      const state = KanaUpdated(
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

  group('KanaPageChanged', () {
    test('sets properly', () {
      const state = KanaPageChanged(
        wordIndex: 5,
        words: [
          WordViewModel(id: 'id 1', imageUrl: 'imageUrl 1', translate: 'translate 1', kanas: [
            KanaViewModel(id: 'id 2', status: KanaViewerStatus.normal, kanaType: KanaType.both, romaji: 'romaji 2', strokes: ['strokes 2'])
          ]),
        ],
      );

      expect(state.wordIndex, 5);
      expect(state.words, const [
        WordViewModel(id: 'id 1', imageUrl: 'imageUrl 1', translate: 'translate 1', kanas: [
          KanaViewModel(id: 'id 2', status: KanaViewerStatus.normal, kanaType: KanaType.both, romaji: 'romaji 2', strokes: ['strokes 2'])
        ]),
      ]);
    });
  });
}
