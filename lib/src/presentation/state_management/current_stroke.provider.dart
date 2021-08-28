import 'dart:ui';
import 'package:flutter/foundation.dart';
import 'package:kana_plus_plus/src/domain/usecases/writer.controller.dart';

class CurrentStrokeProvider extends ChangeNotifier {
  CurrentStrokeProvider(this._controller);

  final WriterController _controller;

  List<Offset> points = [];
  bool _canAdd = true;
  double _minCanvasLimit = 0.0;
  double _maxCanvasLimit = 0.0;

  void setCanvasLimit(double minCanvasLimit, double maxCanvasLimit) {
    _controller.setCanvasLimit(minCanvasLimit, maxCanvasLimit);
    _minCanvasLimit = minCanvasLimit;
    _maxCanvasLimit = maxCanvasLimit;
  }

  void addPoint(Offset point) {
    if (_minCanvasLimit < point.dx && point.dx < _maxCanvasLimit && _minCanvasLimit < point.dy && point.dy < _maxCanvasLimit && _canAdd) {
      points.add(point);
      notifyListeners();
    } else {
      _canAdd = false;
    }
  }

  void resetPoints() {
    points = [];
    _canAdd = true;
    notifyListeners();
  }
}
