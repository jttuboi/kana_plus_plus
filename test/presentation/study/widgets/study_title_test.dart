import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kwriting/presentation/study/study.dart';

void main() {
  group('StudyTitle', () {
    testWidgets('renders correctly', (tester) async {
      await tester.pumpWidget(const MaterialApp(
        home: StudyTitle(title: 'title'),
      ));

      expect(find.byType(Padding), findsOneWidget);
      expect(find.text('title'), findsOneWidget);
    });
  });
}
