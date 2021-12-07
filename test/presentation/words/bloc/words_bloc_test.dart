import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kwriting/domain/domain.dart';
import 'package:kwriting/presentation/words/words.dart';
import 'package:mocktail/mocktail.dart';

import '../../../utils/mocks.dart';

void main() {
  group('WordsBloc', () {
    final mockWordsRepository = MockWordsRepository();
    final mockStatisticsRepository = MockStatisticsRepository();

    blocTest<WordsBloc, WordsState>(
      'emits [WordsLoadSuccess] when WordsLoaded is added and data returns empty',
      setUp: () {
        when(mockWordsRepository.fetchTodos).thenAnswer((_) => Future.value([]));
        when(() => mockStatisticsRepository.specificWordCorrectQuantityByWordIds([])).thenAnswer((_) => Future.value({}));
        when(() => mockStatisticsRepository.specificWordWrongQuantityByWordIds([])).thenAnswer((_) => Future.value({}));
        when(() => mockStatisticsRepository.specificKanaCorrectQuantityByKanaIds([])).thenAnswer((_) => Future.value({}));
        when(() => mockStatisticsRepository.specificKanaWrongQuantityByKanaIds([])).thenAnswer((_) => Future.value({}));
      },
      build: () => WordsBloc(wordsRepository: mockWordsRepository, statisticsRepository: mockStatisticsRepository),
      act: (bloc) => bloc.add(const WordsLoaded('en')),
      expect: () => const [WordsLoadSuccess()],
    );

    blocTest<WordsBloc, WordsState>(
      'emits [WordsLoadFailure] when WordsLoaded is added and has any problem in the process',
      setUp: () {
        when(mockWordsRepository.fetchTodos).thenAnswer((_) => Future.value(inconsistentWordsModel));
        when(() => mockStatisticsRepository.specificWordCorrectQuantityByWordIds([])).thenAnswer((_) => Future.value({}));
        when(() => mockStatisticsRepository.specificWordWrongQuantityByWordIds([])).thenAnswer((_) => Future.value({}));
        when(() => mockStatisticsRepository.specificKanaCorrectQuantityByKanaIds([])).thenAnswer((_) => Future.value({}));
        when(() => mockStatisticsRepository.specificKanaWrongQuantityByKanaIds([])).thenAnswer((_) => Future.value({}));
      },
      build: () => WordsBloc(wordsRepository: mockWordsRepository, statisticsRepository: mockStatisticsRepository),
      act: (bloc) => bloc.add(const WordsLoaded('en')),
      expect: () => [WordsLoadFailure()],
    );

    blocTest<WordsBloc, WordsState>(
      'emits [WordsLoadSuccess] when WordsLoaded is added',
      setUp: () {
        when(mockWordsRepository.fetchTodos).thenAnswer((_) => Future.value(wordsModel));

        final wordIds = ['あめ', 'けしゴム', 'サラダ', 'うし', 'うま', 'しま', 'あらし', 'しろ', 'はし'];
        when(() => mockStatisticsRepository.specificWordCorrectQuantityByWordIds(wordIds)).thenAnswer((_) {
          return Future.value({'あめ': 101, 'けしゴム': 102, 'サラダ': 103, 'うし': 104, 'うま': 105, 'しま': 106, 'あらし': 107, 'しろ': 108, 'はし': 109});
        });
        when(() => mockStatisticsRepository.specificWordWrongQuantityByWordIds(wordIds)).thenAnswer((_) {
          return Future.value({'あめ': 201, 'けしゴム': 202, 'サラダ': 203, 'うし': 204, 'うま': 205, 'しま': 206, 'あらし': 207, 'しろ': 208, 'はし': 209});
        });

        final mapCorrectsQuantity = {
          'あ': 1001,
          'う': 1002,
          'け': 1003,
          'し': 1004,
          'は': 1005,
          'ま': 1006,
          'め': 1007,
          'ら': 1008,
          'ろ': 1009,
          'ゴ': 1010,
          'サ': 1011,
          'ダ': 1012,
          'ム': 1013,
          'ラ': 1014
        };
        final mapWrongsQuantity = {
          'あ': 2001,
          'う': 2002,
          'け': 2003,
          'し': 2004,
          'は': 2005,
          'ま': 2006,
          'め': 2007,
          'ら': 2008,
          'ろ': 2009,
          'ゴ': 2010,
          'サ': 2011,
          'ダ': 2012,
          'ム': 2013,
          'ラ': 2014
        };
        final kanaIds = ['あ', 'め', 'け', 'し', 'ゴ', 'ム', 'サ', 'ラ', 'ダ', 'う', 'し', 'う', 'ま', 'し', 'ま', 'あ', 'ら', 'し', 'し', 'ろ', 'は', 'し'];
        when(() => mockStatisticsRepository.specificKanaCorrectQuantityByKanaIds(kanaIds)).thenAnswer((_) => Future.value(mapCorrectsQuantity));
        when(() => mockStatisticsRepository.specificKanaWrongQuantityByKanaIds(kanaIds)).thenAnswer((_) => Future.value(mapWrongsQuantity));
      },
      build: () => WordsBloc(wordsRepository: mockWordsRepository, statisticsRepository: mockStatisticsRepository),
      act: (bloc) => bloc.add(const WordsLoaded('pt')),
      expect: () => const [WordsLoadSuccess(wordsViewModel)],
    );
  });
}

