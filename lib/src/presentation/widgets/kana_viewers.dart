import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:kwriting/src/domain/controllers/training.controller.dart';
import 'package:kwriting/src/presentation/state_management/training_kana.provider.dart';
import 'package:kwriting/src/presentation/utils/consts.dart';
import 'package:kwriting/src/presentation/widgets/kana_viewer.dart';
import 'package:provider/provider.dart';

class KanaViewers extends StatelessWidget {
  KanaViewers({
    Key? key,
    required this.width,
    required this.height,
    required this.trainingController,
    required this.wordIdxToShow,
  }) : super(key: key);

  final double width;
  final double height;
  final TrainingController trainingController;
  final int wordIdxToShow;

  final _carouselController = CarouselController();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: Consumer<TrainingKanaProvider>(
        builder: (context, value, child) {
          if (_carouselController.ready && trainingController.kanaIdx != 0) {
            _carouselController.jumpToPage(trainingController.kanaIdx);
          }
          return CarouselSlider.builder(
            options: CarouselOptions(
              height: height,
              viewportFraction: kanaViewersViewpoertFraction,
              aspectRatio: 1.0,
              enableInfiniteScroll: false,
            ),
            carouselController: _carouselController,
            itemCount: trainingController.maxKanasOfWord(wordIdxToShow),
            itemBuilder: (context, index, realIndex) {
              return KanaViewer(trainingController.kanaOfWord(wordIdxToShow, index), size: height);
            },
          );
        },
      ),
    );
  }
}
