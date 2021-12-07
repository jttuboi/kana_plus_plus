import 'package:flutter_test/flutter_test.dart';
import 'package:kwriting/domain/domain.dart';
import 'package:kwriting/presentation/training/training.dart';

void main() {
  group('WordUpdated', () {
    test('sets properly', () {
      const state = WordUpdated(
        wordIndex: 4,
        words: [
          WordViewModel(
            id: 'id 1',
            imageUrl: 'imageUrl 1',
            translate: 'translate 1',
            kanas: [
              KanaViewModel(
                id: 'id 2',
                status: KanaViewerStatus.wrong,
                kanaType: KanaType.hiragana,
                romaji: 'romaji 2',
                strokes: ['stroke 2'],
              ),
            ],
          )
        ],
      );

      expect(state.wordIndex, 4);
      expect(state.words, const [
        WordViewModel(
          id: 'id 1',
          imageUrl: 'imageUrl 1',
          translate: 'translate 1',
          kanas: [
            KanaViewModel(
              id: 'id 2',
              status: KanaViewerStatus.wrong,
              kanaType: KanaType.hiragana,
              romaji: 'romaji 2',
              strokes: ['stroke 2'],
            ),
          ],
        )
      ]);
    });
  });
}
