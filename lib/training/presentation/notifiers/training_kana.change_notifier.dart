import 'package:flutter/widgets.dart';
import 'package:kwriting/training/training.dart';

class TrainingKanaChangeNotifier extends ChangeNotifier {
  TrainingKanaChangeNotifier(this._controller);

  final TrainingController _controller;

  UpdateKanaSituation updateKana(List<List<Offset>> strokes, String kanaIdWrote) {
    final situation = _controller.updateKana(strokes, kanaIdWrote);
    notifyListeners();
    return situation;
  }
}
