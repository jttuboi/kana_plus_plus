// ignore_for_file: avoid_redundant_argument_values

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kwriting/domain/domain.dart';
import 'package:kwriting/presentation/menu/menu.dart';
import 'package:kwriting/presentation/settings/settings.dart';
import 'package:kwriting/presentation/shared/shared.dart';
import 'package:mocktail/mocktail.dart';

import '../../../utils/mocks.dart';

void main() {
  group('SettingsPage', () {
    final mockUrlLauncher = MockUrlLauncher();
    final mockAppCubit = MockAppCubit();
    final mockShowHintRepository = MockShowHintRepository();
    final mockKanaTypeRepository = MockKanaTypeRepository();
    final mockQuantityOfWordsRepository = MockQuantityOfWordsRepository();

    void setPixel4ScreenSize(WidgetTester tester) {
      tester.binding.window.physicalSizeTestValue = const Size(1080, 2280);
      tester.binding.window.devicePixelRatioTestValue = 1;
      addTearDown(tester.binding.window.clearPhysicalSizeTestValue);
    }

    testWidgets('renders correctly', (tester) async {
      setPixel4ScreenSize(tester);
      when(() => mockAppCubit.state).thenReturn(const AppLoaded(isFirstTimeOpenApp: false, languageCode: 'en'));
      when(mockShowHintRepository.getShowHint).thenAnswer((_) => Future.value(true));
      when(mockKanaTypeRepository.getKanaType).thenAnswer((_) => Future.value(KanaType.both));
      when(mockQuantityOfWordsRepository.getQuantityOfWords).thenAnswer((_) => Future.value(5));

      await tester.pumpWidget(
        MaterialApp(
          localizationsDelegates: JStrings.localizationsDelegates,
          supportedLocales: JStrings.supportedLocales,
          home: BlocProvider<AppCubit>(
            create: (context) => mockAppCubit,
            child: SettingsPage(
              showHintRepository: mockShowHintRepository,
              kanaTypeRepository: mockKanaTypeRepository,
              quantityOfWordsRepository: mockQuantityOfWordsRepository,
              urlLauncher: mockUrlLauncher,
            ),
          ),
        ),
      );
      final strings = JStrings.of(tester.element(find.byType(SettingsPage)))!;

      expect(find.text(strings.settingsTitle), findsOneWidget);
      expect(find.byType(FlexibleScaffold), findsOneWidget);
      expect(find.byType(SliverFillRemaining), findsOneWidget);
      expect(find.byType(ListView), findsOneWidget);
      expect(find.byType(SubHeaderTile), findsNWidgets(3));
      expect(find.text(strings.settingsBasic), findsOneWidget);
      expect(find.text(strings.settingsDefaultTrainingSetting), findsOneWidget);
      expect(find.text(strings.settingsOthers), findsOneWidget);
      expect(find.byType(Divider), findsNWidgets(2));
      expect(find.byType(LanguageTile), findsOneWidget);
      expect(find.byType(ShowHintTile), findsOneWidget);
      expect(find.byType(KanaTypeTile), findsOneWidget);
      expect(find.byType(QuantityOfWordsTile), findsOneWidget);
      expect(find.text(strings.settingsAbout), findsOneWidget);
      expect(find.text(strings.settingsPrivacyPolicy), findsOneWidget);
    });
  });
}
