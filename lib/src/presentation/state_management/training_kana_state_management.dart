import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:kana_plus_plus/src/domain/entities/kana_type.dart';
import 'package:kana_plus_plus/src/domain/entities/update_kana_situation.dart';
import 'package:kana_plus_plus/src/domain/usecases/training.controller.dart';
import 'package:kana_plus_plus/src/presentation/arguments/kana_viewer_content.dart';

class TrainingKanaStateManagement extends ChangeNotifier {
  TrainingKanaStateManagement(this._controller);

  final TrainingController _controller;

  int get kanaIdx => _controller.kanaIdx;

  int get currentKanaMaxStrokes => _controller.currentKanaMaxStrokes;

  String get currentKanaImageUrl => _controller.currentKanaImageUrl;

  KanaType get currentKanaType => _controller.currentKanaType;

  String get squareImageUrl => _controller.squareImageUrl;

  String get correctImageUrl => _controller.correctImageUrl;

  String get wrongImageUrl => _controller.wrongImageUrl;

  int maxKanasOfWord(int currentWordIdx) => _controller.getMaxKanasOfWord(currentWordIdx);

  KanaViewerContent kanaOfWord(int currentWordIdx, int currentKanaIdx) => _controller.kanaOfWord(currentWordIdx, currentKanaIdx);

  UpdateKanaSituation updateKana(List<List<Offset>> strokes, int kanaIdWrote) {
    final situation = _controller.updateKana(strokes, kanaIdWrote);
    notifyListeners();
    return situation;
  }
}
