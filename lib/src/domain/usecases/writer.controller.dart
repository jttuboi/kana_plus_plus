import 'dart:ui';

import 'package:kana_plus_plus/src/data/datasources/icon_url.storage.dart';
import 'package:kana_plus_plus/src/data/datasources/image_url.storage.dart';
import 'package:kana_plus_plus/src/data/services/kana_checker.service.dart';
import 'package:kana_plus_plus/src/data/services/stroke_reducer.service.dart';
import 'package:kana_plus_plus/src/domain/entities/kana_to_writer.dart';
import 'package:kana_plus_plus/src/domain/entities/writing_hand.dart';
import 'package:kana_plus_plus/src/domain/repositories/writing_hand.interface.dart';
import 'package:kana_plus_plus/src/domain/services/kana_checker.interface.service.dart';
import 'package:kana_plus_plus/src/domain/services/stroke_reducer.interface.service.dart';

class WriterController {
  WriterController({
    required this.writingHandRepository,
    required this.showHint,
  }) {
    strokeReducerService = StrokeReducerService(limitPointsToReduce: 20);
    kanaCheckerService = KanaCheckerService();
  }

  IWritingHandRepository writingHandRepository;

  late final IStrokeReducerService strokeReducerService;
  late final IKanaCheckerService kanaCheckerService;

  bool showHint;

  List<List<Offset>> strokes = [];
  late KanaToWrite kanaToWrite;

  double _startCanvasLimit = 0.0;
  double _endCanvasLimit = 100.0;

  WritingHand get writingHand => writingHandRepository.getWritingHandSelected();

  String get eraserIconUrl => IconUrl.eraser;

  String get undoIconUrl => IconUrl.undo;

  String get squareImageUrl => ImageUrl.square;

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
    strokes.add(strokeReducerService.reduce(stroke));
  }

  void clearStrokes() {
    strokes.clear();
  }

  void undoTheLastStroke() {
    if (strokes.isNotEmpty) {
      strokes.removeLast();
    }
  }

  String getKanaId() {
    final isOk = kanaCheckerService.checkKana(kanaToWrite.id, kanaToWrite.maxStrokes, normalizedStrokes());
    return isOk ? kanaToWrite.id : '';
  }

  List<List<Offset>> normalizedStrokes() {
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
