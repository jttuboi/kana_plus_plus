import "package:flutter/material.dart";
import 'package:flutter_gen/gen_l10n/j_strings.dart';
import 'package:flutter_localized_locales/flutter_localized_locales.dart';
import 'package:kana_plus_plus/src/domain/core/consts.dart';
import 'package:kana_plus_plus/src/presentation/arguments/words.arguments.dart';
import 'package:nested/nested.dart';
import 'package:provider/provider.dart';

import 'package:kana_plus_plus/src/data/datasources/cache.singleton.dart';
import 'package:kana_plus_plus/src/models/pre_training_arguments.dart';
import 'package:kana_plus_plus/src/models/training_arguments.dart';
import 'package:kana_plus_plus/src/presentation/pages/menu.page.android.dart';
import 'package:kana_plus_plus/src/presentation/pages/settings.page.android.dart';
import 'package:kana_plus_plus/src/presentation/pages/word.page.dart';
import 'package:kana_plus_plus/src/presentation/pages/words.page.dart';
import 'package:kana_plus_plus/src/presentation/providers/locale.provider.dart';
import 'package:kana_plus_plus/src/presentation/providers/theme.provider.dart';
import 'package:kana_plus_plus/src/presentation/routes.dart';
import 'package:kana_plus_plus/src/views/android/pages/kana.page.dart';
import 'package:kana_plus_plus/src/views/android/pages/pre_training.page.dart';
import 'package:kana_plus_plus/src/views/android/pages/review.page.dart';
import 'package:kana_plus_plus/src/views/android/pages/study.page.dart';
import 'package:kana_plus_plus/src/views/android/pages/training.page.dart';

class AndroidApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: _providers,
      child: Consumer<ThemeProvider>(builder: (context, value, child) {
        return Consumer<LocaleProvider>(builder: (context, value, child) {
          return MaterialApp(
            title: appTitle,
            // TODO remover antes de dar deploy
            debugShowCheckedModeBanner: false,
            localizationsDelegates: _localizationsDelegates,
            supportedLocales: _supportedLocales,
            locale: _locale(context),
            themeMode: _themeMode(context),
            theme: _theme,
            darkTheme: _darkTheme,
            routes: _routes,
            onGenerateRoute: _onGenerateRoute,
          );
        });
      }),
    );
  }

  List<SingleChildWidget> get _providers {
    return [
      ChangeNotifierProvider(create: (context) {
        return ThemeProvider(Cache.getBool("dark_theme"));
      }),
      ChangeNotifierProvider(create: (context) {
        return LocaleProvider();
      }),
    ];
  }

  List<LocalizationsDelegate<dynamic>> get _localizationsDelegates {
    return const [
      ...JStrings.localizationsDelegates,
      LocaleNamesLocalizationsDelegate()
    ];
  }

  List<Locale> get _supportedLocales => JStrings.supportedLocales;

  Locale _locale(BuildContext context) {
    return Provider.of<LocaleProvider>(context).locale;
  }

  ThemeMode _themeMode(BuildContext context) {
    return Provider.of<ThemeProvider>(context).mode;
  }

  ThemeData get _theme {
    return ThemeData(
      brightness: Brightness.light,
      primarySwatch: Colors.indigo,
    );
  }

  ThemeData get _darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      primarySwatch: Colors.indigo,
    );
  }

  Map<String, WidgetBuilder> get _routes {
    return {
      Routes.menu: (context) => const MenuPage(),
      Routes.study: (context) => const StudyPage(),
      Routes.kana: (context) => const KanaPage(),
      Routes.preTraining: (context) => const PreTrainingPage(),
      Routes.words: (context) => WordsPage(),
      Routes.settings: (context) => const SettingsPage(),
    };
  }

  Route<dynamic>? _onGenerateRoute(RouteSettings settings) {
    if (settings.name == Routes.training) {
      final args = settings.arguments! as PreTrainingArguments;
      return MaterialPageRoute(
        builder: (context) => TrainingPage(
          showHint: args.showHint,
          kanaType: args.kanaType,
          quantityOfWords: args.quantityOfWords,
        ),
      );
    } else if (settings.name == Routes.review) {
      final args = settings.arguments! as TrainingArguments;
      return MaterialPageRoute(
        builder: (context) => ReviewPage(
          wordsResult: args.wordsResult,
        ),
      );
    } else if (settings.name == Routes.word) {
      final args = settings.arguments! as WordsArguments;
      return MaterialPageRoute(
        builder: (context) => WordDetailPage(
          word: args.word,
        ),
      );
    }
  }
}
