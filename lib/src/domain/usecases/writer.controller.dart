import 'dart:collection';
import 'dart:ui';
import 'package:kana_plus_plus/src/data/datasources/icon_url.storage.dart';
import 'package:kana_plus_plus/src/data/datasources/image_url.storage.dart';
import 'package:kana_plus_plus/src/domain/entities/kana_type.dart';
import 'package:kana_plus_plus/src/domain/entities/writing_hand.dart';
import 'package:kana_plus_plus/src/domain/repositories/writing_hand.interface.dart';

class WriterController {
  WriterController({
    required this.writingHandRepository,
    required this.showHint,
  });

  static const limitPointsToReduce = 20;

  IWritingHandRepository writingHandRepository;

  bool showHint;
  String kanaHintImageUrl = ImageUrl.empty;

  List<List<Offset>> strokes = [];
  int maxStrokes = 0;

  KanaType kanaType = KanaType.none;

  WritingHand get writingHand => writingHandRepository.getWritingHandSelected();

  String get eraserIconUrl => IconUrl.eraser;

  String get undoIconUrl => IconUrl.undo;

  String get squareImageUrl => ImageUrl.square;

  bool get isTheLastStroke => strokes.length >= maxStrokes;

  List<List<Offset>> strokesNormalized(double startSquareLocation, double endSquareLocation) {
    final strokesNormalized = <List<Offset>>[];
    for (final stroke in strokes) {
      final strokeNormalized = <Offset>[];
      for (final point in stroke) {
        final pointNormalized = Offset(
          (point.dx - startSquareLocation) / (endSquareLocation - startSquareLocation),
          (point.dy - startSquareLocation) / (endSquareLocation - startSquareLocation),
        );
        strokeNormalized.add(pointNormalized);
      }
      strokesNormalized.add(strokeNormalized);
    }

    return strokesNormalized;
  }

  //TODO implementar o algoritmo de reconhecimento dos strokes
  int get generateKanaId => 0; // aqui deve procurar pelo kana (kanaType)

  void updateWriter(int newMaxStrokes, String newKanaImageUrl, KanaType newKanaType) {
    maxStrokes = newMaxStrokes;
    kanaHintImageUrl = newKanaImageUrl;
    kanaType = newKanaType;
    strokes = [];
  }

  void addStroke(List<Offset> path) {
    strokes.add(reducePath(path));
  }

  void clearStrokes() {
    strokes.clear();
  }

  void undoTheLastStroke() {
    if (strokes.isNotEmpty) {
      strokes.removeLast();
    }
  }

  List<Offset> reducePath(List<Offset> path) {
    if (path.length <= limitPointsToReduce) {
      return path;
    }

    // it's using ramer douglas peucker algorithm to reduce polyline
    // with different limitDistance
    List<Offset> newPath = reducerPolylineRamerDouglasPeuckerStack(path, 0.5);
    if (newPath.length > limitPointsToReduce) {
      newPath = reducerPolylineRamerDouglasPeuckerStack(path, 1.0);
    }
    if (newPath.length > limitPointsToReduce) {
      newPath = reducerPolylineRamerDouglasPeuckerStack(path, 2.0);
    }
    return newPath;
  }

  // https://gist.github.com/Snegovikufa/6490663
  List<Offset> reducerPolylineRamerDouglasPeuckerStack(List<Offset> points, double limitDistance) {
    final length = points.length;
    final markers = List.filled(length, false);

    int firstIndex = 0;
    int lastIndex = length - 1;
    int index = -1;

    final firstStack = Queue<int>();
    final lastStack = Queue<int>();
    final newPoints = <Offset>[];

    // marca posições do primeiro e último
    markers[firstIndex] = markers[lastIndex] = true;

    while (lastIndex != -1) {
      // procura pelo segmento que contém a máxima distancia perpendicular
      double maxDistance = 0;
      for (int i = firstIndex + 1; i < lastIndex; i++) {
        final squareSegmentDistance = getSquareSegmentDistance(points[i], points[firstIndex], points[lastIndex]);
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
    for (int i = 0; i < length; i++) {
      if (markers[i]) {
        newPoints.add(points[i]);
      }
    }
    return newPoints;
  }

  double getSquareSegmentDistance(Offset point, Offset firstPoint, Offset lastPoint) {
    double x = firstPoint.dx;
    double y = firstPoint.dy;

    double dx = lastPoint.dx - x;
    double dy = lastPoint.dy - y;

    if (dx != 0 || dy != 0) {
      final t = ((point.dx - x) * dx + (point.dy - y) * dy) / (dx * dx + dy * dy);

      if (t > 1) {
        x = lastPoint.dx;
        y = lastPoint.dy;
      } else if (t > 0) {
        x += dx * t;
        y += dy * t;
      }
    }

    dx = point.dx - x;
    dy = point.dy - y;

    return dx * dx + dy * dy;
  }
}
