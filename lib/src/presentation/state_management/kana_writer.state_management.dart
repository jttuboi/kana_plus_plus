import 'dart:ui';
import 'package:flutter/foundation.dart';
import 'package:kana_plus_plus/src/domain/entities/kana_type.dart';
import 'package:kana_plus_plus/src/domain/entities/writing_hand.dart';
import 'package:kana_plus_plus/src/domain/usecases/writer.controller.dart';

class WriterStateManagement extends ChangeNotifier {
  WriterStateManagement(this._controller);

  final WriterController _controller;

  bool isDisabled = false;

  bool get isWritingHandRight => _controller.writingHand.isRight;

  bool get isShowHint => _controller.showHint;

  String get eraserIconUrl => _controller.eraserIconUrl;

  String get undoIconUrl => _controller.undoIconUrl;

  String get squareImageUrl => _controller.squareImageUrl;

  String get kanaHintImageUrl => _controller.kanaHintImageUrl;

  bool get isTheLastStroke => _controller.isTheLastStroke;

  List<List<Offset>> get strokes => _controller.strokes;

  int get generateKanaId => _controller.generateKanaId;

  List<List<Offset>> strokesNormalized(double startSquareLocation, double endSquareLocation) {
    return _controller.strokesNormalized(startSquareLocation, endSquareLocation);
  }

  void updateWriter(int maxStrokes, String kanaHintImageUrl, KanaType kanaType) {
    _controller.updateWriter(maxStrokes, kanaHintImageUrl, kanaType);
    notifyListeners();
  }

  void enable() {
    isDisabled = false;
    notifyListeners();
  }

  void disable() {
    isDisabled = true;
    notifyListeners();
  }
}
