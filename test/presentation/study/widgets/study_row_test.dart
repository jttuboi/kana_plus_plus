import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kwriting/presentation/study/study.dart';

void main() {
  group('StudyRow', () {
    testWidgets('renders correctly', (tester) async {
      const studiesData = [
        StudyData('A', 'B'),
        StudyData('C', 'D'),
        StudyData('E', 'F'),
      ];
      await tester.pumpWidget(const MaterialApp(
        home: StudyRow(studiesData),
      ));

      expect(find.byType(Container), findsOneWidget);
      expect(find.byType(Row), findsOneWidget);
      final paints = tester.widgetList<CustomPaint>(find.byType(CustomPaint)).where((paint) => paint.painter is StudyContentPainter).toList();
      expect(paints.length, studiesData.length);
    });
  });
}
