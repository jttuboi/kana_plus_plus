import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kwriting/domain/domain.dart';
import 'package:kwriting/presentation/words/words.dart';

void main() {
  group('WordsSearchDelegate', () {
    test('starts properly', () {
      final searchDelegate = WordsSearchDelegate(
        words: words,
        searchFieldLabel: 'label show in field before write',
      );

      expect(searchDelegate.words, words);
      expect(searchDelegate.searchFieldLabel, 'label show in field before write');
      expect(searchDelegate.keyboardType, TextInputType.text);
    });

    testWidgets('renders search page correctly', (tester) async {
      final inkWellKey = UniqueKey();
      await tester.pumpWidget(MaterialApp(home: Material(child: Builder(builder: (context) {
        return InkWell(
          key: inkWellKey,
          onTap: () async => showSearch(delegate: WordsSearchDelegate(words: words, searchFieldLabel: 'field label'), context: context),
        );
      }))));

      // access show search tapping
      expect(find.byKey(inkWellKey), findsOneWidget);
      await tester.tap(find.byKey(inkWellKey));
      await tester.pumpAndSettle();

      // check search page opened
      expect(find.text('field label'), findsOneWidget);

      // check actions
      final iconBack = tester.widget<SvgPicture>(find.byType(SvgPicture).at(0));
      expect((iconBack.pictureProvider as ExactAssetPicture).assetName, IconUrl.back);

      // check leading
      final clearBack = tester.widget<SvgPicture>(find.byType(SvgPicture).at(1));
      expect((clearBack.pictureProvider as ExactAssetPicture).assetName, IconUrl.clear);

      // check suggestions list
      expect(find.byType(ListView), findsOneWidget);
      final findListTiles = find.descendant(of: find.byType(ListView), matching: find.byType(ListTile));
      expect(findListTiles, findsNWidgets(4));
      expect((tester.widget<ListTile>(findListTiles.at(0)).title! as Text).data, 'あめ - ame');
      expect((tester.widget<ListTile>(findListTiles.at(0)).subtitle! as Text).data, 'chuva');
      expect((tester.widget<ListTile>(findListTiles.at(1)).title! as Text).data, 'けしゴム - keshigomu');
      expect((tester.widget<ListTile>(findListTiles.at(1)).subtitle! as Text).data, 'borracha');
      expect((tester.widget<ListTile>(findListTiles.at(2)).title! as Text).data, 'サラダ - sarada');
      expect((tester.widget<ListTile>(findListTiles.at(2)).subtitle! as Text).data, 'salada');
      expect((tester.widget<ListTile>(findListTiles.at(3)).title! as Text).data, 'うし - ushi');
      expect((tester.widget<ListTile>(findListTiles.at(3)).subtitle! as Text).data, 'vaca');

      expect(find.byType(TextField), findsOneWidget);
    });

    testWidgets('searchs something and shows words list searched', (tester) async {
      final inkWellKey = UniqueKey();
      await tester.pumpWidget(MaterialApp(home: Material(child: Builder(builder: (context) {
        return InkWell(
          key: inkWellKey,
          onTap: () async => showSearch(delegate: WordsSearchDelegate(words: words, searchFieldLabel: ''), context: context),
        );
      }))));

      // access show search tapping
      expect(find.byKey(inkWellKey), findsOneWidget);
      await tester.tap(find.byKey(inkWellKey));
      await tester.pumpAndSettle();

      // add text on search text field
      expect(find.byType(TextField), findsOneWidget);
      await tester.enterText(find.byType(TextField), 'し');
      await tester.pumpAndSettle();

      // check suggestions list
      expect(find.byType(ListView), findsOneWidget);
      final findListTiles = find.descendant(of: find.byType(ListView), matching: find.byType(ListTile));
      expect(findListTiles, findsNWidgets(6));
      expect((tester.widget<ListTile>(findListTiles.at(0)).title! as Text).data, 'けしゴム - keshigomu');
      expect((tester.widget<ListTile>(findListTiles.at(0)).subtitle! as Text).data, 'borracha');
      expect((tester.widget<ListTile>(findListTiles.at(1)).title! as Text).data, 'うし - ushi');
      expect((tester.widget<ListTile>(findListTiles.at(1)).subtitle! as Text).data, 'vaca');
      expect((tester.widget<ListTile>(findListTiles.at(2)).title! as Text).data, 'しま - shima');
      expect((tester.widget<ListTile>(findListTiles.at(2)).subtitle! as Text).data, 'ilha');
      expect((tester.widget<ListTile>(findListTiles.at(3)).title! as Text).data, 'あらし - arashi');
      expect((tester.widget<ListTile>(findListTiles.at(3)).subtitle! as Text).data, 'tempestada');
      expect((tester.widget<ListTile>(findListTiles.at(4)).title! as Text).data, 'しろ - shiro');
      expect((tester.widget<ListTile>(findListTiles.at(4)).subtitle! as Text).data, 'branco');
      expect((tester.widget<ListTile>(findListTiles.at(5)).title! as Text).data, 'はし - hashi');
      expect((tester.widget<ListTile>(findListTiles.at(5)).subtitle! as Text).data, 'chopsticks');
    });

    testWidgets('clears the text of the text field', (tester) async {
      final inkWellKey = UniqueKey();
      await tester.pumpWidget(MaterialApp(home: Material(child: Builder(builder: (context) {
        return InkWell(
          key: inkWellKey,
          onTap: () async => showSearch(delegate: WordsSearchDelegate(words: words, searchFieldLabel: ''), context: context),
        );
      }))));

      // access show search tapping
      expect(find.byKey(inkWellKey), findsOneWidget);
      await tester.tap(find.byKey(inkWellKey));
      await tester.pumpAndSettle();

      // add text on search text field
      expect(find.byType(TextField), findsOneWidget);
      await tester.enterText(find.byType(TextField), 'し');
      await tester.pumpAndSettle();

      // check has text し before clear
      expect(find.text('し'), findsOneWidget);

      // click clear button
      await tester.tap(find.byType(SvgPicture).at(1));
      await tester.pump();

      // check has text し after clear
      expect(find.text('し'), findsNothing);
    });

    testWidgets('clicks back button', (tester) async {
      var searchResult = 'garbage result only for clean by return result of showSearch';
      final inkWellKey = UniqueKey();
      await tester.pumpWidget(MaterialApp(home: Material(child: Builder(builder: (context) {
        return InkWell(
          key: inkWellKey,
          onTap: () async => searchResult = await showSearch(delegate: WordsSearchDelegate(words: words, searchFieldLabel: ''), context: context),
        );
      }))));

      // access show search tapping
      expect(find.byKey(inkWellKey), findsOneWidget);
      await tester.tap(find.byKey(inkWellKey));
      await tester.pumpAndSettle();

      // add text on search text field
      expect(find.byType(TextField), findsOneWidget);
      await tester.enterText(find.byType(TextField), 'し');
      await tester.pumpAndSettle();

      // check has text し
      expect(find.text('し'), findsOneWidget);

      // click back button
      await tester.tap(find.byType(SvgPicture).at(0));
      await tester.pump();

      // checks result
      expect(searchResult, isEmpty);
    });

    testWidgets('clicks enter to search', (tester) async {
      var searchResult = 'garbage result only for clean by return result of showSearch';
      final inkWellKey = UniqueKey();
      await tester.pumpWidget(MaterialApp(home: Material(child: Builder(builder: (context) {
        return InkWell(
          key: inkWellKey,
          onTap: () async => searchResult = await showSearch(delegate: WordsSearchDelegate(words: words, searchFieldLabel: ''), context: context),
        );
      }))));

      // access show search tapping
      expect(find.byKey(inkWellKey), findsOneWidget);
      await tester.tap(find.byKey(inkWellKey));
      await tester.pumpAndSettle();

      // add text on search text field
      expect(find.byType(TextField), findsOneWidget);
      await tester.enterText(find.byType(TextField), 'し');
      await tester.pumpAndSettle();

      // check has text し
      expect(find.text('し'), findsOneWidget);

      // click enter button to search
      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pump();

      // checks result
      expect(searchResult, 'し');
    });

    testWidgets('searchs kana, romaji or translate', (tester) async {
      var searchResult = 'garbage result only for clean by return result of showSearch';
      final inkWellKey = UniqueKey();
      await tester.pumpWidget(MaterialApp(home: Material(child: Builder(builder: (context) {
        return InkWell(
          key: inkWellKey,
          onTap: () async => searchResult = await showSearch(delegate: WordsSearchDelegate(words: words, searchFieldLabel: ''), context: context),
        );
      }))));

      // access show search tapping
      expect(find.byKey(inkWellKey), findsOneWidget);
      await tester.tap(find.byKey(inkWellKey));
      await tester.pumpAndSettle();

      // add kana text
      await tester.enterText(find.byType(TextField), 'あめ');
      await tester.pumpAndSettle();
      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pump();

      // checks kana text result
      expect(searchResult, 'あめ');

      // access show search tapping
      expect(find.byKey(inkWellKey), findsOneWidget);
      await tester.tap(find.byKey(inkWellKey));
      await tester.pumpAndSettle();

      // add romaji text
      await tester.enterText(find.byType(TextField), 'keshigomu');
      await tester.pumpAndSettle();
      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pump();

      // checks romaji text result
      expect(searchResult, 'keshigomu');

      // access show search tapping
      expect(find.byKey(inkWellKey), findsOneWidget);
      await tester.tap(find.byKey(inkWellKey));
      await tester.pumpAndSettle();

      // add translate text
      await tester.enterText(find.byType(TextField), 'vaca');
      await tester.pumpAndSettle();
      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pump();

      // checks translate text result
      expect(searchResult, 'vaca');
    });
  });
}

const words = [
  WordViewModel(
    id: 'あめ',
    romaji: 'ame',
    kanaType: KanaType.hiragana,
    imageUrl: 'rain.png',
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
    imageUrl: 'eraser.png',
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
    imageUrl: 'salad.png',
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
    imageUrl: 'cow.png',
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
    imageUrl: 'horse.png',
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
    imageUrl: 'island.png',
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
    imageUrl: 'storm.png',
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
    imageUrl: 'white.png',
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
    imageUrl: 'hashi.png',
    translate: 'chopsticks',
    kanas: [
      KanaViewModel(id: 'は', kanaType: KanaType.hiragana, romaji: 'ha', strokes: [], correctCount: 0, wrongCount: 0),
      KanaViewModel(id: 'し', kanaType: KanaType.hiragana, romaji: 'shi', strokes: [], correctCount: 0, wrongCount: 0),
    ],
    correctCount: 0,
    wrongCount: 0,
  ),
];
