import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kwriting/domain/domain.dart';
import 'package:kwriting/presentation/shared/shared.dart';
import 'package:mocktail/mocktail.dart';

import '../../../utils/mocks.dart';

void main() {
  group('ShareLauncher', () {
    final mockShareLauncher = MockShareLauncher();

    testWidgets('renders correctly', (tester) async {
      await tester.pumpWidget(MaterialApp(
        localizationsDelegates: JStrings.localizationsDelegates,
        supportedLocales: JStrings.supportedLocales,
        home: Material(child: ShareButton(launcher: mockShareLauncher)),
      ));
      final strings = JStrings.of(tester.element(find.byType(ShareButton)))!;

      expect(find.ancestor(of: find.byType(IconButton), matching: find.byType(Column)), findsOneWidget);
      expect(find.ancestor(of: find.text(strings.aboutShare), matching: find.byType(Column)), findsOneWidget);
      expect(find.ancestor(of: find.byType(SvgPicture), matching: find.byType(IconButton)), findsOneWidget);
    });

    testWidgets('executes launch from RateLauncher', (tester) async {
      await tester.pumpWidget(MaterialApp(
        localizationsDelegates: JStrings.localizationsDelegates,
        supportedLocales: JStrings.supportedLocales,
        home: Material(child: ShareButton(launcher: mockShareLauncher)),
      ));
      final shareButtonContext = tester.element(find.byType(ShareButton));
      when(() => mockShareLauncher.launch(shareButtonContext)).thenAnswer((_) => Future.value());

      await tester.tap(find.byType(IconButton));

      verify(() => mockShareLauncher.launch(shareButtonContext)).called(1);
    });
  });
}
