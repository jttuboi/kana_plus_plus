import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kwriting/domain/domain.dart';
import 'package:kwriting/presentation/words/words.dart';

void main() {
  group('WordDetailPage', () {
    testWidgets('renders correctly', (tester) async {
      await tester.pumpWidget(const MaterialApp(
        localizationsDelegates: JStrings.localizationsDelegates,
        supportedLocales: JStrings.supportedLocales,
        home: WordDetailPage(
          WordViewModel(
              id: 'あめ',
              romaji: 'ame',
              kanaType: KanaType.both,
              imageUrl: ImageUrl.empty,
              translate: 'chuva',
              kanas: [
                KanaViewModel(id: 'あ', kanaType: KanaType.hiragana, romaji: 'a', strokes: [], correctCount: 1, wrongCount: 2),
                KanaViewModel(id: 'め', kanaType: KanaType.katakana, romaji: 'me', strokes: [], correctCount: 3, wrongCount: 4),
              ],
              correctCount: 5,
              wrongCount: 6),
        ),
      ));
      final strings = JStrings.of(tester.element(find.byType(WordDetailPage)))!;

      expect(find.byType(WillPopScope), findsOneWidget);
      expect(find.byType(Scaffold), findsOneWidget);
      expect(find.byType(SafeArea), findsOneWidget);
      expect(find.byType(InkWell), findsOneWidget);
      expect(find.byType(Hero), findsOneWidget);
      expect(find.byType(SvgPicture), findsOneWidget);
      expect(find.byType(Flexible), findsNWidgets(2));
      expect(find.byType(Spacer), findsNWidgets(3));
      expect(find.byType(SingleChildScrollView), findsOneWidget);
      expect(find.byType(KanasDetails), findsOneWidget);
      expect(find.text(strings.wordDetailRomaji), findsOneWidget);
      expect(find.text('ame'), findsOneWidget);
      expect(find.text(strings.wordDetailTranslate), findsOneWidget);
      expect(find.text('chuva'), findsOneWidget);
      expect(find.text(strings.correctWordCount), findsOneWidget);
      expect(find.text('5/11'), findsOneWidget);
      expect(find.text(strings.wrongWordCount), findsOneWidget);
      expect(find.text('6/11'), findsOneWidget);
      expect(find.text(strings.correctKanaCount('あ')), findsOneWidget);
      expect(find.text('1/3'), findsOneWidget);
      expect(find.text(strings.wrongKanaCount('あ')), findsOneWidget);
      expect(find.text('2/3'), findsOneWidget);
      expect(find.text(strings.correctKanaCount('め')), findsOneWidget);
      expect(find.text('3/7'), findsOneWidget);
      expect(find.text(strings.wrongKanaCount('め')), findsOneWidget);
      expect(find.text('4/7'), findsOneWidget);
    });
  });
}
