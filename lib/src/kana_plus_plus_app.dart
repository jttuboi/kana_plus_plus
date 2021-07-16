import "package:flutter/material.dart";
import "package:kana_plus_plus/src/cards/card_page.dart";
import "package:kana_plus_plus/src/cards/cards_page.dart";
import "package:kana_plus_plus/src/menu_page.dart";
import "package:kana_plus_plus/src/settings/settings_page.dart";
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
        Routes.training: (context) => TrainingPage(),
        Routes.review: (context) => const ReviewPage(),
        Routes.cards: (context) => const CardsPage(),
        Routes.card: (context) => const CardPage(),
        Routes.settings: (context) => const SettingsPage(),
      },
    );
  }
}
