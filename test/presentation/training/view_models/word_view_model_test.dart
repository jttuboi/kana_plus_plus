import 'package:flutter_test/flutter_test.dart';
import 'package:kwriting/domain/domain.dart';
import 'package:kwriting/presentation/training/training.dart';

void main() {
  group('WordViewModel', () {
    test('sets properly', () {
      const viewModel = WordViewModel(
        id: 'id 1',
        imageUrl: 'imageUrl 1',
        translate: 'translate 1',
        kanas: [
          KanaViewModel(id: 'id', status: KanaViewerStatus.correct, kanaType: KanaType.katakana, romaji: 'romaji 2', strokes: ['strokes 2'])
        ],
      );

      expect(viewModel.id, 'id 1');
      expect(viewModel.imageUrl, 'imageUrl 1');
      expect(viewModel.translate, 'translate 1');
      expect(viewModel.kanas, const [
        KanaViewModel(id: 'id', status: KanaViewerStatus.correct, kanaType: KanaType.katakana, romaji: 'romaji 2', strokes: ['strokes 2'])
      ]);
    });

    test('gets WordViewModel from word model when uses fromWordModel', () {
      expect(
        WordViewModel.fromWordModel(
          const WordModel(
            id: 'word id',
            romaji: '',
            kanaType: KanaType.both,
            imageUrl: 'imageUrl 1',
            translate: TranslateModel(id: 'word id', english: 'english', portuguese: '', spanish: ''),
            kanas: [
              KanaModel(id: 'kana 21', kanaType: KanaType.hiragana, romaji: 'romaji 21', strokes: ['strokes 21']),
              KanaModel(id: 'kana 22', kanaType: KanaType.katakana, romaji: 'romaji 22', strokes: ['strokes 22']),
              KanaModel(id: 'kana 23', kanaType: KanaType.hiragana, romaji: 'romaji 23', strokes: ['strokes 23']),
              KanaModel(id: 'kana 24', kanaType: KanaType.katakana, romaji: 'romaji 24', strokes: ['strokes 24']),
            ],
          ),
          languageCode: 'en',
        ),
        const WordViewModel(
          id: 'word id',
          imageUrl: 'imageUrl 1',
          translate: 'english',
          kanas: [
            // OBS: only the first status is select, other is normal
            KanaViewModel(id: 'kana 21', status: KanaViewerStatus.select, kanaType: KanaType.hiragana, romaji: 'romaji 21', strokes: ['strokes 21']),
            KanaViewModel(id: 'kana 22', status: KanaViewerStatus.normal, kanaType: KanaType.katakana, romaji: 'romaji 22', strokes: ['strokes 22']),
            KanaViewModel(id: 'kana 23', status: KanaViewerStatus.normal, kanaType: KanaType.hiragana, romaji: 'romaji 23', strokes: ['strokes 23']),
            KanaViewModel(id: 'kana 24', status: KanaViewerStatus.normal, kanaType: KanaType.katakana, romaji: 'romaji 24', strokes: ['strokes 24']),
          ],
        ),
      );
    });

    test('copies when uses copyWith', () {
      const viewModel = WordViewModel(
        id: 'id 1',
        imageUrl: 'imageUrl 1',
        translate: 'translate 1',
        kanas: [
          KanaViewModel(id: 'id', status: KanaViewerStatus.correct, kanaType: KanaType.katakana, romaji: 'romaji 2', strokes: ['strokes 2'])
        ],
      );

      expect(
        viewModel.copyWith(id: 'new id', translate: 'new translate'),
        const WordViewModel(
          id: 'new id',
          imageUrl: 'imageUrl 1',
          translate: 'new translate',
          kanas: [
            KanaViewModel(id: 'id', status: KanaViewerStatus.correct, kanaType: KanaType.katakana, romaji: 'romaji 2', strokes: ['strokes 2'])
          ],
        ),
      );
      expect(
        viewModel.copyWith(imageUrl: 'new imageUrl', kanas: const [
          KanaViewModel(id: 'new id', status: KanaViewerStatus.wrong, kanaType: KanaType.hiragana, romaji: 'new romaji', strokes: ['new strokes '])
        ]),
        const WordViewModel(
          id: 'id 1',
          imageUrl: 'new imageUrl',
          translate: 'translate 1',
          kanas: [
            KanaViewModel(id: 'new id', status: KanaViewerStatus.wrong, kanaType: KanaType.hiragana, romaji: 'new romaji', strokes: ['new strokes '])
          ],
        ),
      );
    });

    test('converts to WordStats when uses toWordStats', () {
      const wordViewModelAllCorrect = WordViewModel(
        id: 'word all correct',
        imageUrl: '',
        translate: '',
        kanas: [
          KanaViewModel(id: 'kana id 1', status: KanaViewerStatus.correct, kanaType: KanaType.katakana, romaji: '', strokes: []),
          KanaViewModel(id: 'kana id 2', status: KanaViewerStatus.correct, kanaType: KanaType.katakana, romaji: '', strokes: []),
          KanaViewModel(id: 'kana id 3', status: KanaViewerStatus.correct, kanaType: KanaType.katakana, romaji: '', strokes: []),
        ],
      );

      expect(
        wordViewModelAllCorrect.toWordStats(),
        const WordStats(
          id: 'word all correct',
          correct: true,
          kanas: [
            KanaStats(id: 'kana id 1', correct: true, strokes: []),
            KanaStats(id: 'kana id 2', correct: true, strokes: []),
            KanaStats(id: 'kana id 3', correct: true, strokes: []),
          ],
        ),
      );

      const wordViewModelOneWrong = WordViewModel(
        id: 'word one wrong',
        imageUrl: '',
        translate: '',
        kanas: [
          KanaViewModel(id: 'kana id 1', status: KanaViewerStatus.wrong, kanaType: KanaType.katakana, romaji: '', strokes: []),
          KanaViewModel(id: 'kana id 2', status: KanaViewerStatus.correct, kanaType: KanaType.katakana, romaji: '', strokes: []),
          KanaViewModel(id: 'kana id 3', status: KanaViewerStatus.correct, kanaType: KanaType.katakana, romaji: '', strokes: []),
        ],
      );

      expect(
        wordViewModelOneWrong.toWordStats(),
        const WordStats(
          id: 'word one wrong',
          correct: false,
          kanas: [
            KanaStats(id: 'kana id 1', correct: false, strokes: []),
            KanaStats(id: 'kana id 2', correct: true, strokes: []),
            KanaStats(id: 'kana id 3', correct: true, strokes: []),
          ],
        ),
      );

      const wordViewModelTwoWrong = WordViewModel(
        id: 'word two wrong',
        imageUrl: '',
        translate: '',
        kanas: [
          KanaViewModel(id: 'kana id 1', status: KanaViewerStatus.wrong, kanaType: KanaType.katakana, romaji: '', strokes: []),
          KanaViewModel(id: 'kana id 2', status: KanaViewerStatus.correct, kanaType: KanaType.katakana, romaji: '', strokes: []),
          KanaViewModel(id: 'kana id 3', status: KanaViewerStatus.wrong, kanaType: KanaType.katakana, romaji: '', strokes: []),
        ],
      );

      expect(
        wordViewModelTwoWrong.toWordStats(),
        const WordStats(
          id: 'word two wrong',
          correct: false,
          kanas: [
            KanaStats(id: 'kana id 1', correct: false, strokes: []),
            KanaStats(id: 'kana id 2', correct: true, strokes: []),
            KanaStats(id: 'kana id 3', correct: false, strokes: []),
          ],
        ),
      );

      const wordViewModelAllWrong = WordViewModel(
        id: 'word all wrong',
        imageUrl: '',
        translate: '',
        kanas: [
          KanaViewModel(id: 'kana id 1', status: KanaViewerStatus.wrong, kanaType: KanaType.katakana, romaji: '', strokes: []),
          KanaViewModel(id: 'kana id 2', status: KanaViewerStatus.wrong, kanaType: KanaType.katakana, romaji: '', strokes: []),
          KanaViewModel(id: 'kana id 3', status: KanaViewerStatus.wrong, kanaType: KanaType.katakana, romaji: '', strokes: []),
        ],
      );

      expect(
        wordViewModelAllWrong.toWordStats(),
        const WordStats(
          id: 'word all wrong',
          correct: false,
          kanas: [
            KanaStats(id: 'kana id 1', correct: false, strokes: []),
            KanaStats(id: 'kana id 2', correct: false, strokes: []),
            KanaStats(id: 'kana id 3', correct: false, strokes: []),
          ],
        ),
      );
    });
  });
}
