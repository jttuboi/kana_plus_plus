// ignore_for_file: avoid_redundant_argument_values, prefer_const_constructors, type_annotate_public_apis, prefer_const_literals_to_create_immutables

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kwriting/domain/domain.dart';
import 'package:kwriting/presentation/training/training.dart';
import 'package:mocktail/mocktail.dart';

import '../../../utils/mocks.dart';

void main() {
  setUpAll(() {
    registerFallbackValue(WriterStarted);
  });

  group('ListBloc', () {
    final mockWriterBloc = MockWriterBloc();
    final mockWordsRepository = MockWordsRepository();
    final mockStatisticsRepository = MockStatisticsRepository();

    // TODO descobrir como testar random, o ListReady retorna uma lista com shuffle,
    // talvez tenha q injetar a lista ordenada, porem se tirar do metodo, estará perdendo sua função
    // blocTest<ListBloc, ListState>(
    //   'emits [ListReady] when ListStarted is added',
    //   setUp: () {
    //     when(mockWordsRepository.fetchTodos).thenAnswer((_) => Future.value(wordsModel));
    //     when(() => mockWriterBloc.add(const WriterStarted(kanaId: 'あ', strokesForDraw: ['stroke 1']))).thenReturn(null);
    //     // when(() => mockWriterBloc.add(any<WriterStarted>())).thenReturn(null);
    //   },
    //   build: () => ListBloc(mockWriterBloc, mockWordsRepository, mockStatisticsRepository),
    //   act: (bloc) => bloc.add(const ListStarted(TrainingSettings(showHint: true, kanaType: KanaType.both, quantityOfWords: 9, languageCode: 'pt'))),
    //   expect: () {
    //     expect(verify(() => mockWriterBloc.add(captureAny<WriterStarted>())).captured, anyOf(equals('expected'), equals('expected')));
    //     return const [ListReady(words: wordsViewModel)];
    //   },
    // );

    blocTest<ListBloc, ListState>(
      'emits [ListPreReady] when ListPreUpdated is added',
      setUp: () => when(() => mockWriterBloc.add(const WriterStarted(kanaId: 'あ', strokesForDraw: ['stroke 1']))).thenReturn(null),
      build: () => ListBloc(mockWriterBloc, mockWordsRepository, mockStatisticsRepository),
      act: (bloc) => bloc.add(const ListPreUpdated(kanaIndex: 2, wordIndex: 1, words: wordsViewModel)),
      expect: () => const [ListPreReady(kanaIndex: 2, wordIndex: 1, words: wordsViewModel)],
    );

    blocTest<ListBloc, ListState>(
      'emits [ListKanaReady] when ListKanaChanged is added',
      setUp: () => when(() => mockWriterBloc.add(const WriterStarted(kanaId: 'あ', strokesForDraw: ['stroke 1']))).thenReturn(null),
      build: () => ListBloc(mockWriterBloc, mockWordsRepository, mockStatisticsRepository),
      act: (bloc) => bloc.add(const ListKanaChanged(kanaIndex: 1, wordIndex: 1, words: wordsViewModel)),
      expect: () {
        verify(() => mockWriterBloc.add(const WriterStarted(kanaId: 'ゴ', strokesForDraw: ['stroke 5']))).called(1);
        return const [ListKanaReady(kanaIndex: 2, wordIndex: 1, words: wordsViewModel)];
      },
    );

    blocTest<ListBloc, ListState>(
      'emits [ListWordReady] when ListWordChanged is added',
      setUp: () => when(() => mockWriterBloc.add(const WriterStarted(kanaId: 'あ', strokesForDraw: ['stroke 1']))).thenReturn(null),
      build: () => ListBloc(mockWriterBloc, mockWordsRepository, mockStatisticsRepository),
      act: (bloc) => bloc.add(const ListWordChanged(wordIndex: 1, words: wordsViewModel)),
      expect: () {
        verify(() => mockWriterBloc.add(const WriterStarted(kanaId: 'サ', strokesForDraw: ['stroke 7']))).called(1);
        return const [ListWordReady(kanaIndex: 0, wordIndex: 2, words: wordsViewModel)];
      },
    );

    blocTest<ListBloc, ListState>(
      'emits [ListPageReady] when ListPageAnimationChanged is added',
      setUp: () => when(() => mockWriterBloc.add(const WriterStarted(kanaId: 'あ', strokesForDraw: ['stroke 1']))).thenReturn(null),
      build: () => ListBloc(mockWriterBloc, mockWordsRepository, mockStatisticsRepository),
      act: (bloc) => bloc.add(const ListPageAnimationChanged(wordIndex: 1, words: wordsViewModel, changePageDurationInMilliseconds: 200)),
      expect: () => const [ListPageReady(kanaIndex: 0, wordIndex: 2, words: wordsViewModel, changePageDurationInMilliseconds: 200)],
    );

    blocTest<ListBloc, ListState>(
      'emits [TrainingEnded] when ListTrainingEnded is added',
      setUp: () => when(() => mockWriterBloc.add(const WriterStarted(kanaId: 'あ', strokesForDraw: ['stroke 1']))).thenReturn(null),
      build: () => ListBloc(mockWriterBloc, mockWordsRepository, mockStatisticsRepository),
      act: (bloc) => bloc.add(const ListTrainingEnded(wordsViewModel)),
      expect: () => const [TrainingEnded(words: wordsViewModel)],
    );

    // TODO testar _onWriterStateEnd,
    //descobrir como executar um metodo de um listen externo
  });
}

