import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:kwriting/training/training.dart';

class AllStrokesChangeNotifier extends ChangeNotifier {
  AllStrokesChangeNotifier(this._controller);

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
