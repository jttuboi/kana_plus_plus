import 'package:flutter/material.dart';
import 'package:kwriting/core/core.dart';
import 'package:kwriting/features/menu/menu.dart';
import 'package:kwriting/features/settings/settings.dart';
import 'package:kwriting/features/study/study.dart';
import 'package:kwriting/features/training/training.dart';
import 'package:kwriting/features/words/words.dart';
import 'package:provider/provider.dart';

class AndroidApp extends StatelessWidget {
  AndroidApp({Key? key}) : super(key: key);

  final appController = AppController(appRepository: AppRepository(), languageRepository: LanguageRepository());

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => LocaleChangeNotifier(appController),
      child: Consumer<LocaleChangeNotifier>(builder: (context, localeChangeNotifier, child) {
        return MaterialApp(
          title: App.title,
          debugShowCheckedModeBanner: false,
          localizationsDelegates: JStrings.localizationsDelegates,
          supportedLocales: JStrings.supportedLocales,
          themeMode: ThemeMode.light,
          theme: themeData,
          locale: _locale(localeChangeNotifier),
          localeResolutionCallback: _localeResolutionCallback,
          home: MenuPage(appController),
          onGenerateRoute: _onGenerateRoute,
        );
      }),
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

  Locale? _locale(LocaleChangeNotifier changeNotifier) {
    return (appController.isFirstTime) ? null : changeNotifier.locale;
  }

  Locale? _localeResolutionCallback(Locale? locale, Iterable<Locale>? supportedLocales) {
    // locale is from device. it is the current device language used.
    // supportedLocales are the languages supported of this app.
    appController.setDeviceLocale(locale);
    return appController.locale;
  }

  Route? _onGenerateRoute(RouteSettings settings) {
    final args = (settings.arguments != null) ? settings.arguments! as Map<String, dynamic> : {};

    switch (settings.name) {
      case StudyPage.routeName:
        return StudyPage.route();
      case PreTrainingPage.routeName:
        return PreTrainingPage.route(args[PreTrainingPage.argPreTrainingController]);
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
        return SelectionOptionPage.route(
          title: args[SelectionOptionPage.argTitle],
          bannerUrl: args[SelectionOptionPage.argBannerUrl],
          selectedKey: args[SelectionOptionPage.argSelectedOptionKey],
          options: args[SelectionOptionPage.argOptions],
          onSelected: args[SelectionOptionPage.argOnSelected],
        );
    }
  }
}
