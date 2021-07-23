import "package:flutter/material.dart";
import 'package:flutter_gen/gen_l10n/j_strings.dart';
import 'package:flutter_localized_locales/flutter_localized_locales.dart';
import 'package:kana_plus_plus/src/models/training_arguments.dart';
import 'package:kana_plus_plus/src/providers/locale_provider.dart';
import 'package:kana_plus_plus/src/views/android/pages/word.page.dart';
import 'package:kana_plus_plus/src/views/android/pages/words.page.dart';
import 'package:kana_plus_plus/src/views/android/pages/menu.page.dart';
import 'package:kana_plus_plus/src/models/pre_training_arguments.dart';
import "package:kana_plus_plus/src/shared/routes.dart";
import 'package:kana_plus_plus/src/views/android/pages/kana.page.dart';
import 'package:kana_plus_plus/src/views/android/pages/pre_training.page.dart';
import 'package:kana_plus_plus/src/views/android/pages/review.page.dart';
import 'package:kana_plus_plus/src/views/android/pages/settings.page.dart';
import 'package:kana_plus_plus/src/views/android/pages/study.page.dart';
import 'package:kana_plus_plus/src/views/android/pages/training.page.dart';
import 'package:provider/provider.dart';

class AndroidApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => LocaleProvider(),
      builder: (context, child) {
        final localeProvider = Provider.of<LocaleProvider>(context);
        return MaterialApp(
          title: "Kana++",
          debugShowCheckedModeBanner: false, // TODO remover antes de dar deploy
          localizationsDelegates: const [
            ...JStrings.localizationsDelegates,
            LocaleNamesLocalizationsDelegate()
          ],
          supportedLocales: JStrings.supportedLocales,
          locale: localeProvider.locale,
          routes: {
            Routes.menu: (context) => const MenuPage(),
            Routes.study: (context) => const StudyPage(),
            Routes.kana: (context) => const KanaPage(),
            Routes.preTraining: (context) => const PreTrainingPage(),
            //Routes.training: (context) => TrainingPage(),
            //Routes.review: (context) => const ReviewPage(),
            Routes.words: (context) => const WordsPage(),
            Routes.word: (context) => const WordPage(),
            Routes.settings: (context) => const HomePageSupport(),
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
      },
    );
  }
}
