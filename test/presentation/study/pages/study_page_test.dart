import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kwriting/domain/domain.dart';
import 'package:kwriting/presentation/shared/shared.dart';
import 'package:kwriting/presentation/study/study.dart';

void main() {
  group('StudyPage', () {
    Future<void> pumpStudyPage(WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(
        localizationsDelegates: JStrings.localizationsDelegates,
        supportedLocales: JStrings.supportedLocales,
        home: StudyPage(),
      ));
    }

    testWidgets('renders correctly', (tester) async {
      await pumpStudyPage(tester);
      final strings = JStrings.of(tester.element(find.byType(StudyPage)))!;

      expect(find.byType(FlexibleScaffold), findsOneWidget);
      expect(find.text(strings.studyTitle), findsOneWidget);
      expect(find.text(strings.studyIntroductionTitle), findsOneWidget);
      expect(find.text(strings.studyHiraganaTitle), findsOneWidget);
      expect(find.text(strings.studyKatakanaTitle), findsOneWidget);
      expect(find.byType(Tab), findsNWidgets(3));
      expect(find.byType(TabBarView), findsOneWidget);
      expect(find.byType(StudyTabIntroduction), findsOneWidget);
    });

    testWidgets('changes tab', (tester) async {
      await pumpStudyPage(tester);
      final strings = JStrings.of(tester.element(find.byType(StudyPage)))!;

      // hiragana tab
      await tester.tap(find.text(strings.studyHiraganaTitle));
      await tester.pumpAndSettle();

      expect(find.byType(StudyTabHiragana), findsOneWidget);

      // katakana tab
      await tester.tap(find.text(strings.studyKatakanaTitle));
      await tester.pumpAndSettle();

      expect(find.byType(StudyTabKatakana), findsOneWidget);

      // introduction tab
      await tester.tap(find.text(strings.studyIntroductionTitle));
      await tester.pumpAndSettle();

      expect(find.byType(StudyTabIntroduction), findsOneWidget);
    });
  });
}
