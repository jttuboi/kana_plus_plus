import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:kwriting/src/domain/utils/update_kana_situation.dart';
import 'package:kwriting/training/domain/use_cases/training.controller.dart' show TrainingController;

class TrainingKanaProvider extends ChangeNotifier {
  TrainingKanaProvider(this._controller);

  final TrainingController _controller;

  UpdateKanaSituation updateKana(List<List<Offset>> strokes, String kanaIdWrote) {
    final situation = _controller.updateKana(strokes, kanaIdWrote);
    notifyListeners();
    return situation;
  }
}
