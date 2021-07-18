import "package:flutter/material.dart";
import "package:kana_plus_plus/src/cards/card_page.dart";
import "package:kana_plus_plus/src/cards/cards_page.dart";
import "package:kana_plus_plus/src/menu_page.dart";
import "package:kana_plus_plus/src/settings/settings_page.dart";
import 'package:kana_plus_plus/src/shared/pre_training_arguments.dart';
import "package:kana_plus_plus/src/shared/routes.dart";
import "package:kana_plus_plus/src/study/kana_page.dart";
import "package:kana_plus_plus/src/study/study_page.dart";
import "package:kana_plus_plus/src/training/pre_training_page.dart";
import "package:kana_plus_plus/src/training/review_page.dart";
import "package:kana_plus_plus/src/training/training_page.dart";

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
        Routes.review: (context) => const ReviewPage(),
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
        }
      },
    );
  }
}
