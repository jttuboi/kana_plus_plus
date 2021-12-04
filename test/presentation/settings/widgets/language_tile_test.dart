// ignore_for_file: avoid_redundant_argument_values

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kwriting/domain/domain.dart';
import 'package:kwriting/presentation/menu/menu.dart';
import 'package:kwriting/presentation/settings/settings.dart';
import 'package:kwriting/presentation/shared/shared.dart';
import 'package:mocktail/mocktail.dart';

import '../../../utils/mocks.dart';

void main() {
  group('LanguageTile', () {
    final mockAppCubit = MockAppCubit();

    Future<void> pumpLanguageTile(WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider<AppCubit>(
            create: (context) => mockAppCubit,
            child: const Material(child: LanguageTile()),
          ),
          localizationsDelegates: JStrings.localizationsDelegates,
          supportedLocales: JStrings.supportedLocales,
        ),
      );
    }

    testWidgets('renders correctly with english', (tester) async {
      when(() => mockAppCubit.state).thenReturn(const AppLoaded(languageCode: 'en'));

      await pumpLanguageTile(tester);
      final strings = JStrings.of(tester.element(find.byType(LanguageTile)))!;

      expect(find.text(strings.settingsLanguage), findsOneWidget);
      expect(find.text('English'), findsOneWidget);
      expect(find.byType(DefaultTile), findsOneWidget);
      expect(find.byType(SvgPicture), findsOneWidget);
    });

    testWidgets('renders correctly with portuguese', (tester) async {
      when(() => mockAppCubit.state).thenReturn(const AppLoaded(languageCode: 'pt'));

      await pumpLanguageTile(tester);
      final strings = JStrings.of(tester.element(find.byType(LanguageTile)))!;

      expect(find.text(strings.settingsLanguage), findsOneWidget);
      expect(find.text('Português brasileiro'), findsOneWidget);
      expect(find.byType(DefaultTile), findsOneWidget);
      expect(find.byType(SvgPicture), findsOneWidget);
    });

    testWidgets('renders correctly with spanish', (tester) async {
      when(() => mockAppCubit.state).thenReturn(const AppLoaded(languageCode: 'es'));

      await pumpLanguageTile(tester);
      final strings = JStrings.of(tester.element(find.byType(LanguageTile)))!;

      expect(find.text(strings.settingsLanguage), findsOneWidget);
      expect(find.text('Español'), findsOneWidget);
      expect(find.byType(DefaultTile), findsOneWidget);
      expect(find.byType(SvgPicture), findsOneWidget);
    });
  });
}
