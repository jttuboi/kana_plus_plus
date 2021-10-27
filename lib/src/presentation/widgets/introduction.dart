import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/j_strings.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:kwriting/src/infrastructure/datasources/image_url.storage.dart';
import 'package:kwriting/src/presentation/utils/consts.dart';

class Introduction extends StatelessWidget {
  const Introduction({required this.onFinished, Key? key}) : super(key: key);

  final VoidCallback onFinished;

  @override
  Widget build(BuildContext context) {
    final strings = JStrings.of(context)!;
    return IntroductionScreen(
      isTopSafeArea: true,
      globalBackgroundColor: Theme.of(context).primaryColor,
      pages: [
        PageViewModel(
          title: strings.introTitleWriting,
          body: strings.introWriting,
          image: Center(child: SvgPicture.asset(ImageUrl.introWriting, width: introductionImageSize, height: introductionImageSize)),
          decoration: introductionPageDecoration,
        ),
        PageViewModel(
          title: strings.introTitleVocabulary,
          body: strings.introVocabulary,
          image: Center(child: SvgPicture.asset(ImageUrl.introVocabulary, width: introductionImageSize, height: introductionImageSize)),
          decoration: introductionPageDecoration,
        ),
        PageViewModel(
          title: strings.introTitleStudy,
          body: strings.introStudy,
          image: Center(child: SvgPicture.asset(ImageUrl.introStudy, width: introductionImageSize, height: introductionImageSize)),
          decoration: introductionPageDecoration,
        ),
        PageViewModel(
          title: strings.introTitleTraining,
          body: strings.introTraining,
          image: Center(child: SvgPicture.asset(ImageUrl.introTraining, width: introductionImageSize, height: introductionImageSize)),
          decoration: introductionPageDecoration,
        ),
        PageViewModel(
          title: strings.introTitleRecommendation,
          image: Center(child: SvgPicture.asset(ImageUrl.introRecommendation, width: introductionImageSize, height: introductionImageSize)),
          bodyWidget: Column(
            children: [
              Text(strings.introRecommendation, textAlign: TextAlign.center, style: introductionPageDecoration.bodyTextStyle),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: onFinished,
                style: introductionButtonStyle,
                child: Text(strings.introLetsStarted, style: introductionButtonTextStyle),
              )
            ],
          ),
          decoration: introductionPageDecoration,
        ),
      ],
      showDoneButton: false,
      showNextButton: false,
      curve: Curves.fastLinearToSlowEaseIn,
      dotsFlex: 3,
      dotsDecorator: introductionDotsDecorator,
    );
  }
}
