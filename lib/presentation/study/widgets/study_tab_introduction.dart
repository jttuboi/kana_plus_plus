import 'package:flutter/material.dart';
import 'package:kwriting/domain/domain.dart';
import 'package:kwriting/presentation/study/study.dart';

class StudyTabIntroduction extends StatelessWidget {
  const StudyTabIntroduction({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final strings = JStrings.of(context)!;
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            StudyText(text: strings.studyIntroductionText),
            StudyTitle(title: strings.studyAlphabetTitle),
            StudyText(text: strings.studyAlphabetText),
          ],
        ),
      ),
    );
  }
}
