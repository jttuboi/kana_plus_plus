import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kwriting/domain/domain.dart';
import 'package:kwriting/presentation/words/words.dart';

void main() {
  group('WordItem', () {
    testWidgets('renders correctly', (tester) async {
      await tester.pumpWidget(MaterialApp(
        home: Material(
          child: WordItem(
            word: 'word',
            imageUrl: ImageUrl.empty,
            onTap: () {},
          ),
        ),
      ));

      expect(find.byType(InkWell), findsOneWidget);
      expect(find.byType(Card), findsOneWidget);
      expect(find.byType(Stack), findsNWidgets(2));
      expect(find.byType(Hero), findsOneWidget);
      expect(find.byType(SvgPicture), findsOneWidget);
      expect(find.byType(FittedBox), findsNWidgets(2));
      expect(find.text('word'), findsNWidgets(2));
    });

    testWidgets('taps on item', (tester) async {
      var isTapped = false;
      await tester.pumpWidget(MaterialApp(
        home: Material(
          child: WordItem(
            word: 'word',
            imageUrl: ImageUrl.empty,
            onTap: () => isTapped = true,
          ),
        ),
      ));

      await tester.tap(find.byType(InkWell));

      expect(isTapped, isTrue);
    });
  });
}
