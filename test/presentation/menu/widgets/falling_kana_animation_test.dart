import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kwriting/presentation/menu/menu.dart';

void main() {
  group('FallingKanaAnimation', () {
    Future<void> pumpFallingKanaAnimation(WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: Stack(
          children: const [
            FallingKanaAnimation(
              initialPosition: Offset(200, 200),
              endYPosition: 400,
              kanaSize: 20,
              durationInMilliseconds: 2000,
            ),
          ],
        ),
      ));
    }

    testWidgets('throws a AssertionError when uses durationInMilliseconds must be < 2000', (tester) async {
      await pumpFallingKanaAnimation(tester);

      expect(() async {
        await tester.pumpWidget(MaterialApp(
          home: Stack(
            children: [
              FallingKanaAnimation(
                initialPosition: const Offset(10, 10),
                endYPosition: 50,
                kanaSize: 20,
                durationInMilliseconds: 1999,
              ),
            ],
          ),
        ));
      }, throwsA(predicate((e) => e is AssertionError && e.message == 'durationInMilliseconds must be >= 2000')));
    });

    testWidgets('renders correctly', (tester) async {
      await pumpFallingKanaAnimation(tester);

      expect(find.byType(Positioned), findsOneWidget);
      expect(find.byType(Opacity), findsOneWidget);
      expect(find.byType(SvgPicture), findsOneWidget);
    });
  });
}
