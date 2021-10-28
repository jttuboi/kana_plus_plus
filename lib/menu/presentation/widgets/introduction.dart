import 'package:flutter/material.dart';
import 'package:flutter_device_type/flutter_device_type.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:kwriting/core/core.dart';

class Introduction extends StatelessWidget {
  Introduction({required this.onFinished, Key? key}) : super(key: key);

  final introductionImageSize = Device.get().isTablet ? Device.screenWidth * 1 / 2 : Device.screenWidth * 2 / 3;
  final introductionPageDecoration = PageDecoration(
    titleTextStyle: TextStyle(
      fontSize: Device.get().isTablet ? 40.0 : 28.0,
      fontWeight: FontWeight.bold,
      fontFamily: 'Permanent Marker',
      color: Colors.grey.shade200,
      letterSpacing: 2,
    ),
    bodyTextStyle: TextStyle(
      fontSize: Device.get().isTablet ? 32.0 : 20.0,
      fontWeight: FontWeight.bold,
      color: Colors.grey.shade200,
    ),
    descriptionPadding: const EdgeInsets.all(16).copyWith(bottom: 0),
    imagePadding: const EdgeInsets.all(24),
  );

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
                style: ButtonStyle(
                  padding: Device.get().isTablet ? MaterialStateProperty.all(const EdgeInsets.symmetric(vertical: 16, horizontal: 26)) : null,
                  backgroundColor: MaterialStateProperty.all(const Color.fromRGBO(58, 39, 89, 1)),
                ),
                child: Text(
                  strings.introLetsStarted,
                  style: TextStyle(
                    fontSize: Device.get().isTablet ? 29.0 : 17.0,
                    letterSpacing: 1,
                    fontWeight: FontWeight.bold,
                  ),
                ),
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
      dotsDecorator: DotsDecorator(
        size: const Size(10, 10),
        color: Colors.grey.shade400,
        activeSize: const Size(20, 10),
        activeColor: Colors.grey.shade200,
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
