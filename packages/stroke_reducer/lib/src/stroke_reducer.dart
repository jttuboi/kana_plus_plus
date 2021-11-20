import 'dart:collection';
import 'dart:math';

class StrokeReducer {
  StrokeReducer({required int maxPointsQuantity}) : _maxPointsQuantity = maxPointsQuantity;

  final int _maxPointsQuantity;

  List<Point<double>> reduce(List<Point<double>> stroke) {
    if (stroke.length <= _maxPointsQuantity) {
      return stroke;
    }

    // it's using ramer douglas peucker algorithm to reduce polyline with different limitDistance
    var newStroke = _reducerPolylineRamerDouglasPeuckerStack(stroke, 0.5);
    if (newStroke.length > _maxPointsQuantity) {
      newStroke = _reducerPolylineRamerDouglasPeuckerStack(stroke, 1);
    }
    if (newStroke.length > _maxPointsQuantity) {
      newStroke = _reducerPolylineRamerDouglasPeuckerStack(stroke, 2);
    }
    return newStroke;
  }

  // https://gist.github.com/Snegovikufa/6490663
  List<Point<double>> _reducerPolylineRamerDouglasPeuckerStack(List<Point<double>> points, double limitDistance) {
    final length = points.length;
    final markers = List.filled(length, false);

    var firstIndex = 0;
    var lastIndex = length - 1;
    var index = -1;

    final firstStack = Queue<int>();
    final lastStack = Queue<int>();
    final newPoints = <Point<double>>[];

    // marca posições do primeiro e último
    markers[firstIndex] = markers[lastIndex] = true;

    while (lastIndex != -1) {
      // procura pelo segmento que contém a máxima distancia perpendicular
      var maxDistance = 0.0;
      for (var i = firstIndex + 1; i < lastIndex; i++) {
        final squareSegmentDistance = _getSquareSegmentDistance(points[i], points[firstIndex], points[lastIndex]);
        if (squareSegmentDistance > maxDistance) {
          index = i;
          maxDistance = squareSegmentDistance;
        }
      }

      // se o segmento passar da distancia limite
      if (maxDistance > limitDistance) {
        // marca esse segmento
        markers[index] = true;

        // divide em 2 partes, colocando-os no stack
        firstStack.add(firstIndex);
        lastStack.add(index);

        firstStack.add(index);
        lastStack.add(lastIndex);
      }

      // atualiza os indexs e caso não aja mais index, finaliza-os
      firstIndex = firstStack.isNotEmpty ? firstStack.removeLast() : -1;
      lastIndex = lastStack.isNotEmpty ? lastStack.removeLast() : -1;
    }

    // se não foi marcado, o ponto que permanecerá na lista final intocado
    for (var i = 0; i < length; i++) {
      if (markers[i]) {
        newPoints.add(points[i]);
      }
    }
    return newPoints;
  }

  double _getSquareSegmentDistance(Point<double> point, Point<double> firstPoint, Point<double> lastPoint) {
    var x = firstPoint.x;
    var y = firstPoint.y;

    var dx = lastPoint.x - x;
    var dy = lastPoint.y - y;

    if (dx != 0 || dy != 0) {
      final t = ((point.x - x) * dx + (point.y - y) * dy) / (dx * dx + dy * dy);

      if (t > 1) {
        x = lastPoint.x;
        y = lastPoint.y;
      } else if (t > 0) {
        x += dx * t;
        y += dy * t;
      }
    }

    dx = point.x - x;
    dy = point.y - y;

    return dx * dx + dy * dy;
  }
}
