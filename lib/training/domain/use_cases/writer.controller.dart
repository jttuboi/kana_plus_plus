import 'dart:math';
import 'dart:ui';

import 'package:kana_checker/kana_checker.dart';
import 'package:kwriting/settings/domain/repositories/writing_hand.interface.repository.dart';
import 'package:kwriting/src/domain/utils/writing_hand.dart';
import 'package:kwriting/training/domain/entities/kana_to_writer.dart';
import 'package:stroke_reducer/stroke_reducer.dart';

class WriterController {
  WriterController({
    required this.writingHandRepository,
    required this.strokeReducer,
    required this.kanaChecker,
    required this.showHint,
  });

  final IWritingHandRepository writingHandRepository;
  final StrokeReducer strokeReducer;
  final KanaChecker kanaChecker;

  final bool showHint;

  List<List<Offset>> strokes = [];
  late KanaToWrite kanaToWrite;

  double _startCanvasLimit = 0;
  double _endCanvasLimit = 100;

  bool get isWritingHandRight => writingHandRepository.getWritingHandSelected().isRight;

  String get kanaHintImageUrl => kanaToWrite.hintImageUrl;

  bool get isTheLastStroke => strokes.length >= kanaToWrite.maxStrokes;

  void updateWriter(KanaToWrite pKanaToWrite) {
    strokes.clear();
    kanaToWrite = pKanaToWrite;
  }

  void setCanvasLimit(double minCanvasLimit, double maxCanvasLimit) {
    _startCanvasLimit = minCanvasLimit;
    _endCanvasLimit = maxCanvasLimit;
  }

  void addStroke(List<Offset> stroke) {
    if (stroke.length > 3) {
      // TODO evitar esse tipo de conversão, verificar se tem como evitar o Offset e utilizar o Point<double>
      strokes.add(strokeReducer
          .reduce(stroke.map((offset) => Point<double>(offset.dx, offset.dy)).toList())
          .map((point) => Offset(point.x, point.y))
          .toList());
    }
  }

  void clearStrokes() {
    strokes.clear();
  }

  void undoTheLastStroke() {
    if (strokes.isNotEmpty) {
      strokes.removeLast();
    }
  }

  String get kanaWrote {
    //print('kanaWrote -> kanaToWrite = $kanaToWrite');
    // TODO evitar esse tipo de conversão, verificar se tem como evitar o Offset e utilizar o Point<double>
    final isOk = kanaChecker.checkKana(
        kanaToWrite.id, normalizedStrokes.map((list) => list.map((offset) => Point<double>(offset.dx, offset.dy)).toList()).toList());
    return isOk ? kanaToWrite.id : '';
  }

  List<List<Offset>> get normalizedStrokes {
    final strokesNormalized = <List<Offset>>[];
    for (final stroke in strokes) {
      final strokeNormalized = <Offset>[];
      for (final point in stroke) {
        final pointNormalized = Offset(
          (point.dx - _startCanvasLimit) / (_endCanvasLimit - _startCanvasLimit),
          (point.dy - _startCanvasLimit) / (_endCanvasLimit - _startCanvasLimit),
        );
        strokeNormalized.add(pointNormalized);
      }
      strokesNormalized.add(strokeNormalized);
    }
    return strokesNormalized;
  }
}