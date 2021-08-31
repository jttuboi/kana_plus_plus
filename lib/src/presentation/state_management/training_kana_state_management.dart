import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:kana_plus_plus/src/domain/enums/update_kana_situation.dart';
import 'package:kana_plus_plus/src/domain/usecases/training.controller.dart';

class TrainingKanaProvider extends ChangeNotifier {
  TrainingKanaProvider(this._controller);

  final TrainingController _controller;

  UpdateKanaSituation updateKana(List<List<Offset>> strokes, String kanaIdWrote) {
    final situation = _controller.updateKana(strokes, kanaIdWrote);
    notifyListeners();
    return situation;
  }
}
