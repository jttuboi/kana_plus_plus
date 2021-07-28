import "package:flutter/material.dart";
import 'package:flutter_gen/gen_l10n/j_strings.dart';
import 'package:flutter_localized_locales/flutter_localized_locales.dart';
import 'package:kana_plus_plus/src/models/training_arguments.dart';
import 'package:kana_plus_plus/src/data/datasources/cache.singleton.dart';
import 'package:kana_plus_plus/src/presentation/pages/word.page.dart';
import 'package:kana_plus_plus/src/presentation/pages/words.page.dart';
import 'package:kana_plus_plus/src/presentation/providers/locale.provider.dart';
import 'package:kana_plus_plus/src/presentation/providers/theme.provider.dart';
import 'package:kana_plus_plus/src/presentation/pages/menu.page.android.dart';
import 'package:kana_plus_plus/src/models/pre_training_arguments.dart';
import 'package:kana_plus_plus/src/presentation/routes.dart';
import 'package:kana_plus_plus/src/views/android/pages/kana.page.dart';
import 'package:kana_plus_plus/src/views/android/pages/pre_training.page.dart';
import 'package:kana_plus_plus/src/views/android/pages/review.page.dart';
import 'package:kana_plus_plus/src/presentation/pages/settings.page.android.dart';
import 'package:kana_plus_plus/src/views/android/pages/study.page.dart';
import 'package:kana_plus_plus/src/views/android/pages/training.page.dart';
import 'package:provider/provider.dart';

class AndroidApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) {
          return ThemeProvider(Cache.getBool("dark_theme"));
        }),
        ChangeNotifierProvider(create: (context) => LocaleProvider()),
      ],
      child: Consumer<ThemeProvider>(builder: (context, value, child) {
        return Consumer<LocaleProvider>(builder: (context, value, child) {
          return MaterialApp(
            title: "Kana++",
            debugShowCheckedModeBanner: false,
            // TODO remover antes de dar deploy
            localizationsDelegates: const [
              ...JStrings.localizationsDelegates,
              LocaleNamesLocalizationsDelegate()
            ],
            supportedLocales: JStrings.supportedLocales,
            locale: Provider.of<LocaleProvider>(context).locale,
            themeMode: Provider.of<ThemeProvider>(context).mode,
            theme: ThemeData(
              brightness: Brightness.light,
              primarySwatch: Colors.indigo,
            ),
            darkTheme: ThemeData(
              brightness: Brightness.dark,
              primarySwatch: Colors.indigo,
            ),
            routes: {
              Routes.menu: (context) => const MenuPage(),
              Routes.study: (context) => const StudyPage(),
              Routes.kana: (context) => const KanaPage(),
              Routes.preTraining: (context) => const PreTrainingPage(),
              //Routes.training: (context) => TrainingPage(),
              //Routes.review: (context) => const ReviewPage(),
              Routes.words: (context) => WordsPage(),
              Routes.word: (context) => const WordPage(),
              Routes.settings: (context) => const SettingsPage(),
            },
            onGenerateRoute: (settings) {
              if (settings.name == Routes.training) {
                // ignore: cast_nullable_to_non_nullable
                final args = settings.arguments as PreTrainingArguments;
                return MaterialPageRoute(
                  builder: (context) => TrainingPage(
                    showHint: args.showHint,
                    kanaType: args.kanaType,
                    quantityOfWords: args.quantityOfWords,
                  ),
                );
              } else if (settings.name == Routes.review) {
                // ignore: cast_nullable_to_non_nullable
                final args = settings.arguments as TrainingArguments;
                return MaterialPageRoute(
                  builder: (context) => ReviewPage(
                    wordsResult: args.wordsResult,
                  ),
                );
              }
            },
          );
        });
      }),
    );
  }
}
