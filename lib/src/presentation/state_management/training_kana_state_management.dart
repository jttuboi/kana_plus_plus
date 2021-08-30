import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:kana_plus_plus/src/domain/entities/kana_to_writer.dart';
import 'package:kana_plus_plus/src/domain/enums/update_kana_situation.dart';
import 'package:kana_plus_plus/src/domain/usecases/training.controller.dart';
import 'package:kana_plus_plus/src/presentation/arguments/kana_viewer_content.dart';

class TrainingKanaStateManagement extends ChangeNotifier {
  TrainingKanaStateManagement(this._controller);

  final TrainingController _controller;

  int get kanaIdx => _controller.kanaIdx;

  KanaToWrite get currentKanaToWrite => _controller.currentKanaToWrite;

  int maxKanasOfWord(int currentWordIdx) {
    return _controller.getMaxKanasOfWord(currentWordIdx);
  }

  KanaViewerContent kanaOfWord(int currentWordIdx, int currentKanaIdx) {
    return _controller.kanaOfWord(currentWordIdx, currentKanaIdx);
  }

  UpdateKanaSituation updateKana(List<List<Offset>> strokes, String kanaIdWrote) {
    final situation = _controller.updateKana(strokes, kanaIdWrote);
    notifyListeners();
    return situation;
  }
}
