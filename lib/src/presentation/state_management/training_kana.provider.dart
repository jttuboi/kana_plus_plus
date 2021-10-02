import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:kana_plus_plus/src/domain/controllers/training.controller.dart';
import 'package:kana_plus_plus/src/domain/utils/update_kana_situation.dart';

class TrainingKanaProvider extends ChangeNotifier {
  TrainingKanaProvider(this._controller);

  final TrainingController _controller;

  UpdateKanaSituation updateKana(List<List<Offset>> strokes, String kanaIdWrote) {
    final situation = _controller.updateKana(strokes, kanaIdWrote);
    notifyListeners();
    return situation;
  }
}