var wordsModel = <WordModel>[
  WordModel(
    id: 'あめ',
    romaji: 'ame',
    kanaType: KanaType.hiragana,
    imageUrl: 'rain.png',
    translate: TranslateModel(id: 'あめ', english: 'english', portuguese: 'chuva', spanish: 'spanish'),
    kanas: [
      KanaModel(id: 'あ', romaji: 'a', kanaType: KanaType.hiragana, strokes: ['stroke 1']),
      KanaModel(id: 'め', romaji: 'me', kanaType: KanaType.hiragana, strokes: ['stroke 2'])
    ],
  ),
  WordModel(
    id: 'けしゴム',
    romaji: 'keshigomu',
    kanaType: KanaType.both,
    imageUrl: 'eraser.png',
    translate: TranslateModel(id: 'けしゴム', english: 'english', portuguese: 'borracha', spanish: 'spanish'),
    kanas: [
      KanaModel(id: 'け', romaji: 'ke', kanaType: KanaType.hiragana, strokes: ['stroke 3']),
      KanaModel(id: 'し', romaji: 'shi', kanaType: KanaType.hiragana, strokes: ['stroke 4']),
      KanaModel(id: 'ゴ', romaji: 'go', kanaType: KanaType.katakana, strokes: ['stroke 5']),
      KanaModel(id: 'ム', romaji: 'mu', kanaType: KanaType.katakana, strokes: ['stroke 6'])
    ],
  ),
  WordModel(
    id: 'サラダ',
    romaji: 'sarada',
    kanaType: KanaType.katakana,
    imageUrl: 'salad.png',
    translate: TranslateModel(id: 'サラダ', english: 'english', portuguese: 'salada', spanish: 'spanish'),
    kanas: [
      KanaModel(id: 'サ', romaji: 'sa', kanaType: KanaType.katakana, strokes: ['stroke 7']),
      KanaModel(id: 'ラ', romaji: 'ra', kanaType: KanaType.katakana, strokes: ['stroke 8']),
      KanaModel(id: 'ダ', romaji: 'da', kanaType: KanaType.katakana, strokes: ['stroke 9'])
    ],
  ),
  WordModel(
    id: 'うし',
    romaji: 'ushi',
    kanaType: KanaType.hiragana,
    imageUrl: 'cow.png',
    translate: TranslateModel(id: 'うし', english: 'english', portuguese: 'vaca', spanish: 'spanish'),
    kanas: [
      KanaModel(id: 'う', romaji: 'u', kanaType: KanaType.hiragana, strokes: ['stroke 10']),
      KanaModel(id: 'し', romaji: 'shi', kanaType: KanaType.hiragana, strokes: ['stroke 4'])
    ],
  ),
  WordModel(
    id: 'うま',
    romaji: 'uma',
    kanaType: KanaType.hiragana,
    imageUrl: 'horse.png',
    translate: TranslateModel(id: 'うま', english: 'english', portuguese: 'cavalo', spanish: 'spanish'),
    kanas: [
      KanaModel(id: 'う', romaji: 'u', kanaType: KanaType.hiragana, strokes: ['stroke 10']),
      KanaModel(id: 'ま', romaji: 'ma', kanaType: KanaType.hiragana, strokes: ['stroke 11'])
    ],
  ),
  WordModel(
    id: 'しま',
    romaji: 'shima',
    kanaType: KanaType.hiragana,
    imageUrl: 'island.png',
    translate: TranslateModel(id: 'しま', english: 'english', portuguese: 'ilha', spanish: 'spanish'),
    kanas: [
      KanaModel(id: 'し', romaji: 'shi', kanaType: KanaType.hiragana, strokes: ['stroke 4']),
      KanaModel(id: 'ま', romaji: 'ma', kanaType: KanaType.hiragana, strokes: ['stroke 11'])
    ],
  ),
  WordModel(
    id: 'あらし',
    romaji: 'arashi',
    kanaType: KanaType.hiragana,
    imageUrl: 'storm.png',
    translate: TranslateModel(id: 'あらし', english: 'english', portuguese: 'tempestada', spanish: 'spanish'),
    kanas: [
      KanaModel(id: 'あ', romaji: 'a', kanaType: KanaType.hiragana, strokes: ['stroke 1']),
      KanaModel(id: 'ら', romaji: 'ra', kanaType: KanaType.hiragana, strokes: ['stroke 13']),
      KanaModel(id: 'し', romaji: 'shi', kanaType: KanaType.hiragana, strokes: ['stroke 4'])
    ],
  ),
  WordModel(
    id: 'しろ',
    romaji: 'shiro',
    kanaType: KanaType.hiragana,
    imageUrl: 'white.png',
    translate: TranslateModel(id: 'しろ', english: 'english', portuguese: 'branco', spanish: 'spanish'),
    kanas: [
      KanaModel(id: 'し', romaji: 'shi', kanaType: KanaType.hiragana, strokes: ['stroke 4']),
      KanaModel(id: 'ろ', romaji: 'ro', kanaType: KanaType.hiragana, strokes: ['stroke 14'])
    ],
  ),
  WordModel(
    id: 'はし',
    romaji: 'hashi',
    kanaType: KanaType.hiragana,
    imageUrl: 'hashi.png',
    translate: TranslateModel(id: 'はし', english: 'english', portuguese: 'chopsticks', spanish: 'spanish'),
    kanas: [
      KanaModel(id: 'は', romaji: 'ha', kanaType: KanaType.hiragana, strokes: ['stroke 15']),
      KanaModel(id: 'し', romaji: 'shi', kanaType: KanaType.hiragana, strokes: ['stroke 4'])
    ],
  ),
];