const inconsistentWordsModel = [WordModel(id: 'id', romaji: 'romaji', kanaType: KanaType.both, imageUrl: 'imageUrl')];

const wordsModel = <WordModel>[
  WordModel(
    id: 'あめ',
    romaji: 'ame',
    kanaType: KanaType.hiragana,
    imageUrl: 'rain.png',
    translate: TranslateModel(id: 'あめ', english: 'english', portuguese: 'chuva', spanish: 'spanish'),
    kanas: [
      KanaModel(id: 'あ', romaji: 'a', kanaType: KanaType.hiragana, strokes: []),
      KanaModel(id: 'め', romaji: 'me', kanaType: KanaType.hiragana, strokes: [])
    ],
  ),
  WordModel(
    id: 'けしゴム',
    romaji: 'keshigomu',
    kanaType: KanaType.both,
    imageUrl: 'eraser.png',
    translate: TranslateModel(id: 'けしゴム', english: 'english', portuguese: 'borracha', spanish: 'spanish'),
    kanas: [
      KanaModel(id: 'け', romaji: 'ke', kanaType: KanaType.hiragana, strokes: []),
      KanaModel(id: 'し', romaji: 'shi', kanaType: KanaType.hiragana, strokes: []),
      KanaModel(id: 'ゴ', romaji: 'go', kanaType: KanaType.katakana, strokes: []),
      KanaModel(id: 'ム', romaji: 'mu', kanaType: KanaType.katakana, strokes: [])
    ],
  ),
  WordModel(
    id: 'サラダ',
    romaji: 'sarada',
    kanaType: KanaType.katakana,
    imageUrl: 'salad.png',
    translate: TranslateModel(id: 'サラダ', english: 'english', portuguese: 'salada', spanish: 'spanish'),
    kanas: [
      KanaModel(id: 'サ', romaji: 'sa', kanaType: KanaType.katakana, strokes: []),
      KanaModel(id: 'ラ', romaji: 'ra', kanaType: KanaType.katakana, strokes: []),
      KanaModel(id: 'ダ', romaji: 'da', kanaType: KanaType.katakana, strokes: [])
    ],
  ),
  WordModel(
    id: 'うし',
    romaji: 'ushi',
    kanaType: KanaType.hiragana,
    imageUrl: 'cow.png',
    translate: TranslateModel(id: 'うし', english: 'english', portuguese: 'vaca', spanish: 'spanish'),
    kanas: [
      KanaModel(id: 'う', romaji: 'u', kanaType: KanaType.hiragana, strokes: []),
      KanaModel(id: 'し', romaji: 'shi', kanaType: KanaType.hiragana, strokes: [])
    ],
  ),
  WordModel(
    id: 'うま',
    romaji: 'uma',
    kanaType: KanaType.hiragana,
    imageUrl: 'horse.png',
    translate: TranslateModel(id: 'うま', english: 'english', portuguese: 'cavalo', spanish: 'spanish'),
    kanas: [
      KanaModel(id: 'う', romaji: 'u', kanaType: KanaType.hiragana, strokes: []),
      KanaModel(id: 'ま', romaji: 'ma', kanaType: KanaType.hiragana, strokes: [])
    ],
  ),
  WordModel(
    id: 'しま',
    romaji: 'shima',
    kanaType: KanaType.hiragana,
    imageUrl: 'island.png',
    translate: TranslateModel(id: 'しま', english: 'english', portuguese: 'ilha', spanish: 'spanish'),
    kanas: [
      KanaModel(id: 'し', romaji: 'shi', kanaType: KanaType.hiragana, strokes: []),
      KanaModel(id: 'ま', romaji: 'ma', kanaType: KanaType.hiragana, strokes: [])
    ],
  ),
  WordModel(
    id: 'あらし',
    romaji: 'arashi',
    kanaType: KanaType.hiragana,
    imageUrl: 'storm.png',
    translate: TranslateModel(id: 'あらし', english: 'english', portuguese: 'tempestada', spanish: 'spanish'),
    kanas: [
      KanaModel(id: 'あ', romaji: 'a', kanaType: KanaType.hiragana, strokes: []),
      KanaModel(id: 'ら', romaji: 'ra', kanaType: KanaType.hiragana, strokes: []),
      KanaModel(id: 'し', romaji: 'shi', kanaType: KanaType.hiragana, strokes: [])
    ],
  ),
  WordModel(
    id: 'しろ',
    romaji: 'shiro',
    kanaType: KanaType.hiragana,
    imageUrl: 'white.png',
    translate: TranslateModel(id: 'しろ', english: 'english', portuguese: 'branco', spanish: 'spanish'),
    kanas: [
      KanaModel(id: 'し', romaji: 'shi', kanaType: KanaType.hiragana, strokes: []),
      KanaModel(id: 'ろ', romaji: 'ro', kanaType: KanaType.hiragana, strokes: [])
    ],
  ),
  WordModel(
    id: 'はし',
    romaji: 'hashi',
    kanaType: KanaType.hiragana,
    imageUrl: 'hashi.png',
    translate: TranslateModel(id: 'はし', english: 'english', portuguese: 'chopsticks', spanish: 'spanish'),
    kanas: [
      KanaModel(id: 'は', romaji: 'ha', kanaType: KanaType.hiragana, strokes: []),
      KanaModel(id: 'し', romaji: 'shi', kanaType: KanaType.hiragana, strokes: [])
    ],
  ),
];

