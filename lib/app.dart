import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kwriting/core/core.dart';
import 'package:kwriting/features/menu/menu.dart';
import 'package:kwriting/features/menu/presentation/cubit/app_cubit.dart';
import 'package:kwriting/features/settings/settings.dart';
import 'package:kwriting/features/study/study.dart';
import 'package:kwriting/features/training/training.dart';
import 'package:kwriting/features/words/words.dart';

class AndroidApp extends StatelessWidget {
  const AndroidApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AppCubit(AppRepository(), LanguageRepository())),
      ],
      child: const AppView(),
    );
  }
}

class AppView extends StatelessWidget {
  const AppView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
        return MaterialApp(
          title: App.title,
          debugShowCheckedModeBanner: false,
          localizationsDelegates: JStrings.localizationsDelegates,
          supportedLocales: JStrings.supportedLocales,
          themeMode: ThemeMode.light,
          theme: themeData,
          locale: _locale(state),
          localeResolutionCallback: (locale, supportedLocales) => _localeResolutionCallback(locale, supportedLocales, context),
          home: const MenuPage(),
          onGenerateRoute: _onGenerateRoute,
        );
      },
    );
  }

  ThemeData get themeData => ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.deepPurple,
        appBarTheme: const AppBarTheme(backgroundColor: Colors.transparent, shadowColor: Colors.transparent, elevation: 0),
        primaryIconTheme: IconThemeData(color: Colors.grey.shade500, size: 24),
        scaffoldBackgroundColor: Colors.grey.shade50,
        fontFamily: 'PT Sans',
      );

  Locale? _locale(AppState state) {
    if (state is! AppLoaded) {
      return null;
    }
    return (state.isFirstTimeOpenApp) ? null : Locale(state.languageCode);
  }

  // locale is from device. it is the current device language used.
  // supportedLocales are the languages supported of this app.
  Locale? _localeResolutionCallback(Locale? deviceLocale, Iterable<Locale>? supportedLocales, BuildContext context) {
    if (deviceLocale != null) {
      for (final locale in JStrings.supportedLocales) {
        if (locale.languageCode == deviceLocale.languageCode) {
          context.read<AppCubit>().languageChanged(deviceLocale.languageCode);
          return deviceLocale;
        }
      }
    }
    // it doesn't need to set database because default is the same
    return const Locale(Default.locale);
  }

  Route? _onGenerateRoute(RouteSettings settings) {
    final args = (settings.arguments != null) ? settings.arguments! as Map<String, dynamic> : {};

    switch (settings.name) {
      case StudyPage.routeName:
        return StudyPage.route();
      case PreTrainingPage.routeName:
        return PreTrainingPage.route();
      case TrainingPage.routeName:
        return TrainingPage.route(args[TrainingPage.argTrainingController], args[TrainingPage.argWriterController]);
      case ReviewPage.routeName:
        return ReviewPage.route(args[ReviewPage.argReviewController], wordsResult: args[ReviewPage.argWordsResult]);
      case WordsPage.routeName:
        return WordsPage.route(args[WordsPage.argWordsController]);
      case WordDetailPage.routeName:
        return WordDetailPage.route(word: args[WordDetailPage.argWord]);
      case SettingsPage.routeName:
        return SettingsPage.route();
      case AboutPage.routeName:
        return AboutPage.route();
      case SelectionOptionPage.routeName:
        return SelectionOptionPage.route(args[SelectionOptionPage.argSelectionOptionArgs]);
    }
  }
}
