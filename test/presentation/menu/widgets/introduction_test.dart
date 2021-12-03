import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:kwriting/domain/domain.dart';
import 'package:kwriting/presentation/menu/menu.dart';

void main() {
  group('Introduction', () {
    Future<void> pumpIntroduction(WidgetTester tester, VoidCallback onFinished) async {
      await tester.pumpWidget(MaterialApp(
        home: Introduction(onFinished: onFinished),
        localizationsDelegates: JStrings.localizationsDelegates,
        supportedLocales: JStrings.supportedLocales,
      ));
    }

    void setPixel4ScreenSize(WidgetTester tester) {
      tester.binding.window.physicalSizeTestValue = const Size(1080, 2280);
      tester.binding.window.devicePixelRatioTestValue = 1;
      addTearDown(tester.binding.window.clearPhysicalSizeTestValue);
    }

    Future<void> swipeToLeft(WidgetTester tester) async {
      final swipeToLeft = await tester.startGesture(const Offset(800, 500));
      await tester.pump(kLongPressTimeout + kPressTimeout);
      await swipeToLeft.moveTo(const Offset(200, 500));
      await swipeToLeft.up();
      await tester.pumpAndSettle();
    }

    testWidgets('renders correctly', (tester) async {
      await pumpIntroduction(tester, () {});
      final strings = JStrings.of(tester.element(find.byType(Introduction)))!;

      expect(find.byType(IntroductionScreen), findsOneWidget);

      // first page
      expect(find.byType(SvgPicture), findsOneWidget);
      expect(find.text(strings.introTitleWriting), findsOneWidget);
      expect(find.text(strings.introWriting), findsOneWidget);
    });

    testWidgets('changes page until finishes the introduction screen', (tester) async {
      var onFinishedIsPressed = false;
      setPixel4ScreenSize(tester);
      await pumpIntroduction(tester, () => onFinishedIsPressed = true);
      final strings = JStrings.of(tester.element(find.byType(Introduction)))!;

      // first page
      expect(find.byType(SvgPicture), findsOneWidget);
      expect(find.text(strings.introTitleWriting), findsOneWidget);
      expect(find.text(strings.introWriting), findsOneWidget);

      await swipeToLeft(tester);

      // second page
      expect(find.byType(SvgPicture), findsOneWidget);
      expect(find.text(strings.introTitleVocabulary), findsOneWidget);
      expect(find.text(strings.introVocabulary), findsOneWidget);

      await swipeToLeft(tester);

      // third page
      expect(find.byType(SvgPicture), findsOneWidget);
      expect(find.text(strings.introTitleStudy), findsOneWidget);
      expect(find.text(strings.introStudy), findsOneWidget);

      await swipeToLeft(tester);

      // fourth page
      expect(find.byType(SvgPicture), findsOneWidget);
      expect(find.text(strings.introTitleTraining), findsOneWidget);
      expect(find.text(strings.introTraining), findsOneWidget);

      await swipeToLeft(tester);

      // fifth page
      expect(find.byType(SvgPicture), findsOneWidget);
      expect(find.text(strings.introTitleRecommendation), findsOneWidget);
      expect(find.text(strings.introRecommendation), findsOneWidget);
      expect(find.byType(ElevatedButton), findsOneWidget);
      expect(find.text(strings.introLetsStarted), findsOneWidget);

      // press the let's started button
      await tester.tap(find.byType(ElevatedButton));

      expect(onFinishedIsPressed, isTrue);
    });
  });
}
