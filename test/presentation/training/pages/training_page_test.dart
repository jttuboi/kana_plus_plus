// ignore_for_file: prefer_const_constructors, type_annotate_public_apis, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kwriting/domain/domain.dart';
import 'package:kwriting/presentation/shared/shared.dart';
import 'package:kwriting/presentation/training/training.dart';
import 'package:mocktail/mocktail.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

import '../../../utils/mocks.dart';
import '../../../utils/utils.dart';

void main() {
  group('TrainingPage', () {
    final mockKanaChecker = MockKanaChecker();
    final mockWordsRepository = MockWordsRepository();

    testWidgets('renders correctly', (tester) async {
      when(mockKanaChecker.initialize).thenAnswer((_) => Future.value());
      when(mockWordsRepository.fetchTodos).thenAnswer((_) => Future.value(wordsModel));
      await tester.pumpWidget(MaterialApp(
        home: TrainingPage(
          trainingSettings: const TrainingSettings(
            showHint: true,
            kanaType: KanaType.both,
            quantityOfWords: 5,
            languageCode: 'pt',
          ),
          strokeReducer: MockStrokeReducer(),
          kanaChecker: mockKanaChecker,
          wordsRepository: mockWordsRepository,
          statisticsRepository: MockStatisticsRepository(),
        ),
      ));

      tester
        ..expectWidget<BlocProvider<WriterBloc>>()
        ..expectWidget<BlocProvider<ListBloc>>()
        ..expectWidget<BlocProvider<TrainingBloc>>()
        ..expectWidget<BlocProvider<WordBloc>>()
        ..expectWidget<BlocProvider<KanaBloc>>()
        ..expectWidget<TrainingView>();
    });
  });

  group('TrainingView', () {
    final mockWriterBloc = MockWriterBloc();
    final mockListBloc = MockListBloc();
    final mockTrainingBloc = MockTrainingBloc();
    final mockWordBloc = MockWordBloc();
    final mockKanaBloc = MockKanaBloc();

    testWidgets('renders training shimmer when is initial state', (tester) async {
      when(() => mockListBloc.state).thenReturn(const ListInitial());
      when(() => mockTrainingBloc.state).thenReturn(const TrainingInitial());
      await tester.pumpTrainingView(mockWriterBloc, mockListBloc, mockTrainingBloc, mockWordBloc, mockKanaBloc);

      tester
        ..expectWidget<Shimmer>()
        ..expectWidget<ShimmerTrainingView>();
    });

    testWidgets('renders correctly', (tester) async {
      when(() => mockWriterBloc.state).thenReturn(const WriterWait(
        strokesForDraw: [
          'M 66.87 26.75 C 68.2729 27.6427 69.8058 29.0247 71.2034 30.5786 C 72.5455 32.0708 73.7627 33.7216 74.62 35.25',
          'M 66.87 26.75 C 68.2729 27.6427 69.8058 29.0247 71.2034 30.5786 C 72.5455 32.0708 73.7627 33.7216 74.62 35.25',
        ],
      ));
      when(() => mockListBloc.state).thenReturn(const ListReady());
      when(() => mockTrainingBloc.state).thenReturn(const TrainingReady());
      when(() => mockWordBloc.state).thenReturn(const WordReady(translate: 'asd', total: 2, imageUrl: ImageUrl.introRecommendation));
      when(() => mockKanaBloc.state).thenReturn(const KanaReady());
      await tester.pumpTrainingView(mockWriterBloc, mockListBloc, mockTrainingBloc, mockWordBloc, mockKanaBloc);

      tester
        ..expectWidget<WillPopScope>()
        ..expectWidget<Scaffold>()
        ..expectWidget<AppBar>()
        ..expectWidget<IconButton>()
        ..expectSvgPicture(IconUrl.quitTraining, indexInWidgets: 1)
        ..expectWidget<BlocBuilder<TrainingBloc, TrainingState>>()
        ..expectWidget<BlocBuilder<WordBloc, WordState>>(widgetQuantityExpected: 2)
        ..expectWidget<StepProgressIndicator>()
        ..expectWidget<PageView>(widgetQuantityExpected: 2)
        ..expectSvgPicture(ImageUrl.introRecommendation, indexInWidgets: 0)
        ..expectWidget<KanaViewers>()
        ..expectWidget<Writer>()
        ..expectWidget<Spacer>(widgetQuantityExpected: 4);
    });
  });
}

extension WidgetTesterExtension on WidgetTester {
  Future<void> pumpTrainingView(MockWriterBloc mockWriterBloc, MockListBloc mockListBloc, MockTrainingBloc mockTrainingBloc,
      MockWordBloc mockWordBloc, MockKanaBloc mockKanaBloc) async {
    await pumpWidget(MaterialApp(
      localizationsDelegates: JStrings.localizationsDelegates,
      supportedLocales: JStrings.supportedLocales,
      home: MultiBlocProvider(
        providers: [
          BlocProvider<WriterBloc>(create: (context) => mockWriterBloc),
          BlocProvider<ListBloc>(create: (context) => mockListBloc),
          BlocProvider<TrainingBloc>(create: (context) => mockTrainingBloc),
          BlocProvider<WordBloc>(create: (context) => mockWordBloc),
          BlocProvider<KanaBloc>(create: (context) => mockKanaBloc),
        ],
        child: const TrainingView(
          trainingSettings: TrainingSettings(showHint: true, kanaType: KanaType.both, quantityOfWords: 5, languageCode: 'pt'),
        ),
      ),
    ));
  }
}

var wordsModel = <WordModel>[
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
