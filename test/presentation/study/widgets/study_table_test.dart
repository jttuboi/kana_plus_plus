import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kwriting/presentation/study/study.dart';

void main() {
  group('StudyTable', () {
    testWidgets('renders correctly', (tester) async {
      await tester.pumpWidget(const MaterialApp(
        home: StudyTable(
          title: 'title',
          rows: [
            StudyRow([]),
            StudyRow([]),
            StudyRow([]),
            StudyRow([]),
          ],
        ),
      ));

      expect(find.byType(StudyRow), findsNWidgets(4));
      expect(find.text('title'), findsOneWidget);
    });
  });
}
