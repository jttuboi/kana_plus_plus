import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:kana_plus_plus/src/domain/entities/kana_type.dart';
import 'package:kana_plus_plus/src/domain/usecases/training.controller.dart';
import 'package:kana_plus_plus/src/presentation/arguments/kana_viewer_content.dart';

class TrainingKanaStateManagement extends ChangeNotifier {
  TrainingKanaStateManagement(this._controller);

  final TrainingController _controller;

  int get kanaIdx => _controller.kanaIdx;

  int get maxStrokes => _controller.currentKanaMaxStrokes;

  KanaType get kanaType => _controller.currentKanaType;

  int maxKanasOfWord(int currentWordIdx) =>
      _controller.getMaxKanasOfWord(currentWordIdx);

  KanaViewerContent kanaOfWord(int currentWordIdx, int currentKanaIdx) {
    return _controller.kanaOfWord(currentWordIdx, currentKanaIdx);
  }

  List<KanaViewerContent> getCurrentKanas(int wordIdx) =>
      _controller.wordsToTraining[wordIdx].kanas;

  void updateKana(List<Point<num>> pointsFiltered, int kanaIdWrote,
      Image imageStrokeDrew, VoidCallback updateWhenWordChanged) {
    _controller.updateKana(
        pointsFiltered, kanaIdWrote, imageStrokeDrew, updateWhenWordChanged);
    notifyListeners();
  }
}
