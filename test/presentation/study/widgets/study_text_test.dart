import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kwriting/presentation/study/study.dart';

void main() {
  group('StudyText', () {
    testWidgets('renders correctly', (tester) async {
      await tester.pumpWidget(const MaterialApp(
        home: StudyText(text: 'text'),
      ));

      expect(find.byType(Padding), findsOneWidget);
      expect(find.text('text'), findsOneWidget);
    });
  });
}
