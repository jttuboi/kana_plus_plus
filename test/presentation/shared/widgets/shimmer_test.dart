import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kwriting/presentation/shared/shared.dart';

void main() {
  group('Shimmer', () {
    testWidgets('renders correctly', (tester) async {
      final key = GlobalKey();
      await tester.pumpWidget(MaterialApp(
        home: Shimmer(
          child: Container(key: key),
        ),
      ));

      expect(find.byType(ShaderMask), findsOneWidget);
      expect(find.ancestor(of: find.byKey(key), matching: find.byType(ShaderMask)), findsOneWidget);
    });
  });
}
