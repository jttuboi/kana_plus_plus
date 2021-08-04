import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:kana_plus_plus/src/domain/entities/kana_type.dart';
import 'package:kana_plus_plus/src/domain/usecases/writer.controller.dart';

class KanaWriterStateManagement extends ChangeNotifier {
  KanaWriterStateManagement(this._controller);

  final WriterController _controller;

  bool isDisabled = false;

  int get maxStrokes => _controller.maxStrokes;

  String get eraserIconUrl => _controller.eraserIconUrl;

  String get undoIconUrl => _controller.undoIconUrl;

  int get strokeNumber => _controller.strokeNumber;

  void updateWriter(int maxStrokesNumber, KanaType kanaType) {
    _controller.updateWriter(maxStrokesNumber, kanaType);
    notifyListeners();
  }

  void clearStrokes() {
    _controller.clearStrokes();
    notifyListeners();
  }

  void undoTheLastStroke() {
    _controller.undoTheLastStroke();
    notifyListeners();
  }

  Map<String, dynamic> processStroke(List<Point<num>> points) {
    final Map<String, dynamic> result = _controller.processStroke(points);
    notifyListeners();
    return result;
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
