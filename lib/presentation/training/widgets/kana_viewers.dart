import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_device_type/flutter_device_type.dart';
import 'package:kwriting/presentation/training/training.dart';
import 'package:provider/provider.dart';

class KanaViewers extends StatelessWidget {
  KanaViewers({
    required this.width,
    required this.height,
    required this.trainingController,
    required this.wordIdxToShow,
    Key? key,
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
      child: Consumer<TrainingKanaChangeNotifier>(
        builder: (context, value, child) {
          if (_carouselController.ready && trainingController.kanaIdx != 0) {
            _carouselController.jumpToPage(trainingController.kanaIdx);
          }
          return CarouselSlider.builder(
            options: CarouselOptions(
              height: height,
              viewportFraction: Device.get().isTablet ? 0.2 : 0.255,
              aspectRatio: 1,
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
