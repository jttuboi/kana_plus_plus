// ignore_for_file: avoid_redundant_argument_values

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kwriting/domain/domain.dart';
import 'package:kwriting/presentation/menu/menu.dart';
import 'package:kwriting/presentation/shared/shared.dart';
import 'package:mocktail/mocktail.dart';

import '../../../utils/mocks.dart';

void main() {
  void setPixel4ScreenSize(WidgetTester tester) {
    tester.binding.window.physicalSizeTestValue = const Size(1080, 2280);
    tester.binding.window.devicePixelRatioTestValue = 1;
    addTearDown(tester.binding.window.clearPhysicalSizeTestValue);
  }

  group('MenuPage', () {
    final mockAppCubit = MockAppCubit();

    Future<void> pumpMenuPage(WidgetTester tester) async {
      setPixel4ScreenSize(tester);
      await tester.pumpWidget(
        MaterialApp(
          localizationsDelegates: JStrings.localizationsDelegates,
          supportedLocales: JStrings.supportedLocales,
          home: BlocProvider<AppCubit>(
            create: (context) => mockAppCubit,
            child: const MenuPage(supportButton: FakeSupportButton()),
          ),
        ),
      );
    }

    testWidgets('renders CircularProgressIndicator when AppLoadInProgress', (tester) async {
      when(() => mockAppCubit.state).thenReturn(const AppLoadInProgress());
      await pumpMenuPage(tester);

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('renders Introduction when AppLoaded.isFirstTimeOpenApp == true', (tester) async {
      when(() => mockAppCubit.state).thenReturn(const AppLoaded(isFirstTimeOpenApp: true));
      await pumpMenuPage(tester);

      expect(find.byType(Introduction), findsOneWidget);
    });

    testWidgets('renders MenuBackground when AppLoaded.isFirstTimeOpenApp == false', (tester) async {
      when(() => mockAppCubit.state).thenReturn(const AppLoaded(isFirstTimeOpenApp: false));
      await pumpMenuPage(tester);

      expect(find.byType(Scaffold), findsOneWidget);
      expect(find.descendant(of: find.byType(Stack), matching: find.byType(MenuBackground)), findsOneWidget);
      expect(find.descendant(of: find.byType(Stack), matching: find.byType(MenuContent)), findsOneWidget);
    });
  });

  group('MenuContent', () {
    const fakeSupportButton = FakeSupportButton();
    testWidgets('renders correctly', (tester) async {
      setPixel4ScreenSize(tester);
      await tester.pumpWidget(const MaterialApp(
        home: Material(
          child: MenuContent(
            supportButton: fakeSupportButton,
          ),
        ),
        localizationsDelegates: JStrings.localizationsDelegates,
        supportedLocales: JStrings.supportedLocales,
      ));

      expect(find.byType(SafeArea), findsOneWidget);
      expect(find.byType(Flexible), findsNWidgets(3));
      expect(find.text(App.title.toUpperCase()), findsOneWidget);

      // four buttons
      expect(find.byType(GridView), findsOneWidget);
      expect(find.byType(MenuButton), findsNWidgets(4));

      // bottom buttons
      expect(find.byType(ShareButton), findsOneWidget);
      expect(find.byType(FakeSupportButton), findsOneWidget);
    });
  });

  group('MenuButton', () {
    testWidgets('renders correctly', (tester) async {
      await tester.pumpWidget(MaterialApp(
        home: MenuButton(
          title: 'title',
          iconUrl: IconUrl.empty,
          onPressed: () {},
        ),
      ));

      expect(find.byType(ElevatedButton), findsOneWidget);
      expect(find.byType(Column), findsOneWidget);
      expect(find.byType(SvgPicture), findsOneWidget);
      expect(find.byType(FittedBox), findsOneWidget);
      expect(find.text('title'), findsOneWidget);
    });

    testWidgets('returns pressed event', (tester) async {
      var isPressed = false;
      await tester.pumpWidget(MaterialApp(
        home: MenuButton(
          title: 'title',
          iconUrl: IconUrl.empty,
          onPressed: () {
            isPressed = true;
          },
        ),
      ));

      await tester.tap(find.byType(ElevatedButton));

      expect(isPressed, isTrue);
    });
  });
}
