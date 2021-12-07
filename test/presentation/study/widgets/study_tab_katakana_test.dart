import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kwriting/domain/domain.dart';
import 'package:kwriting/presentation/study/study.dart';

void main() {
  group('StudyTabKatakana', () {
    testWidgets('renders correctly', (tester) async {
      await tester.pumpWidget(const MaterialApp(
        localizationsDelegates: JStrings.localizationsDelegates,
        supportedLocales: JStrings.supportedLocales,
        home: StudyTabKatakana(),
      ));
      final strings = JStrings.of(tester.element(find.byType(StudyTabKatakana)))!;

      expect(find.byType(SingleChildScrollView), findsOneWidget);
      expect(find.byType(StudyText), findsNWidgets(6));
      expect(find.byType(StudyTable), findsNWidgets(6));
      expect(find.byType(StudyRow), findsNWidgets(54));
      expect(find.text(strings.studyKatakanaText1), findsOneWidget);
      expect(find.text(strings.studyMonographsTitle), findsOneWidget);
      expect(find.text(strings.studyKatakanaText2), findsOneWidget);
      expect(find.text(strings.studyDiacriticsTitle), findsOneWidget);
      expect(find.text(strings.studyKatakanaText3), findsOneWidget);
      expect(find.text(strings.studyDigraphsTitle), findsOneWidget);
      expect(find.text(strings.studyKatakanaText4), findsOneWidget);
      expect(find.text(strings.studyGeminatedTitle), findsOneWidget);
      expect(find.text(strings.studyKatakanaText5), findsOneWidget);
      expect(find.text(strings.studyLongVowelsTitle), findsOneWidget);
      expect(find.text(strings.studyKatakanaText6), findsOneWidget);
      expect(find.text(strings.studyExtraSyllabesTitle), findsOneWidget);
    });
  });
}
