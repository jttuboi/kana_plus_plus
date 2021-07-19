import "package:flutter/material.dart";
import 'package:kana_plus_plus/src/models/training_arguments.dart';
import 'package:kana_plus_plus/src/views/card_page.dart';
import 'package:kana_plus_plus/src/views/cards_page.dart';
import 'package:kana_plus_plus/src/views/menu_page.dart';
import 'package:kana_plus_plus/src/models/pre_training_arguments.dart';
import "package:kana_plus_plus/src/shared/routes.dart";
import 'package:kana_plus_plus/src/views/kana_page.dart';
import 'package:kana_plus_plus/src/views/pre_training_page.dart';
import 'package:kana_plus_plus/src/views/review_page.dart';
import 'package:kana_plus_plus/src/views/settings_page.dart';
import 'package:kana_plus_plus/src/views/study_page.dart';
import 'package:kana_plus_plus/src/views/training_page.dart';

class KanaPlusPlusApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Kana++",
      routes: {
        Routes.menu: (context) => const MenuPage(),
        Routes.study: (context) => const StudyPage(),
        Routes.kana: (context) => const KanaPage(),
        Routes.preTraining: (context) => const PreTrainingPage(),
        //Routes.training: (context) => TrainingPage(),
        //Routes.review: (context) => const ReviewPage(),
        Routes.cards: (context) => const CardsPage(),
        Routes.card: (context) => const CardPage(),
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
              quantityOfCards: args.quantityOfCards,
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
