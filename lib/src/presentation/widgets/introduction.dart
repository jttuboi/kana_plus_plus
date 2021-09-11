import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/j_strings.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:kana_plus_plus/src/data/datasources/image_url.storage.dart';
import 'package:kana_plus_plus/src/presentation/utils/consts.dart';

class Introduction extends StatelessWidget {
  const Introduction({Key? key, required this.onFinished}) : super(key: key);

  final VoidCallback onFinished;

  @override
  Widget build(BuildContext context) {
    final strings = JStrings.of(context)!;
    final imageSize = MediaQuery.of(context).size.width * 2 / 3;
    return IntroductionScreen(
      isTopSafeArea: true,
      globalBackgroundColor: Theme.of(context).primaryColor,
      pages: [
        PageViewModel(
          title: strings.introTitleWriting,
          body: strings.introWriting,
          image: Center(child: SvgPicture.asset(ImageUrl.introWriting, width: imageSize, height: imageSize)),
          decoration: introductionPageDecoration,
        ),
        PageViewModel(
          title: strings.introTitleVocabulary,
          body: strings.introVocabulary,
          image: Center(child: SvgPicture.asset(ImageUrl.introVocabulary, width: imageSize, height: imageSize)),
          decoration: introductionPageDecoration,
        ),
        PageViewModel(
          title: strings.introTitleStudy,
          body: strings.introStudy,
          image: Center(child: SvgPicture.asset(ImageUrl.introStudy, width: imageSize, height: imageSize)),
          decoration: introductionPageDecoration,
        ),
        PageViewModel(
          title: strings.introTitleTraining,
          body: strings.introTraining,
          image: Center(child: SvgPicture.asset(ImageUrl.introTraining, width: imageSize, height: imageSize)),
          decoration: introductionPageDecoration,
        ),
        PageViewModel(
          title: strings.introTitleRecommendation,
          image: Center(child: SvgPicture.asset(ImageUrl.introRecommendation, width: imageSize, height: imageSize)),
          bodyWidget: Column(
            children: [
              Text(strings.introRecommendation, textAlign: TextAlign.center, style: introductionPageDecoration.bodyTextStyle),
              const SizedBox(height: 16.0),
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

final introductionDotsDecorator = DotsDecorator(
  size: const Size(10, 10),
  color: Colors.grey.shade400,
  activeSize: const Size(20, 10),
  activeColor: Colors.grey.shade200,
  activeShape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(10.0),
  ),
);

final introductionPageDecoration = PageDecoration(
  titleTextStyle: TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.bold,
    fontFamily: defaultTitleFontFamily,
    color: Colors.grey.shade200,
    letterSpacing: 2.0,
  ),
  bodyTextStyle: TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: Colors.grey.shade200,
  ),
  descriptionPadding: const EdgeInsets.all(16.0).copyWith(bottom: 0.0),
  imagePadding: const EdgeInsets.all(24),
);

const introductionButtonTextStyle = TextStyle(fontSize: 17.0, letterSpacing: 1.0, fontWeight: FontWeight.bold);
final introductionButtonStyle = ButtonStyle(backgroundColor: MaterialStateProperty.all(darkPurple));
