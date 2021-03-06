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

        final wordIds = ['??????', '????????????', '?????????', '??????', '??????', '??????', '?????????', '??????', '??????'];
        when(() => mockStatisticsRepository.specificWordCorrectQuantityByWordIds(wordIds)).thenAnswer((_) {
          return Future.value({'??????': 101, '????????????': 102, '?????????': 103, '??????': 104, '??????': 105, '??????': 106, '?????????': 107, '??????': 108, '??????': 109});
        });
        when(() => mockStatisticsRepository.specificWordWrongQuantityByWordIds(wordIds)).thenAnswer((_) {
          return Future.value({'??????': 201, '????????????': 202, '?????????': 203, '??????': 204, '??????': 205, '??????': 206, '?????????': 207, '??????': 208, '??????': 209});
        });

        final mapCorrectsQuantity = {
          '???': 1001,
          '???': 1002,
          '???': 1003,
          '???': 1004,
          '???': 1005,
          '???': 1006,
          '???': 1007,
          '???': 1008,
          '???': 1009,
          '???': 1010,
          '???': 1011,
          '???': 1012,
          '???': 1013,
          '???': 1014
        };
        final mapWrongsQuantity = {
          '???': 2001,
          '???': 2002,
          '???': 2003,
          '???': 2004,
          '???': 2005,
          '???': 2006,
          '???': 2007,
          '???': 2008,
          '???': 2009,
          '???': 2010,
          '???': 2011,
          '???': 2012,
          '???': 2013,
          '???': 2014
        };
        final kanaIds = ['???', '???', '???', '???', '???', '???', '???', '???', '???', '???', '???', '???', '???', '???', '???', '???', '???', '???', '???', '???', '???', '???'];
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
    id: '??????',
    romaji: 'ame',
    kanaType: KanaType.hiragana,
    imageUrl: 'rain.png',
    translate: TranslateModel(id: '??????', english: 'english', portuguese: 'chuva', spanish: 'spanish'),
    kanas: [
      KanaModel(id: '???', romaji: 'a', kanaType: KanaType.hiragana, strokes: []),
      KanaModel(id: '???', romaji: 'me', kanaType: KanaType.hiragana, strokes: [])
    ],
  ),
  WordModel(
    id: '????????????',
    romaji: 'keshigomu',
    kanaType: KanaType.both,
    imageUrl: 'eraser.png',
    translate: TranslateModel(id: '????????????', english: 'english', portuguese: 'borracha', spanish: 'spanish'),
    kanas: [
      KanaModel(id: '???', romaji: 'ke', kanaType: KanaType.hiragana, strokes: []),
      KanaModel(id: '???', romaji: 'shi', kanaType: KanaType.hiragana, strokes: []),
      KanaModel(id: '???', romaji: 'go', kanaType: KanaType.katakana, strokes: []),
      KanaModel(id: '???', romaji: 'mu', kanaType: KanaType.katakana, strokes: [])
    ],
  ),
  WordModel(
    id: '?????????',
    romaji: 'sarada',
    kanaType: KanaType.katakana,
    imageUrl: 'salad.png',
    translate: TranslateModel(id: '?????????', english: 'english', portuguese: 'salada', spanish: 'spanish'),
    kanas: [
      KanaModel(id: '???', romaji: 'sa', kanaType: KanaType.katakana, strokes: []),
      KanaModel(id: '???', romaji: 'ra', kanaType: KanaType.katakana, strokes: []),
      KanaModel(id: '???', romaji: 'da', kanaType: KanaType.katakana, strokes: [])
    ],
  ),
  WordModel(
    id: '??????',
    romaji: 'ushi',
    kanaType: KanaType.hiragana,
    imageUrl: 'cow.png',
    translate: TranslateModel(id: '??????', english: 'english', portuguese: 'vaca', spanish: 'spanish'),
    kanas: [
      KanaModel(id: '???', romaji: 'u', kanaType: KanaType.hiragana, strokes: []),
      KanaModel(id: '???', romaji: 'shi', kanaType: KanaType.hiragana, strokes: [])
    ],
  ),
  WordModel(
    id: '??????',
    romaji: 'uma',
    kanaType: KanaType.hiragana,
    imageUrl: 'horse.png',
    translate: TranslateModel(id: '??????', english: 'english', portuguese: 'cavalo', spanish: 'spanish'),
    kanas: [
      KanaModel(id: '???', romaji: 'u', kanaType: KanaType.hiragana, strokes: []),
      KanaModel(id: '???', romaji: 'ma', kanaType: KanaType.hiragana, strokes: [])
    ],
  ),
  WordModel(
    id: '??????',
    romaji: 'shima',
    kanaType: KanaType.hiragana,
    imageUrl: 'island.png',
    translate: TranslateModel(id: '??????', english: 'english', portuguese: 'ilha', spanish: 'spanish'),
    kanas: [
      KanaModel(id: '???', romaji: 'shi', kanaType: KanaType.hiragana, strokes: []),
      KanaModel(id: '???', romaji: 'ma', kanaType: KanaType.hiragana, strokes: [])
    ],
  ),
  WordModel(
    id: '?????????',
    romaji: 'arashi',
    kanaType: KanaType.hiragana,
    imageUrl: 'storm.png',
    translate: TranslateModel(id: '?????????', english: 'english', portuguese: 'tempestada', spanish: 'spanish'),
    kanas: [
      KanaModel(id: '???', romaji: 'a', kanaType: KanaType.hiragana, strokes: []),
      KanaModel(id: '???', romaji: 'ra', kanaType: KanaType.hiragana, strokes: []),
      KanaModel(id: '???', romaji: 'shi', kanaType: KanaType.hiragana, strokes: [])
    ],
  ),
  WordModel(
    id: '??????',
    romaji: 'shiro',
    kanaType: KanaType.hiragana,
    imageUrl: 'white.png',
    translate: TranslateModel(id: '??????', english: 'english', portuguese: 'branco', spanish: 'spanish'),
    kanas: [
      KanaModel(id: '???', romaji: 'shi', kanaType: KanaType.hiragana, strokes: []),
      KanaModel(id: '???', romaji: 'ro', kanaType: KanaType.hiragana, strokes: [])
    ],
  ),
  WordModel(
    id: '??????',
    romaji: 'hashi',
    kanaType: KanaType.hiragana,
    imageUrl: 'hashi.png',
    translate: TranslateModel(id: '??????', english: 'english', portuguese: 'chopsticks', spanish: 'spanish'),
    kanas: [
      KanaModel(id: '???', romaji: 'ha', kanaType: KanaType.hiragana, strokes: []),
      KanaModel(id: '???', romaji: 'shi', kanaType: KanaType.hiragana, strokes: [])
    ],
  ),
];

