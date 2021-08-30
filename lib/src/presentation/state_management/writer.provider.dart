import 'dart:ui';
import 'package:flutter/foundation.dart';
import 'package:kana_plus_plus/src/domain/entities/kana_to_writer.dart';
import 'package:kana_plus_plus/src/domain/enums/writing_hand.dart';
import 'package:kana_plus_plus/src/domain/usecases/writer.controller.dart';

class WriterProvider extends ChangeNotifier {
  WriterProvider(this._controller);

  final WriterController _controller;

  bool isDisabled = false;

  bool get isWritingHandRight => _controller.writingHand.isRight;

  bool get isShowHint => _controller.showHint;

  String get kanaHintImageUrl => _controller.kanaToWrite.hintImageUrl;

  bool get isTheLastStroke => _controller.isTheLastStroke;

  List<List<Offset>> get strokes => _controller.strokes;

  String get kanaWrote => _controller.getKanaId();

  List<List<Offset>> get normalizedStrokes => _controller.normalizedStrokes();

  void updateWriter(KanaToWrite kanaToWrite) {
    _controller.updateWriter(kanaToWrite);
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
