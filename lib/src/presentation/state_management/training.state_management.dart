import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:kana_plus_plus/src/domain/usecases/training.controller.dart';

class TrainingStateManagement extends ChangeNotifier {
  TrainingStateManagement(this._controller);

  final TrainingController _controller;

  bool blockTouch = false;

  Future<bool> get isReady async => _controller.isReady;

  int get maxQuantityOfWords => _controller.quantityOfWords;

  String get quitIconUrl => _controller.quitIconUrl;

  void unlockTouch() {
    blockTouch = false;
    notifyListeners();
  }

  void lockTouch() {
    blockTouch = true;
    notifyListeners();
  }
}
