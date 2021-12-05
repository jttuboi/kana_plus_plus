import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kwriting/domain/domain.dart';
import 'package:kwriting/presentation/study/study.dart';

void main() {
  group('StudyTabHiragana', () {
    testWidgets('renders correctly', (tester) async {
      await tester.pumpWidget(const MaterialApp(
        localizationsDelegates: JStrings.localizationsDelegates,
        supportedLocales: JStrings.supportedLocales,
        home: StudyTabHiragana(),
      ));
      final strings = JStrings.of(tester.element(find.byType(StudyTabHiragana)))!;

      expect(find.byType(SingleChildScrollView), findsOneWidget);
      expect(find.byType(StudyText), findsNWidgets(4));
      expect(find.byType(StudyTable), findsNWidgets(4));
      expect(find.byType(StudyRow), findsNWidgets(28));
      expect(find.text(strings.studyHiraganaText1), findsOneWidget);
      expect(find.text(strings.studyMonographsTitle), findsOneWidget);
      expect(find.text(strings.studyHiraganaText2), findsOneWidget);
      expect(find.text(strings.studyDiacriticsTitle), findsOneWidget);
      expect(find.text(strings.studyHiraganaText3), findsOneWidget);
      expect(find.text(strings.studyDigraphsTitle), findsOneWidget);
      expect(find.text(strings.studyHiraganaText4), findsOneWidget);
      expect(find.text(strings.studyGeminatedTitle), findsOneWidget);
    });
  });
}
