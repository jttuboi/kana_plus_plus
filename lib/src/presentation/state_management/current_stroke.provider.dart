import 'dart:ui';
import 'package:flutter/foundation.dart';

class CurrentStrokeProvider extends ChangeNotifier {
  List<Offset> points = [];
  bool _canAdd = true;
  double _minX = 0.0;
  double _minY = 0.0;
  double _maxX = 0.0;
  double _maxY = 0.0;

  void setLimit(double minX, double minY, double maxX, double maxY) {
    _minX = minX;
    _minY = minY;
    _maxX = maxX;
    _maxY = maxY;
  }

  void addPoint(Offset point) {
    if (_minX < point.dx && point.dx < _maxX && _minY < point.dy && point.dy < _maxY && _canAdd) {
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
