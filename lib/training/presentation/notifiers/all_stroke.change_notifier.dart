import 'dart:ui';
import 'package:flutter/foundation.dart';
import 'package:kwriting/training/domain/use_cases/writer.controller.dart';

class AllStrokesProvider extends ChangeNotifier {
  AllStrokesProvider(this._controller);

  final WriterController _controller;

  List<List<Offset>> get strokes => _controller.strokes;

  void addStroke(List<Offset> stroke) {
    _controller.addStroke(stroke);
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
}
