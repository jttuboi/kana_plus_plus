part of 'app_cubit.dart';

abstract class AppState extends Equatable {
  const AppState();

  @override
  List<Object> get props => [];
}

class AppLoaded extends AppState {
  const AppLoaded({this.isFirstTimeOpenApp = false, this.languageCode = 'en'});

  final bool isFirstTimeOpenApp;
  final String languageCode;

  @override
  List<Object> get props => [isFirstTimeOpenApp, languageCode];

  AppLoaded copyWith({
    bool? isFirstTimeOpenApp,
    String? languageCode,
  }) {
    return AppLoaded(
      isFirstTimeOpenApp: isFirstTimeOpenApp ?? this.isFirstTimeOpenApp,
      languageCode: languageCode ?? this.languageCode,
    );
  }
}

class AppLoadInProgress extends AppState {}
