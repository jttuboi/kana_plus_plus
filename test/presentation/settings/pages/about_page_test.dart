import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kwriting/domain/domain.dart';
import 'package:kwriting/presentation/settings/settings.dart';
import 'package:kwriting/presentation/shared/shared.dart';
import 'package:mocktail/mocktail.dart';

import '../../../utils/mocks.dart';

void main() {
  group('AboutPage', () {
    final mockInfoGetter = MockInfoGetter();
    final mockRateLauncher = MockRateLauncher();
    final mockShareLauncher = MockShareLauncher();
    final mockUrlLauncher = MockUrlLauncher();

    void setPixel4ScreenSize(WidgetTester tester) {
      tester.binding.window.physicalSizeTestValue = const Size(1080, 2280);
      tester.binding.window.devicePixelRatioTestValue = 1;
      addTearDown(tester.binding.window.clearPhysicalSizeTestValue);
    }

    testWidgets('renders correctly', (tester) async {
      setPixel4ScreenSize(tester);
      when(() => mockInfoGetter.version).thenAnswer((_) => Future.value('0.0.0'));
      await tester.pumpWidget(MaterialApp(
        home: AboutPage(
          infoGetter: mockInfoGetter,
          rateLauncher: mockRateLauncher,
          shareLauncher: mockShareLauncher,
          urlLauncher: mockUrlLauncher,
          supportButton: const FakeSupportButton(),
        ),
        localizationsDelegates: JStrings.localizationsDelegates,
        supportedLocales: JStrings.supportedLocales,
      ));
      final strings = JStrings.of(tester.element(find.byType(AboutPage)))!;

      expect(find.byType(FlexibleScaffold), findsOneWidget);
      expect(find.text(strings.settingsAbout), findsOneWidget);
      expect(find.byType(SliverPadding), findsOneWidget);
      expect(find.byType(SliverFillRemaining), findsOneWidget);

      // before version loaded
      expect(find.byType(CircularProgressIndicator), findsOneWidget);

      await tester.pumpAndSettle();

      // after version loaded
      expect(find.byType(CircularProgressIndicator), findsNothing);
      expect(find.byType(ClipRRect), findsOneWidget);
      expect(find.byType(Image), findsOneWidget);
      expect(find.text(strings.aboutAppVersionTitle), findsOneWidget);
      expect(find.text(strings.aboutDeveloperTitle), findsOneWidget);
      expect(find.text('0.0.0'), findsOneWidget);
      expect(find.text(Developer.name), findsOneWidget);
      expect(find.text(strings.aboutContactTitle), findsOneWidget);
      expect(find.byType(RateButton), findsOneWidget);
      expect(find.byType(ShareButton), findsOneWidget);
    });
  });
}