const wordsViewModel = [
  WordViewModel(
    id: 'あめ',
    imageUrl: 'rain.png',
    translate: 'chuva',
    kanas: [
      KanaViewModel(id: 'あ', status: KanaViewerStatus.correct, kanaType: KanaType.hiragana, romaji: 'a', strokes: ['stroke 1']),
      KanaViewModel(id: 'め', status: KanaViewerStatus.correct, kanaType: KanaType.hiragana, romaji: 'me', strokes: ['stroke 2']),
    ],
  ),
  WordViewModel(
    id: 'けしゴム',
    imageUrl: 'eraser.png',
    translate: 'borracha',
    kanas: [
      KanaViewModel(id: 'け', status: KanaViewerStatus.select, kanaType: KanaType.hiragana, romaji: 'ke', strokes: ['stroke 3']),
      KanaViewModel(id: 'し', status: KanaViewerStatus.normal, kanaType: KanaType.hiragana, romaji: 'shi', strokes: ['stroke 4']),
      KanaViewModel(id: 'ゴ', status: KanaViewerStatus.normal, kanaType: KanaType.katakana, romaji: 'go', strokes: ['stroke 5']),
      KanaViewModel(id: 'ム', status: KanaViewerStatus.normal, kanaType: KanaType.katakana, romaji: 'mu', strokes: ['stroke 6']),
    ],
  ),
  WordViewModel(
    id: 'サラダ',
    imageUrl: 'salad.png',
    translate: 'salada',
    kanas: [
      KanaViewModel(id: 'サ', status: KanaViewerStatus.select, kanaType: KanaType.katakana, romaji: 'sa', strokes: ['stroke 7']),
      KanaViewModel(id: 'ラ', status: KanaViewerStatus.normal, kanaType: KanaType.katakana, romaji: 'ra', strokes: ['stroke 8']),
      KanaViewModel(id: 'ダ', status: KanaViewerStatus.normal, kanaType: KanaType.katakana, romaji: 'da', strokes: ['stroke 9']),
    ],
  ),
  WordViewModel(
    id: 'うし',
    imageUrl: 'cow.png',
    translate: 'vaca',
    kanas: [
      KanaViewModel(id: 'う', status: KanaViewerStatus.select, kanaType: KanaType.hiragana, romaji: 'u', strokes: ['stroke 10']),
      KanaViewModel(id: 'し', status: KanaViewerStatus.normal, kanaType: KanaType.hiragana, romaji: 'shi', strokes: ['stroke 4']),
    ],
  ),
  WordViewModel(
    id: 'うま',
    imageUrl: 'horse.png',
    translate: 'cavalo',
    kanas: [
      KanaViewModel(id: 'う', status: KanaViewerStatus.select, kanaType: KanaType.hiragana, romaji: 'u', strokes: ['stroke 10']),
      KanaViewModel(id: 'ま', status: KanaViewerStatus.normal, kanaType: KanaType.hiragana, romaji: 'ma', strokes: ['stroke 11']),
    ],
  ),
  WordViewModel(
    id: 'しま',
    imageUrl: 'island.png',
    translate: 'ilha',
    kanas: [
      KanaViewModel(id: 'し', status: KanaViewerStatus.select, kanaType: KanaType.hiragana, romaji: 'shi', strokes: ['stroke 4']),
      KanaViewModel(id: 'ま', status: KanaViewerStatus.normal, kanaType: KanaType.hiragana, romaji: 'ma', strokes: ['stroke 11']),
    ],
  ),
  WordViewModel(
    id: 'あらし',
    imageUrl: 'storm.png',
    translate: 'tempestada',
    kanas: [
      KanaViewModel(id: 'あ', status: KanaViewerStatus.correct, kanaType: KanaType.hiragana, romaji: 'a', strokes: ['stroke 1']),
      KanaViewModel(id: 'ら', status: KanaViewerStatus.wrong, kanaType: KanaType.hiragana, romaji: 'ra', strokes: ['stroke 13']),
      KanaViewModel(id: 'し', status: KanaViewerStatus.select, kanaType: KanaType.hiragana, romaji: 'shi', strokes: ['stroke 4']),
    ],
  ),
  WordViewModel(
    id: 'しろ',
    imageUrl: 'white.png',
    translate: 'branco',
    kanas: [
      KanaViewModel(id: 'し', status: KanaViewerStatus.select, kanaType: KanaType.hiragana, romaji: 'shi', strokes: ['stroke 4']),
      KanaViewModel(id: 'ろ', status: KanaViewerStatus.normal, kanaType: KanaType.hiragana, romaji: 'ro', strokes: ['stroke 14']),
    ],
  ),
  WordViewModel(
    id: 'はし',
    imageUrl: 'hashi.png',
    translate: 'chopsticks',
    kanas: [
      KanaViewModel(id: 'は', status: KanaViewerStatus.select, kanaType: KanaType.hiragana, romaji: 'ha', strokes: ['stroke 15']),
      KanaViewModel(id: 'し', status: KanaViewerStatus.normal, kanaType: KanaType.hiragana, romaji: 'shi', strokes: ['stroke 4']),
    ],
  ),
];
