import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:kana_plus_plus/src/domain/entities/writing_hand.dart';
import 'package:kana_plus_plus/src/domain/usecases/training.controller.dart';

class TrainingStateManagement extends ChangeNotifier {
  TrainingStateManagement(this._controller);

  final TrainingController _controller;

  bool blockTouch = false;

  Future<bool> get isReady async => _controller.isReady;

  bool get isShowHint => _controller.showHint;

  int get maxQuantityOfWords => _controller.quantityOfWords;

  WritingHand get writingHand => _controller.getWritingHand;

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
