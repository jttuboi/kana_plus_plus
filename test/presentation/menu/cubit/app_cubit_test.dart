// ignore_for_file: avoid_redundant_argument_values

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kwriting/presentation/menu/menu.dart';
import 'package:mocktail/mocktail.dart';

import '../../../utils/mocks.dart';

void main() {
  final mockAppRepository = MockAppRepository();
  final mockLanguageRepository = MockLanguageRepository();

  group('AppCubit', () {
    blocTest<AppCubit, AppState>(
      'starts emiting [AppState] when isFirstTime is true (simulates app opening at first time)',
      setUp: () {
        when(mockAppRepository.isFirstTime).thenAnswer((_) => Future.value(true));
      },
      build: () => AppCubit(mockAppRepository, mockLanguageRepository),
      expect: () => const [AppLoaded(isFirstTimeOpenApp: true)],
    );

    blocTest<AppCubit, AppState>(
      'starts emiting [AppState] with languageCode when isFirstTime is false (simulates app opening other time)',
      setUp: () {
        when(mockAppRepository.isFirstTime).thenAnswer((_) => Future.value(false));
        when(mockLanguageRepository.getLanguage).thenAnswer((_) => Future.value('pt'));
      },
      build: () => AppCubit(mockAppRepository, mockLanguageRepository),
      expect: () => const [AppLoaded(isFirstTimeOpenApp: false, languageCode: 'pt')],
    );

    blocTest<AppCubit, AppState>(
      'emits [AppLoaded] when firstTimeOpenFinished() is called (saves first time to false)',
      setUp: () {
        when(mockAppRepository.isFirstTime).thenAnswer((_) => Future.value(true));
        when(() => mockAppRepository.setFirstTime(false)).thenAnswer((_) => Future.value());
      },
      seed: () => const AppLoaded(isFirstTimeOpenApp: true, languageCode: 'en'),
      build: () => AppCubit(mockAppRepository, mockLanguageRepository),
      act: (cubit) => cubit.firstTimeOpenFinished(),
      expect: () {
        verify(() => mockAppRepository.setFirstTime(false)).called(1);
        return const [AppLoaded(isFirstTimeOpenApp: false, languageCode: 'en')];
      },
    );

    blocTest<AppCubit, AppState>(
      'emits [AppLoaded] when languageChanged() is called (saves to new languageCode)',
      setUp: () {
        when(mockAppRepository.isFirstTime).thenAnswer((_) => Future.value(false));
        when(mockLanguageRepository.getLanguage).thenAnswer((_) => Future.value('en'));
        when(() => mockLanguageRepository.updateLanguage('pt')).thenAnswer((_) => Future.value());
      },
      seed: () => const AppLoaded(isFirstTimeOpenApp: false, languageCode: 'en'),
      build: () => AppCubit(mockAppRepository, mockLanguageRepository),
      act: (cubit) async => cubit.languageChanged('pt'),
      expect: () {
        //verify(() => mockLanguageRepository.updateLanguage('pt')).called(1);
        return const [
          AppLoaded(isFirstTimeOpenApp: false, languageCode: 'pt'),
          AppLoaded(isFirstTimeOpenApp: false, languageCode: 'en'),
        ];
      },
    );
  });
}
