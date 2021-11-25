// ignore_for_file: avoid_redundant_argument_values

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:kwriting/core/core.dart';
import 'package:kwriting/domain/domain.dart';
import 'package:kwriting/features/settings/settings.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit(this.appRepository, this.languageRepository) : super(AppLoadInProgress()) {
    appRepository.isFirstTime().then((isFirstTime) {
      if (isFirstTime) {
        emit(AppLoaded(isFirstTimeOpenApp: isFirstTime));
      } else {
        _getLanguage(NoParams()).then((languageCode) {
          emit(AppLoaded(isFirstTimeOpenApp: isFirstTime, languageCode: languageCode));
        });
      }
    });
  }

  final IAppRepository appRepository;
  final ILanguageRepository languageRepository;
  late final GetLanguage _getLanguage;
  late final UpdateLanguage _updateLanguage;

  Future<void> firstTimeOpenFinished() async {
    if (state is AppLoaded) {
      await appRepository.setFirstTime(false);
      ;
      emit(AppLoaded(isFirstTimeOpenApp: false, languageCode: (state as AppLoaded).languageCode));
    }
  }

  Future<void> languageChanged(String languageCode) async {
    if (state is AppLoaded) {
      await _updateLanguage(LanguageParams(languageCode));
      emit(AppLoaded(isFirstTimeOpenApp: (state as AppLoaded).isFirstTimeOpenApp, languageCode: languageCode));
    }
  }
}
