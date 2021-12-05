import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kwriting/domain/domain.dart';
import 'package:kwriting/presentation/shared/shared.dart';
import 'package:kwriting/presentation/words/words.dart';
import 'package:mocktail/mocktail.dart';

import '../../../utils/mocks.dart';

void main() {
  group('WordsPage', () {
    final mockWordsRepository = MockWordsRepository();
    final mockStatisticsRepository = MockStatisticsRepository();

    testWidgets('renders correctly', (tester) async {
      when(mockWordsRepository.fetchTodos).thenAnswer((invocation) => Future.value([]));

      await tester.pumpWidget(MaterialApp(
        localizationsDelegates: JStrings.localizationsDelegates,
        supportedLocales: JStrings.supportedLocales,
        home: WordsPage(
          wordsRepository: mockWordsRepository,
          statisticsRepository: mockStatisticsRepository,
        ),
      ));

      expect(find.byType(WordsView), findsOneWidget);
    });
  });

  group('WordsView', () {
    final mockWordsBloc = MockWordsBloc();
    final mockFilteredWordsBloc = MockFilteredWordsBloc();

    testWidgets('creates circular progress screen when filtered words in progress', (tester) async {
      when(() => mockFilteredWordsBloc.state).thenReturn(const FilteredWordsLoadInProgress());

      await tester.pumpWidget(MaterialApp(
        localizationsDelegates: JStrings.localizationsDelegates,
        supportedLocales: JStrings.supportedLocales,
        builder: (context, child) => MultiBlocProvider(
          providers: [
            BlocProvider<WordsBloc>(create: (context) => mockWordsBloc),
            BlocProvider<FilteredWordsBloc>(create: (context) => mockFilteredWordsBloc),
          ],
          child: const WordsView(),
        ),
      ));
      final strings = JStrings.of(tester.element(find.byType(WordsView)))!;

      expect(find.byType(FlexibleScaffold), findsOneWidget);
      expect(find.text(strings.wordsTitle), findsOneWidget);
      final banner = tester.widget<SvgPicture>(find.byType(SvgPicture).at(0));
      expect((banner.pictureProvider as ExactAssetPicture).assetName, BannerUrl.words);
      final searchIcon = tester.widget<SvgPicture>(find.byType(SvgPicture).at(2));
      expect((searchIcon.pictureProvider as ExactAssetPicture).assetName, IconUrl.search);

      expect(find.byType(SliverFillRemaining), findsOneWidget);
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('creates full grid word item when filtered words load success', (tester) async {
      when(() => mockFilteredWordsBloc.state).thenReturn(const FilteredWordsLoadSuccess(currentFilter: Filter.searched, filteredWords: words));

      await tester.pumpWidget(MaterialApp(
        localizationsDelegates: JStrings.localizationsDelegates,
        supportedLocales: JStrings.supportedLocales,
        builder: (context, child) => MultiBlocProvider(
          providers: [
            BlocProvider<WordsBloc>(create: (context) => mockWordsBloc),
            BlocProvider<FilteredWordsBloc>(create: (context) => mockFilteredWordsBloc),
          ],
          child: const WordsView(),
        ),
      ));
      final strings = JStrings.of(tester.element(find.byType(WordsView)))!;

      expect(find.byType(FlexibleScaffold), findsOneWidget);
      expect(find.text(strings.wordsTitle), findsOneWidget);
      final banner = tester.widget<SvgPicture>(find.byType(SvgPicture).at(0));
      expect((banner.pictureProvider as ExactAssetPicture).assetName, BannerUrl.words);
      final searchIcon = tester.widget<SvgPicture>(find.byType(SvgPicture).at(2));
      expect((searchIcon.pictureProvider as ExactAssetPicture).assetName, IconUrl.search);

      expect(find.byType(SliverGrid), findsOneWidget);
      expect(find.byType(WordItem), findsNWidgets(9));
    });
  });
}

const words = [
  WordViewModel(
    id: 'あめ',
    romaji: 'ame',
    kanaType: KanaType.hiragana,
    imageUrl: ImageUrl.empty,
    translate: 'chuva',
    kanas: [
      KanaViewModel(id: 'あ', kanaType: KanaType.hiragana, romaji: 'a', strokes: [], correctCount: 0, wrongCount: 0),
      KanaViewModel(id: 'め', kanaType: KanaType.hiragana, romaji: 'me', strokes: [], correctCount: 0, wrongCount: 0),
    ],
    correctCount: 0,
    wrongCount: 0,
  ),
  WordViewModel(
    id: 'けしゴム',
    romaji: 'keshigomu',
    kanaType: KanaType.hiragana,
    imageUrl: ImageUrl.empty,
    translate: 'borracha',
    kanas: [
      KanaViewModel(id: 'け', kanaType: KanaType.hiragana, romaji: 'ke', strokes: [], correctCount: 0, wrongCount: 0),
      KanaViewModel(id: 'し', kanaType: KanaType.hiragana, romaji: 'shi', strokes: [], correctCount: 0, wrongCount: 0),
      KanaViewModel(id: 'ゴ', kanaType: KanaType.katakana, romaji: 'go', strokes: [], correctCount: 0, wrongCount: 0),
      KanaViewModel(id: 'ム', kanaType: KanaType.katakana, romaji: 'mu', strokes: [], correctCount: 0, wrongCount: 0),
    ],
    correctCount: 0,
    wrongCount: 0,
  ),
  WordViewModel(
    id: 'サラダ',
    romaji: 'sarada',
    kanaType: KanaType.hiragana,
    imageUrl: ImageUrl.empty,
    translate: 'salada',
    kanas: [
      KanaViewModel(id: 'サ', kanaType: KanaType.katakana, romaji: 'sa', strokes: [], correctCount: 0, wrongCount: 0),
      KanaViewModel(id: 'ラ', kanaType: KanaType.katakana, romaji: 'ra', strokes: [], correctCount: 0, wrongCount: 0),
      KanaViewModel(id: 'ダ', kanaType: KanaType.katakana, romaji: 'da', strokes: [], correctCount: 0, wrongCount: 0),
    ],
    correctCount: 0,
    wrongCount: 0,
  ),
  WordViewModel(
    id: 'うし',
    romaji: 'ushi',
    kanaType: KanaType.hiragana,
    imageUrl: ImageUrl.empty,
    translate: 'vaca',
    kanas: [
      KanaViewModel(id: 'う', kanaType: KanaType.hiragana, romaji: 'u', strokes: [], correctCount: 0, wrongCount: 0),
      KanaViewModel(id: 'し', kanaType: KanaType.hiragana, romaji: 'shi', strokes: [], correctCount: 0, wrongCount: 0),
    ],
    correctCount: 0,
    wrongCount: 0,
  ),
  WordViewModel(
    id: 'うま',
    romaji: 'uma',
    kanaType: KanaType.hiragana,
    imageUrl: ImageUrl.empty,
    translate: 'cavalo',
    kanas: [
      KanaViewModel(id: 'う', kanaType: KanaType.hiragana, romaji: 'u', strokes: [], correctCount: 0, wrongCount: 0),
      KanaViewModel(id: 'ま', kanaType: KanaType.hiragana, romaji: 'ma', strokes: [], correctCount: 0, wrongCount: 0),
    ],
    correctCount: 0,
    wrongCount: 0,
  ),
  WordViewModel(
    id: 'しま',
    romaji: 'shima',
    kanaType: KanaType.hiragana,
    imageUrl: ImageUrl.empty,
    translate: 'ilha',
    kanas: [
      KanaViewModel(id: 'し', kanaType: KanaType.hiragana, romaji: 'shi', strokes: [], correctCount: 0, wrongCount: 0),
      KanaViewModel(id: 'ま', kanaType: KanaType.hiragana, romaji: 'ma', strokes: [], correctCount: 0, wrongCount: 0),
    ],
    correctCount: 0,
    wrongCount: 0,
  ),
  WordViewModel(
    id: 'あらし',
    romaji: 'arashi',
    kanaType: KanaType.hiragana,
    imageUrl: ImageUrl.empty,
    translate: 'tempestada',
    kanas: [
      KanaViewModel(id: 'あ', kanaType: KanaType.hiragana, romaji: 'a', strokes: [], correctCount: 0, wrongCount: 0),
      KanaViewModel(id: 'ら', kanaType: KanaType.hiragana, romaji: 'ra', strokes: [], correctCount: 0, wrongCount: 0),
      KanaViewModel(id: 'し', kanaType: KanaType.hiragana, romaji: 'shi', strokes: [], correctCount: 0, wrongCount: 0),
    ],
    correctCount: 0,
    wrongCount: 0,
  ),
  WordViewModel(
    id: 'しろ',
    romaji: 'shiro',
    kanaType: KanaType.hiragana,
    imageUrl: ImageUrl.empty,
    translate: 'branco',
    kanas: [
      KanaViewModel(id: 'し', kanaType: KanaType.hiragana, romaji: 'shi', strokes: [], correctCount: 0, wrongCount: 0),
      KanaViewModel(id: 'ろ', kanaType: KanaType.hiragana, romaji: 'ro', strokes: [], correctCount: 0, wrongCount: 0),
    ],
    correctCount: 0,
    wrongCount: 0,
  ),
  WordViewModel(
    id: 'はし',
    romaji: 'hashi',
    kanaType: KanaType.hiragana,
    imageUrl: ImageUrl.empty,
    translate: 'chopsticks',
    kanas: [
      KanaViewModel(id: 'は', kanaType: KanaType.hiragana, romaji: 'ha', strokes: [], correctCount: 0, wrongCount: 0),
      KanaViewModel(id: 'し', kanaType: KanaType.hiragana, romaji: 'shi', strokes: [], correctCount: 0, wrongCount: 0),
    ],
    correctCount: 0,
    wrongCount: 0,
  ),
];
