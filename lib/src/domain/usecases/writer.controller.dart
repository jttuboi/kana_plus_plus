import 'dart:math';
import 'package:flutter/widgets.dart';
import 'package:kana_plus_plus/src/data/datasources/icon_url.storage.dart';
import 'package:kana_plus_plus/src/domain/entities/kana_type.dart';

class WriterController {
  int strokeNumber = 0;
  int maxStrokes = 0;
  KanaType currentKanaType = KanaType.none;

  String get eraserIconUrl => IconUrl.eraser;

  String get undoIconUrl => IconUrl.undo;

  void updateWriter(int maxStrokesNumber, KanaType kanaType) {
    strokeNumber = 0;
    maxStrokes = maxStrokesNumber;
    currentKanaType = kanaType;
  }

  void clearStrokes() {
    strokeNumber = 0;
  }

  void undoTheLastStroke() {
    strokeNumber--;
    if (strokeNumber < 0) {
      strokeNumber = 0;
    }
  }

  Map<String, dynamic> processStroke(List<Point> points) {
    // recalcula os pontos

    // only find kana when is the last stroke
    if (strokeNumber >= maxStrokes - 1) {
      // localiza o kana

      return {
        "pointsFiltered": points,
        "kanaId": 0, // A
      };
    }

    // next stroke
    strokeNumber++;
    return {
      "pointsFiltered": points,
    };
  }
}