const wordsViewModel = [
  WordViewModel(
    id: 'あめ',
    romaji: 'ame',
    kanaType: KanaType.hiragana,
    imageUrl: 'rain.png',
    translate: 'chuva',
    kanas: [
      KanaViewModel(id: 'あ', kanaType: KanaType.hiragana, romaji: 'a', strokes: [], correctCount: 1001, wrongCount: 2001),
      KanaViewModel(id: 'め', kanaType: KanaType.hiragana, romaji: 'me', strokes: [], correctCount: 1007, wrongCount: 2007),
    ],
    correctCount: 101,
    wrongCount: 201,
  ),
  WordViewModel(
    id: 'あらし',
    romaji: 'arashi',
    kanaType: KanaType.hiragana,
    imageUrl: 'storm.png',
    translate: 'tempestada',
    kanas: [
      KanaViewModel(id: 'あ', kanaType: KanaType.hiragana, romaji: 'a', strokes: [], correctCount: 1001, wrongCount: 2001),
      KanaViewModel(id: 'ら', kanaType: KanaType.hiragana, romaji: 'ra', strokes: [], correctCount: 1008, wrongCount: 2008),
      KanaViewModel(id: 'し', kanaType: KanaType.hiragana, romaji: 'shi', strokes: [], correctCount: 1004, wrongCount: 2004),
    ],
    correctCount: 107,
    wrongCount: 207,
  ),
  WordViewModel(
    id: 'うし',
    romaji: 'ushi',
    kanaType: KanaType.hiragana,
    imageUrl: 'cow.png',
    translate: 'vaca',
    kanas: [
      KanaViewModel(id: 'う', kanaType: KanaType.hiragana, romaji: 'u', strokes: [], correctCount: 1002, wrongCount: 2002),
      KanaViewModel(id: 'し', kanaType: KanaType.hiragana, romaji: 'shi', strokes: [], correctCount: 1004, wrongCount: 2004),
    ],
    correctCount: 104,
    wrongCount: 204,
  ),
  WordViewModel(
    id: 'うま',
    romaji: 'uma',
    kanaType: KanaType.hiragana,
    imageUrl: 'horse.png',
    translate: 'cavalo',
    kanas: [
      KanaViewModel(id: 'う', kanaType: KanaType.hiragana, romaji: 'u', strokes: [], correctCount: 1002, wrongCount: 2002),
      KanaViewModel(id: 'ま', kanaType: KanaType.hiragana, romaji: 'ma', strokes: [], correctCount: 1006, wrongCount: 2006),
    ],
    correctCount: 105,
    wrongCount: 205,
  ),
  WordViewModel(
    id: 'けしゴム',
    romaji: 'keshigomu',
    kanaType: KanaType.both,
    imageUrl: 'eraser.png',
    translate: 'borracha',
    kanas: [
      KanaViewModel(id: 'け', kanaType: KanaType.hiragana, romaji: 'ke', strokes: [], correctCount: 1003, wrongCount: 2003),
      KanaViewModel(id: 'し', kanaType: KanaType.hiragana, romaji: 'shi', strokes: [], correctCount: 1004, wrongCount: 2004),
      KanaViewModel(id: 'ゴ', kanaType: KanaType.katakana, romaji: 'go', strokes: [], correctCount: 1010, wrongCount: 2010),
      KanaViewModel(id: 'ム', kanaType: KanaType.katakana, romaji: 'mu', strokes: [], correctCount: 1013, wrongCount: 2013),
    ],
    correctCount: 102,
    wrongCount: 202,
  ),
  WordViewModel(
    id: 'しま',
    romaji: 'shima',
    kanaType: KanaType.hiragana,
    imageUrl: 'island.png',
    translate: 'ilha',
    kanas: [
      KanaViewModel(id: 'し', kanaType: KanaType.hiragana, romaji: 'shi', strokes: [], correctCount: 1004, wrongCount: 2004),
      KanaViewModel(id: 'ま', kanaType: KanaType.hiragana, romaji: 'ma', strokes: [], correctCount: 1006, wrongCount: 2006),
    ],
    correctCount: 106,
    wrongCount: 206,
  ),
  WordViewModel(
    id: 'しろ',
    romaji: 'shiro',
    kanaType: KanaType.hiragana,
    imageUrl: 'white.png',
    translate: 'branco',
    kanas: [
      KanaViewModel(id: 'し', kanaType: KanaType.hiragana, romaji: 'shi', strokes: [], correctCount: 1004, wrongCount: 2004),
      KanaViewModel(id: 'ろ', kanaType: KanaType.hiragana, romaji: 'ro', strokes: [], correctCount: 1009, wrongCount: 2009),
    ],
    correctCount: 108,
    wrongCount: 208,
  ),
  WordViewModel(
    id: 'はし',
    romaji: 'hashi',
    kanaType: KanaType.hiragana,
    imageUrl: 'hashi.png',
    translate: 'chopsticks',
    kanas: [
      KanaViewModel(id: 'は', kanaType: KanaType.hiragana, romaji: 'ha', strokes: [], correctCount: 1005, wrongCount: 2005),
      KanaViewModel(id: 'し', kanaType: KanaType.hiragana, romaji: 'shi', strokes: [], correctCount: 1004, wrongCount: 2004),
    ],
    correctCount: 109,
    wrongCount: 209,
  ),
  WordViewModel(
    id: 'サラダ',
    romaji: 'sarada',
    kanaType: KanaType.katakana,
    imageUrl: 'salad.png',
    translate: 'salada',
    kanas: [
      KanaViewModel(id: 'サ', kanaType: KanaType.katakana, romaji: 'sa', strokes: [], correctCount: 1011, wrongCount: 2011),
      KanaViewModel(id: 'ラ', kanaType: KanaType.katakana, romaji: 'ra', strokes: [], correctCount: 1014, wrongCount: 2014),
      KanaViewModel(id: 'ダ', kanaType: KanaType.katakana, romaji: 'da', strokes: [], correctCount: 1012, wrongCount: 2012),
    ],
    correctCount: 103,
    wrongCount: 203,
  ),
];
