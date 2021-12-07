import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kwriting/presentation/settings/settings.dart';

void main() {
  group('SubHeaderTile', () {
    testWidgets('renders correctly', (tester) async {
      await tester.pumpWidget(const MaterialApp(home: SubHeaderTile('title')));

      expect(find.text('title'), findsOneWidget);
      expect(find.byType(Container), findsOneWidget);
    });
  });
}
