import "package:flutter/material.dart";
import 'package:kana_plus_plus/src/models/training_arguments.dart';
import 'package:kana_plus_plus/src/views/android/word.page.dart';
import 'package:kana_plus_plus/src/views/android/words.page.dart';
import 'package:kana_plus_plus/src/views/android/menu.page.dart';
import 'package:kana_plus_plus/src/models/pre_training_arguments.dart';
import "package:kana_plus_plus/src/shared/routes.dart";
import 'package:kana_plus_plus/src/views/android/kana.page.dart';
import 'package:kana_plus_plus/src/views/android/pre_training.page.dart';
import 'package:kana_plus_plus/src/views/android/review.page.dart';
import 'package:kana_plus_plus/src/views/android/settings.page.dart';
import 'package:kana_plus_plus/src/views/android/study.page.dart';
import 'package:kana_plus_plus/src/views/android/training.page.dart';

class AndroidApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Kana++",
      debugShowCheckedModeBanner: false, // TODO remover antes de dar deploy
      routes: {
        Routes.menu: (context) => const MenuPage(),
        Routes.study: (context) => const StudyPage(),
        Routes.kana: (context) => const KanaPage(),
        Routes.preTraining: (context) => const PreTrainingPage(),
        //Routes.training: (context) => TrainingPage(),
        //Routes.review: (context) => const ReviewPage(),
        Routes.words: (context) => const WordsPage(),
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
  }
}
