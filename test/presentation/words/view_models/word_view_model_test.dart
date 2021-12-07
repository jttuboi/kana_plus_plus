import 'package:flutter_test/flutter_test.dart';
import 'package:kwriting/domain/domain.dart';
import 'package:kwriting/presentation/words/words.dart';

void main() {
  group('WordViewModel', () {
    test('renders correctly', () {
      const viewModel = WordViewModel(
        id: 'id 1',
        romaji: 'romaji 1',
        kanaType: KanaType.both,
        imageUrl: 'imageUrl',
        translate: 'translate',
        kanas: [
          KanaViewModel(
            id: 'id 2',
            kanaType: KanaType.katakana,
            romaji: 'romaji 2',
            strokes: ['strokes 1', 'strokes 2'],
            correctCount: 1,
            wrongCount: 2,
          ),
        ],
        correctCount: 3,
        wrongCount: 4,
      );

      expect(viewModel.id, 'id 1');
      expect(viewModel.romaji, 'romaji 1');
      expect(viewModel.kanaType, KanaType.both);
      expect(viewModel.imageUrl, 'imageUrl');
      expect(viewModel.translate, 'translate');
      expect(viewModel.correctCount, 3);
      expect(viewModel.wrongCount, 4);
      expect(viewModel.kanas, const [
        KanaViewModel(
          id: 'id 2',
          kanaType: KanaType.katakana,
          romaji: 'romaji 2',
          strokes: ['strokes 1', 'strokes 2'],
          correctCount: 1,
          wrongCount: 2,
        )
      ]);
    });

    test('gets WordViewModel from WordModel', () {
      final viewModel = WordViewModel.fromWordModel(
        const WordModel(
            id: 'あめ',
            romaji: 'ame',
            kanaType: KanaType.hiragana,
            imageUrl: 'imageUrl 1',
            translate: TranslateModel(
              id: 'あめ',
              english: 'rain',
              portuguese: 'chuva',
              spanish: 'lluva',
            ),
            kanas: [
              KanaModel(id: 'あ', kanaType: KanaType.katakana, romaji: 'a', strokes: ['stroke a']),
              KanaModel(id: 'め', kanaType: KanaType.katakana, romaji: 'me', strokes: ['stroke me']),
            ]),
        languageCode: 'pt',
        correctWordCount: const {'あめ': 4},
        wrongWordCount: const {'あめ': 3},
        correctKanaCount: const {'あ': 2},
        wrongKanaCount: const {'め': 1},
      );

      expect(
        viewModel,
        const WordViewModel(
          id: 'あめ',
          romaji: 'ame',
          kanaType: KanaType.hiragana,
          imageUrl: 'imageUrl 1',
          translate: 'chuva',
          kanas: [
            KanaViewModel(
              id: 'あ',
              kanaType: KanaType.katakana,
              romaji: 'a',
              strokes: ['stroke a'],
              correctCount: 2,
              wrongCount: 0,
            ),
            KanaViewModel(
              id: 'め',
              kanaType: KanaType.katakana,
              romaji: 'me',
              strokes: ['stroke me'],
              correctCount: 0,
              wrongCount: 1,
            ),
          ],
          correctCount: 4,
          wrongCount: 3,
        ),
      );
    });
  });
}
