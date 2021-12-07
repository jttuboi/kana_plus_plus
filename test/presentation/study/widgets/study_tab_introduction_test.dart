import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kwriting/domain/domain.dart';
import 'package:kwriting/presentation/study/study.dart';

void main() {
  group('StudyTabIntroduction', () {
    testWidgets('renders correctly', (tester) async {
      await tester.pumpWidget(const MaterialApp(
        localizationsDelegates: JStrings.localizationsDelegates,
        supportedLocales: JStrings.supportedLocales,
        home: StudyTabIntroduction(),
      ));
      final strings = JStrings.of(tester.element(find.byType(StudyTabIntroduction)))!;

      expect(find.byType(SingleChildScrollView), findsOneWidget);
      expect(find.byType(StudyText), findsNWidgets(2));
      expect(find.byType(StudyTitle), findsOneWidget);
      expect(find.text(strings.studyIntroductionText), findsOneWidget);
      expect(find.text(strings.studyAlphabetTitle), findsOneWidget);
      expect(find.text(strings.studyAlphabetText), findsOneWidget);
    });
  });
}
