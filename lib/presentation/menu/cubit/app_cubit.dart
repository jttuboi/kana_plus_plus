// ignore_for_file: avoid_redundant_argument_values

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:kwriting/domain/domain.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit(this.appRepository, this.languageRepository) : super(AppLoadInProgress()) {
    appRepository.isFirstTime().then((isFirstTime) {
      if (isFirstTime) {
        emit(AppLoaded(isFirstTimeOpenApp: isFirstTime));
      } else {
        languageRepository.getLanguage().then((languageCode) {
          emit(AppLoaded(isFirstTimeOpenApp: isFirstTime, languageCode: languageCode));
        });
      }
    });
  }

  final IAppRepository appRepository;
  final ILanguageRepository languageRepository;

  Future<void> firstTimeOpenFinished() async {
    if (state is AppLoaded) {
      await appRepository.setFirstTime(false);
      emit(AppLoaded(isFirstTimeOpenApp: false, languageCode: (state as AppLoaded).languageCode));
    }
  }

  Future<void> languageChanged(String languageCode) async {
    if (state is AppLoaded) {
      await languageRepository.updateLanguage(languageCode);
      emit(AppLoaded(isFirstTimeOpenApp: (state as AppLoaded).isFirstTimeOpenApp, languageCode: languageCode));
    }
  }
}