const wordsViewModel = [
  WordViewModel(
    id: '??????',
    romaji: 'ame',
    kanaType: KanaType.hiragana,
    imageUrl: 'rain.png',
    translate: 'chuva',
    kanas: [
      KanaViewModel(id: '???', kanaType: KanaType.hiragana, romaji: 'a', strokes: [], correctCount: 1001, wrongCount: 2001),
      KanaViewModel(id: '???', kanaType: KanaType.hiragana, romaji: 'me', strokes: [], correctCount: 1007, wrongCount: 2007),
    ],
    correctCount: 101,
    wrongCount: 201,
  ),
  WordViewModel(
    id: '?????????',
    romaji: 'arashi',
    kanaType: KanaType.hiragana,
    imageUrl: 'storm.png',
    translate: 'tempestada',
    kanas: [
      KanaViewModel(id: '???', kanaType: KanaType.hiragana, romaji: 'a', strokes: [], correctCount: 1001, wrongCount: 2001),
      KanaViewModel(id: '???', kanaType: KanaType.hiragana, romaji: 'ra', strokes: [], correctCount: 1008, wrongCount: 2008),
      KanaViewModel(id: '???', kanaType: KanaType.hiragana, romaji: 'shi', strokes: [], correctCount: 1004, wrongCount: 2004),
    ],
    correctCount: 107,
    wrongCount: 207,
  ),
  WordViewModel(
    id: '??????',
    romaji: 'ushi',
    kanaType: KanaType.hiragana,
    imageUrl: 'cow.png',
    translate: 'vaca',
    kanas: [
      KanaViewModel(id: '???', kanaType: KanaType.hiragana, romaji: 'u', strokes: [], correctCount: 1002, wrongCount: 2002),
      KanaViewModel(id: '???', kanaType: KanaType.hiragana, romaji: 'shi', strokes: [], correctCount: 1004, wrongCount: 2004),
    ],
    correctCount: 104,
    wrongCount: 204,
  ),
  WordViewModel(
    id: '??????',
    romaji: 'uma',
    kanaType: KanaType.hiragana,
    imageUrl: 'horse.png',
    translate: 'cavalo',
    kanas: [
      KanaViewModel(id: '???', kanaType: KanaType.hiragana, romaji: 'u', strokes: [], correctCount: 1002, wrongCount: 2002),
      KanaViewModel(id: '???', kanaType: KanaType.hiragana, romaji: 'ma', strokes: [], correctCount: 1006, wrongCount: 2006),
    ],
    correctCount: 105,
    wrongCount: 205,
  ),
  WordViewModel(
    id: '????????????',
    romaji: 'keshigomu',
    kanaType: KanaType.both,
    imageUrl: 'eraser.png',
    translate: 'borracha',
    kanas: [
      KanaViewModel(id: '???', kanaType: KanaType.hiragana, romaji: 'ke', strokes: [], correctCount: 1003, wrongCount: 2003),
      KanaViewModel(id: '???', kanaType: KanaType.hiragana, romaji: 'shi', strokes: [], correctCount: 1004, wrongCount: 2004),
      KanaViewModel(id: '???', kanaType: KanaType.katakana, romaji: 'go', strokes: [], correctCount: 1010, wrongCount: 2010),
      KanaViewModel(id: '???', kanaType: KanaType.katakana, romaji: 'mu', strokes: [], correctCount: 1013, wrongCount: 2013),
    ],
    correctCount: 102,
    wrongCount: 202,
  ),
  WordViewModel(
    id: '??????',
    romaji: 'shima',
    kanaType: KanaType.hiragana,
    imageUrl: 'island.png',
    translate: 'ilha',
    kanas: [
      KanaViewModel(id: '???', kanaType: KanaType.hiragana, romaji: 'shi', strokes: [], correctCount: 1004, wrongCount: 2004),
      KanaViewModel(id: '???', kanaType: KanaType.hiragana, romaji: 'ma', strokes: [], correctCount: 1006, wrongCount: 2006),
    ],
    correctCount: 106,
    wrongCount: 206,
  ),
  WordViewModel(
    id: '??????',
    romaji: 'shiro',
    kanaType: KanaType.hiragana,
    imageUrl: 'white.png',
    translate: 'branco',
    kanas: [
      KanaViewModel(id: '???', kanaType: KanaType.hiragana, romaji: 'shi', strokes: [], correctCount: 1004, wrongCount: 2004),
      KanaViewModel(id: '???', kanaType: KanaType.hiragana, romaji: 'ro', strokes: [], correctCount: 1009, wrongCount: 2009),
    ],
    correctCount: 108,
    wrongCount: 208,
  ),
  WordViewModel(
    id: '??????',
    romaji: 'hashi',
    kanaType: KanaType.hiragana,
    imageUrl: 'hashi.png',
    translate: 'chopsticks',
    kanas: [
      KanaViewModel(id: '???', kanaType: KanaType.hiragana, romaji: 'ha', strokes: [], correctCount: 1005, wrongCount: 2005),
      KanaViewModel(id: '???', kanaType: KanaType.hiragana, romaji: 'shi', strokes: [], correctCount: 1004, wrongCount: 2004),
    ],
    correctCount: 109,
    wrongCount: 209,
  ),
  WordViewModel(
    id: '?????????',
    romaji: 'sarada',
    kanaType: KanaType.katakana,
    imageUrl: 'salad.png',
    translate: 'salada',
    kanas: [
      KanaViewModel(id: '???', kanaType: KanaType.katakana, romaji: 'sa', strokes: [], correctCount: 1011, wrongCount: 2011),
      KanaViewModel(id: '???', kanaType: KanaType.katakana, romaji: 'ra', strokes: [], correctCount: 1014, wrongCount: 2014),
      KanaViewModel(id: '???', kanaType: KanaType.katakana, romaji: 'da', strokes: [], correctCount: 1012, wrongCount: 2012),
    ],
    correctCount: 103,
    wrongCount: 203,
  ),
];
