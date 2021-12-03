import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kwriting/domain/domain.dart';
import 'package:kwriting/presentation/shared/shared.dart';

void main() {
  group('DefaultTile', () {
    testWidgets('renders correctly', (tester) async {
      await tester.pumpWidget(MaterialApp(
        home: Material(
          child: DefaultTile(
            title: 'title',
            subtitle: 'subtitle',
            iconUrl: IconUrl.empty,
            onTap: () {},
          ),
        ),
      ));

      expect(find.ancestor(of: find.text('title'), matching: find.byType(ListTile)), findsOneWidget);
      expect(find.ancestor(of: find.text('subtitle'), matching: find.byType(ListTile)), findsOneWidget);
      expect(find.byType(SvgPicture), findsOneWidget);
    });

    testWidgets('can tap', (tester) async {
      var tapped = false;

      await tester.pumpWidget(MaterialApp(
        home: Material(
          child: DefaultTile(
            title: 'title',
            subtitle: 'subtitle',
            iconUrl: IconUrl.empty,
            onTap: () => tapped = true,
          ),
        ),
      ));

      await tester.tap(find.byType(ListTile));

      expect(tapped, isTrue);
    });
  });
}
