import 'package:flutter/material.dart';
import 'package:kwriting/domain/domain.dart';
import 'package:kwriting/presentation/shared/shared.dart';
import 'package:kwriting/presentation/study/study.dart';

class StudyPage extends StatelessWidget {
  const StudyPage._({Key? key}) : super(key: key);

  static const routeName = '/study';

  static Route route() {
    return MaterialPageRoute(builder: (context) => const StudyPage._());
  }

  @override
  Widget build(BuildContext context) {
    final strings = JStrings.of(context)!;
    return FlexibleScaffold(
      title: strings.studyTitle,
      bannerUrl: BannerUrl.study,
      onBackButtonPressed: () => Navigator.popUntil(context, (route) => route.isFirst),
      tabs: [
        Tab(text: strings.studyIntroductionTitle),
        Tab(text: strings.studyHiraganaTitle),
        Tab(text: strings.studyKatakanaTitle),
      ],
      sliverContent: const TabBarView(
        children: [
          StudyTabIntroduction(),
          StudyTabHiragana(),
          StudyTabKatakana(),
        ],
      ),
    );
  }
}
