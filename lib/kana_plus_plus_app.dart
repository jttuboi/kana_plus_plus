import 'package:flutter/material.dart';
import 'package:kana_plus_plus/cards/card_page.dart';
import 'package:kana_plus_plus/cards/cards_page.dart';
import 'package:kana_plus_plus/menu_page.dart';
import 'package:kana_plus_plus/settings/settings_page.dart';
import 'package:kana_plus_plus/shared/routes.dart';
import 'package:kana_plus_plus/study/kana_page.dart';
import 'package:kana_plus_plus/study/study_page.dart';
import 'package:kana_plus_plus/training/pre_training_page.dart';
import 'package:kana_plus_plus/training/review_page.dart';
import 'package:kana_plus_plus/training/training_page.dart';

class KanaPlusPlusApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Kana++",
      routes: {
        Routes.menu: (context) => MenuPage(),
        Routes.study: (context) => StudyPage(),
        Routes.kana: (context) => KanaPage(),
        Routes.preTraining: (context) => PreTrainingPage(),
        Routes.training: (context) => TrainingPage(),
        Routes.review: (context) => ReviewPage(),
        Routes.cards: (context) => CardsPage(),
        Routes.card: (context) => CardPage(),
        Routes.settings: (context) => SettingsPage(),
      },
    );
  }
}
